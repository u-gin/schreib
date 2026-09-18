import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:schreib/data/prompts.dart';
import 'package:schreib/models/prompt.dart';
import 'package:schreib/providers/entry_providers.dart';

part 'prompt_providers.g.dart';

/// The prompt to write against today.
@riverpod
Prompt todaysPrompt(Ref ref) => promptForDay(ref.watch(todayProvider));
