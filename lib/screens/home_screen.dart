import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schreib/data/quotes.dart';
import 'package:schreib/widgets/quote_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static Color colorFromHex(String colorCode) {
    final hexCode = colorCode.replaceAll('#', '');
    Color newColor = Color(int.parse('FF$hexCode', radix: 16));
    return newColor;
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Random _random = Random();

  late int _currentIndex;

  Map<String, String> get currentQuote => quotes[_currentIndex];

  void _nextQuote() {
    setState(() {
      // Avoid showing the same quote twice in a row.
      int next = _random.nextInt(quotes.length);
      while (quotes.length > 1 && next == _currentIndex) {
        next = _random.nextInt(quotes.length);
      }
      _currentIndex = next;
    });
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = _random.nextInt(quotes.length);
  }

  @override
  Widget build(BuildContext context) {
    final currentKey = ValueKey(_currentIndex);

    return GestureDetector(
      onTap: _nextQuote,
      child: Scaffold(
        backgroundColor: HomeScreen.colorFromHex('#F2F8FC'),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      'assets/images/logo.svg',
                      width: 70,
                      height: 70,
                      fit: BoxFit.contain,
                    ),

                    _NavItem(
                      label: 'Submit quote here!',
                      onTap: () {
                        // go, not push: an imperative push leaves the address
                        // bar on '/', so the page would not be linkable.
                        context.go('/submit');
                      },
                    ),
                  ],
                ),

                // Centred while the quote fits, scrollable once it doesn't.
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 320),
                        switchInCurve: Curves.easeOutCubic,
                        switchOutCurve: Curves.easeInCubic,
                        transitionBuilder: (child, animation) {
                          final isIncoming = child.key == currentKey;

                          // AnimatedSwitcher drives the outgoing child's
                          // animation from 1 -> 0, so both tweens run from
                          // off-screen (at 0) to centred (at 1); only the
                          // side differs.
                          final tween = Tween<Offset>(
                            begin: isIncoming
                                ? const Offset(1.0, 0.0)
                                : const Offset(-1.0, 0.0),
                            end: Offset.zero,
                          );

                          return ClipRect(
                            child: SlideTransition(
                              position: tween.animate(animation),
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            ),
                          );
                        },
                        child: KeyedSubtree(
                          key: currentKey,
                          child: quoteCard(context, currentQuote),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavItem({required this.label, required this.onTap});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 180),
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: _hovered ? FontWeight.w600 : FontWeight.w500,
            color: _hovered
                ? Colors.black.withValues(alpha: 0.85)
                : Colors.black.withValues(alpha: 0.45),
            letterSpacing: 0.1,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: _hovered
                  ? Colors.black.withValues(alpha: 0.05)
                  : Colors.black.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(widget.label),
            ),
          ),
        ),
      ),
    );
  }
}
