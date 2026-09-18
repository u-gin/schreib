import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:schreib/models/entry.dart';
import 'package:schreib/models/prompt.dart';
import 'package:schreib/models/streak.dart';
import 'package:schreib/providers/entry_providers.dart';
import 'package:schreib/providers/prompt_providers.dart';
import 'package:schreib/theme/app_colors.dart';

/// Today's writing: one prompt, one entry, one commit.
class WriteScreen extends ConsumerStatefulWidget {
  const WriteScreen({super.key});

  @override
  ConsumerState<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends ConsumerState<WriteScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  /// Set once today's entry has been loaded into the field, so that later
  /// stream emissions do not overwrite what is being typed.
  String? _loadedEntryId;

  bool _saving = false;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  int get _remaining => Entry.maxLength - _controller.text.trim().length;
  bool get _hasText => _controller.text.trim().isNotEmpty;

  Future<void> _commit(Entry? existing) async {
    if (!_hasText || _saving) return;
    setState(() => _saving = true);

    final composer = ref.read(entryComposerProvider.notifier);
    final promptId = ref.read(todaysPromptProvider).id;
    final messenger = ScaffoldMessenger.of(context);

    try {
      if (existing == null) {
        await composer.commit(_controller.text, promptId: promptId);
      } else {
        await composer.revise(existing.id, _controller.text);
      }
      _focusNode.unfocus();
      messenger.showSnackBar(
        _toast(existing == null ? 'Committed' : 'Revised'),
      );
    } on ArgumentError catch (e) {
      messenger.showSnackBar(_toast(e.message.toString()));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  SnackBar _toast(String message) => SnackBar(
    content: Text(
      message,
      style: GoogleFonts.inter(fontWeight: FontWeight.w500),
    ),
    backgroundColor: Colors.black87,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    margin: const EdgeInsets.all(20),
    duration: const Duration(seconds: 2),
  );

  @override
  Widget build(BuildContext context) {
    final prompt = ref.watch(todaysPromptProvider);
    final streak = ref.watch(streakProvider);
    final todaysEntry = ref.watch(todaysEntryProvider).value;

    // Load an existing entry into the field once, never on every emission:
    // re-syncing on each stream event would fight the keyboard.
    if (todaysEntry != null && _loadedEntryId != todaysEntry.id) {
      _loadedEntryId = todaysEntry.id;
      _controller.text = todaysEntry.body;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Header(streak: streak),
                  const SizedBox(height: 28),
                  _PromptCard(prompt: prompt),
                  const SizedBox(height: 24),
                  _composer(),
                  const SizedBox(height: 12),
                  _footer(todaysEntry),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _composer() {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      autofocus: false,
      maxLines: 6,
      minLines: 4,
      // A hard stop rather than a warning after the fact: the limit is what
      // keeps a daily entry to two minutes, so it should be felt as a shape
      // to write into, not a rule to trip over.
      maxLength: Entry.maxLength,
      buildCounter:
          (_, {required currentLength, required isFocused, maxLength}) => null,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.multiline,
      inputFormatters: [LengthLimitingTextInputFormatter(Entry.maxLength)],
      onChanged: (_) => setState(() {}),
      style: GoogleFonts.inter(
        fontSize: 17,
        fontWeight: FontWeight.w500,
        height: 1.55,
        color: Colors.black87,
      ),
      decoration: InputDecoration(
        hintText: 'Write today’s line…',
        hintStyle: GoogleFonts.inter(
          fontSize: 16,
          color: Colors.black26,
          height: 1.55,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.black.withValues(alpha: 0.07)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.black54, width: 1.2),
        ),
      ),
    );
  }

  Widget _footer(Entry? todaysEntry) {
    final low = _remaining <= 40;
    final committed = todaysEntry != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '$_remaining left',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: low
                    ? Colors.redAccent.withValues(alpha: 0.85)
                    : Colors.black.withValues(alpha: 0.40),
              ),
            ),
            const Spacer(),
            // Private by default, stated rather than assumed: people only
            // write daily if they know nobody is reading.
            Icon(
              Icons.lock_outline,
              size: 13,
              color: Colors.black.withValues(alpha: 0.35),
            ),
            const SizedBox(width: 5),
            Text(
              'Only you',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black.withValues(alpha: 0.40),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: _hasText && !_saving ? () => _commit(todaysEntry) : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black87,
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.black.withValues(alpha: 0.12),
              disabledForegroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              committed ? 'Revise' : 'Commit',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
        if (committed) ...[
          const SizedBox(height: 12),
          Text(
            todaysEntry.wasEdited
                ? 'Committed today · revised ${todaysEntry.revisionCount}×'
                : 'Committed today',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black.withValues(alpha: 0.40),
            ),
          ),
        ],
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.streak});

  final Streak streak;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => context.go('/'),
          child: Text(
            'Today',
            style: GoogleFonts.inter(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
              color: Colors.black87,
            ),
          ),
        ),
        const Spacer(),
        if (streak.isAlive)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              streak.current == 1 ? '1 day' : '${streak.current} days',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black.withValues(alpha: 0.65),
              ),
            ),
          ),
      ],
    );
  }
}

class _PromptCard extends StatelessWidget {
  const _PromptCard({required this.prompt});

  final Prompt prompt;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '“${prompt.text}”',
          style: GoogleFonts.inter(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            height: 1.45,
            letterSpacing: -0.2,
            color: Colors.black87,
          ),
        ),
        if (prompt.isAttributed) ...[
          const SizedBox(height: 8),
          Text(
            '— ${prompt.attributedTo}',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
              color: Colors.black.withValues(alpha: 0.55),
            ),
          ),
        ],
      ],
    );
  }
}
