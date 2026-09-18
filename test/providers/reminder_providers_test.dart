import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:schreib/models/reminder_time.dart';
import 'package:schreib/providers/reminder_providers.dart';

import '../support/fake_reminder_scheduler.dart';

void main() {
  late FakeReminderScheduler scheduler;
  late ProviderContainer container;

  setUp(() {
    scheduler = FakeReminderScheduler();
    container = ProviderContainer(
      overrides: [reminderSchedulerProvider.overrideWithValue(scheduler)],
    );
    addTearDown(container.dispose);
  });

  test('no reminder is set to begin with', () {
    expect(container.read(reminderSettingProvider), isNull);
  });

  test('enabling asks permission first, then schedules', () async {
    final ok = await container
        .read(reminderSettingProvider.notifier)
        .enable(const ReminderTime(20, 0));

    expect(ok, isTrue);
    expect(scheduler.permissionRequests, 1);
    expect(scheduler.active, const ReminderTime(20, 0));
    expect(container.read(reminderSettingProvider), const ReminderTime(20, 0));
  });

  test('a declined permission schedules nothing and changes nothing', () async {
    scheduler.permissionGranted = false;

    final ok = await container
        .read(reminderSettingProvider.notifier)
        .enable(const ReminderTime(20, 0));

    expect(ok, isFalse);
    expect(scheduler.scheduled, isEmpty);
    expect(
      container.read(reminderSettingProvider),
      isNull,
      reason: 'the app must not claim a reminder the OS will never deliver',
    );
  });

  test('changing the time replaces rather than stacks reminders', () async {
    final notifier = container.read(reminderSettingProvider.notifier);
    await notifier.enable(const ReminderTime(20, 0));
    await notifier.enable(const ReminderTime(7, 30));

    expect(container.read(reminderSettingProvider), const ReminderTime(7, 30));
    expect(await scheduler.nextReminder(), isNotNull);
  });

  test('disabling cancels and clears the setting', () async {
    final notifier = container.read(reminderSettingProvider.notifier);
    await notifier.enable(const ReminderTime(20, 0));

    await notifier.disable();

    expect(scheduler.cancelCount, greaterThan(0));
    expect(container.read(reminderSettingProvider), isNull);
    expect(await scheduler.nextReminder(), isNull);
  });

  test('the scheduler provider must be overridden', () {
    final bare = ProviderContainer();
    addTearDown(bare.dispose);
    expect(() => bare.read(reminderSchedulerProvider), throwsA(anything));
  });
}
