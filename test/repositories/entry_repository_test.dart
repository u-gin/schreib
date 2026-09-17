import 'package:drift/native.dart';

import 'package:schreib/data/app_database.dart';
import 'package:schreib/repositories/local_entry_repository.dart';

import '../support/fake_entry_repository.dart';
import 'entry_repository_contract.dart';

void main() {
  AppDatabase? database;
  FakeEntryRepository? fake;

  // The real store, on an in-memory SQLite database.
  runEntryRepositoryContract(
    'LocalEntryRepository',
    () {
      database = AppDatabase(NativeDatabase.memory());
      return LocalEntryRepository(database!);
    },
    tearDownEach: () {
      database?.close();
      database = null;
    },
  );

  // The test double, held to exactly the same contract.
  runEntryRepositoryContract(
    'FakeEntryRepository',
    () {
      fake = FakeEntryRepository();
      return fake!;
    },
    tearDownEach: () {
      fake?.dispose();
      fake = null;
    },
  );
}
