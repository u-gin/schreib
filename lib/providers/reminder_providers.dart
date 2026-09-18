import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:schreib/models/reminder_time.dart';
import 'package:schreib/notifications/reminder_scheduler.dart';

part 'reminder_providers.g.dart';

/// The seam for reminders, mirroring the entry store.
///
/// Unimplemented on purpose: `main` overrides it with a
/// [LocalReminderScheduler], tests override it with a fake, and nothing above
/// this line touches the notification plugin.
@Riverpod(keepAlive: true)
ReminderScheduler reminderScheduler(Ref ref) => throw UnimplementedError(
  'override reminderSchedulerProvider in ProviderScope',
);

/// The time the daily reminder is set for.
///
/// Holds the choice only; persisting it belongs with the settings screen that
/// does not exist yet.
@Riverpod(keepAlive: true)
class ReminderSetting extends _$ReminderSetting {
  @override
  ReminderTime? build() => null;

  /// Asks for permission, then schedules. Returns false if the user declined,
  /// leaving nothing scheduled and the setting unchanged.
  Future<bool> enable(ReminderTime time) async {
    final scheduler = ref.read(reminderSchedulerProvider);
    if (!await scheduler.requestPermission()) return false;

    await scheduler.scheduleDaily(time);
    state = time;
    return true;
  }

  Future<void> disable() async {
    await ref.read(reminderSchedulerProvider).cancel();
    state = null;
  }
}
