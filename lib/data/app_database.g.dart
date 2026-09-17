// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $EntriesTable extends Entries with TableInfo<$EntriesTable, EntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 300,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dayKeyMeta = const VerificationMeta('dayKey');
  @override
  late final GeneratedColumn<String> dayKey = GeneratedColumn<String>(
    'day_key',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 10,
      maxTextLength: 10,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tzOffsetMinutesMeta = const VerificationMeta(
    'tzOffsetMinutes',
  );
  @override
  late final GeneratedColumn<int> tzOffsetMinutes = GeneratedColumn<int>(
    'tz_offset_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _seriesIdMeta = const VerificationMeta(
    'seriesId',
  );
  @override
  late final GeneratedColumn<String> seriesId = GeneratedColumn<String>(
    'series_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _promptIdMeta = const VerificationMeta(
    'promptId',
  );
  @override
  late final GeneratedColumn<String> promptId = GeneratedColumn<String>(
    'prompt_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _revisionCountMeta = const VerificationMeta(
    'revisionCount',
  );
  @override
  late final GeneratedColumn<int> revisionCount = GeneratedColumn<int>(
    'revision_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  late final GeneratedColumnWithTypeConverter<StoredVisibility, int>
  visibility = GeneratedColumn<int>(
    'visibility',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  ).withConverter<StoredVisibility>($EntriesTable.$convertervisibility);
  @override
  late final GeneratedColumnWithTypeConverter<StoredSyncState, int> syncState =
      GeneratedColumn<int>(
        'sync_state',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<StoredSyncState>($EntriesTable.$convertersyncState);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    body,
    createdAt,
    dayKey,
    tzOffsetMinutes,
    seriesId,
    promptId,
    revisionCount,
    visibility,
    syncState,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<EntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('day_key')) {
      context.handle(
        _dayKeyMeta,
        dayKey.isAcceptableOrUnknown(data['day_key']!, _dayKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_dayKeyMeta);
    }
    if (data.containsKey('tz_offset_minutes')) {
      context.handle(
        _tzOffsetMinutesMeta,
        tzOffsetMinutes.isAcceptableOrUnknown(
          data['tz_offset_minutes']!,
          _tzOffsetMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_tzOffsetMinutesMeta);
    }
    if (data.containsKey('series_id')) {
      context.handle(
        _seriesIdMeta,
        seriesId.isAcceptableOrUnknown(data['series_id']!, _seriesIdMeta),
      );
    }
    if (data.containsKey('prompt_id')) {
      context.handle(
        _promptIdMeta,
        promptId.isAcceptableOrUnknown(data['prompt_id']!, _promptIdMeta),
      );
    }
    if (data.containsKey('revision_count')) {
      context.handle(
        _revisionCountMeta,
        revisionCount.isAcceptableOrUnknown(
          data['revision_count']!,
          _revisionCountMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      dayKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}day_key'],
      )!,
      tzOffsetMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tz_offset_minutes'],
      )!,
      seriesId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}series_id'],
      ),
      promptId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prompt_id'],
      ),
      revisionCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revision_count'],
      )!,
      visibility: $EntriesTable.$convertervisibility.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}visibility'],
        )!,
      ),
      syncState: $EntriesTable.$convertersyncState.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}sync_state'],
        )!,
      ),
    );
  }

  @override
  $EntriesTable createAlias(String alias) {
    return $EntriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<StoredVisibility, int, int> $convertervisibility =
      const EnumIndexConverter<StoredVisibility>(StoredVisibility.values);
  static JsonTypeConverter2<StoredSyncState, int, int> $convertersyncState =
      const EnumIndexConverter<StoredSyncState>(StoredSyncState.values);
}

class EntryRow extends DataClass implements Insertable<EntryRow> {
  final String id;
  final String body;
  final DateTime createdAt;
  final String dayKey;
  final int tzOffsetMinutes;
  final String? seriesId;
  final String? promptId;
  final int revisionCount;
  final StoredVisibility visibility;
  final StoredSyncState syncState;
  const EntryRow({
    required this.id,
    required this.body,
    required this.createdAt,
    required this.dayKey,
    required this.tzOffsetMinutes,
    this.seriesId,
    this.promptId,
    required this.revisionCount,
    required this.visibility,
    required this.syncState,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['body'] = Variable<String>(body);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['day_key'] = Variable<String>(dayKey);
    map['tz_offset_minutes'] = Variable<int>(tzOffsetMinutes);
    if (!nullToAbsent || seriesId != null) {
      map['series_id'] = Variable<String>(seriesId);
    }
    if (!nullToAbsent || promptId != null) {
      map['prompt_id'] = Variable<String>(promptId);
    }
    map['revision_count'] = Variable<int>(revisionCount);
    {
      map['visibility'] = Variable<int>(
        $EntriesTable.$convertervisibility.toSql(visibility),
      );
    }
    {
      map['sync_state'] = Variable<int>(
        $EntriesTable.$convertersyncState.toSql(syncState),
      );
    }
    return map;
  }

  EntriesCompanion toCompanion(bool nullToAbsent) {
    return EntriesCompanion(
      id: Value(id),
      body: Value(body),
      createdAt: Value(createdAt),
      dayKey: Value(dayKey),
      tzOffsetMinutes: Value(tzOffsetMinutes),
      seriesId: seriesId == null && nullToAbsent
          ? const Value.absent()
          : Value(seriesId),
      promptId: promptId == null && nullToAbsent
          ? const Value.absent()
          : Value(promptId),
      revisionCount: Value(revisionCount),
      visibility: Value(visibility),
      syncState: Value(syncState),
    );
  }

  factory EntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EntryRow(
      id: serializer.fromJson<String>(json['id']),
      body: serializer.fromJson<String>(json['body']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      dayKey: serializer.fromJson<String>(json['dayKey']),
      tzOffsetMinutes: serializer.fromJson<int>(json['tzOffsetMinutes']),
      seriesId: serializer.fromJson<String?>(json['seriesId']),
      promptId: serializer.fromJson<String?>(json['promptId']),
      revisionCount: serializer.fromJson<int>(json['revisionCount']),
      visibility: $EntriesTable.$convertervisibility.fromJson(
        serializer.fromJson<int>(json['visibility']),
      ),
      syncState: $EntriesTable.$convertersyncState.fromJson(
        serializer.fromJson<int>(json['syncState']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'body': serializer.toJson<String>(body),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'dayKey': serializer.toJson<String>(dayKey),
      'tzOffsetMinutes': serializer.toJson<int>(tzOffsetMinutes),
      'seriesId': serializer.toJson<String?>(seriesId),
      'promptId': serializer.toJson<String?>(promptId),
      'revisionCount': serializer.toJson<int>(revisionCount),
      'visibility': serializer.toJson<int>(
        $EntriesTable.$convertervisibility.toJson(visibility),
      ),
      'syncState': serializer.toJson<int>(
        $EntriesTable.$convertersyncState.toJson(syncState),
      ),
    };
  }

  EntryRow copyWith({
    String? id,
    String? body,
    DateTime? createdAt,
    String? dayKey,
    int? tzOffsetMinutes,
    Value<String?> seriesId = const Value.absent(),
    Value<String?> promptId = const Value.absent(),
    int? revisionCount,
    StoredVisibility? visibility,
    StoredSyncState? syncState,
  }) => EntryRow(
    id: id ?? this.id,
    body: body ?? this.body,
    createdAt: createdAt ?? this.createdAt,
    dayKey: dayKey ?? this.dayKey,
    tzOffsetMinutes: tzOffsetMinutes ?? this.tzOffsetMinutes,
    seriesId: seriesId.present ? seriesId.value : this.seriesId,
    promptId: promptId.present ? promptId.value : this.promptId,
    revisionCount: revisionCount ?? this.revisionCount,
    visibility: visibility ?? this.visibility,
    syncState: syncState ?? this.syncState,
  );
  EntryRow copyWithCompanion(EntriesCompanion data) {
    return EntryRow(
      id: data.id.present ? data.id.value : this.id,
      body: data.body.present ? data.body.value : this.body,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      dayKey: data.dayKey.present ? data.dayKey.value : this.dayKey,
      tzOffsetMinutes: data.tzOffsetMinutes.present
          ? data.tzOffsetMinutes.value
          : this.tzOffsetMinutes,
      seriesId: data.seriesId.present ? data.seriesId.value : this.seriesId,
      promptId: data.promptId.present ? data.promptId.value : this.promptId,
      revisionCount: data.revisionCount.present
          ? data.revisionCount.value
          : this.revisionCount,
      visibility: data.visibility.present
          ? data.visibility.value
          : this.visibility,
      syncState: data.syncState.present ? data.syncState.value : this.syncState,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EntryRow(')
          ..write('id: $id, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt, ')
          ..write('dayKey: $dayKey, ')
          ..write('tzOffsetMinutes: $tzOffsetMinutes, ')
          ..write('seriesId: $seriesId, ')
          ..write('promptId: $promptId, ')
          ..write('revisionCount: $revisionCount, ')
          ..write('visibility: $visibility, ')
          ..write('syncState: $syncState')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    body,
    createdAt,
    dayKey,
    tzOffsetMinutes,
    seriesId,
    promptId,
    revisionCount,
    visibility,
    syncState,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EntryRow &&
          other.id == this.id &&
          other.body == this.body &&
          other.createdAt == this.createdAt &&
          other.dayKey == this.dayKey &&
          other.tzOffsetMinutes == this.tzOffsetMinutes &&
          other.seriesId == this.seriesId &&
          other.promptId == this.promptId &&
          other.revisionCount == this.revisionCount &&
          other.visibility == this.visibility &&
          other.syncState == this.syncState);
}

class EntriesCompanion extends UpdateCompanion<EntryRow> {
  final Value<String> id;
  final Value<String> body;
  final Value<DateTime> createdAt;
  final Value<String> dayKey;
  final Value<int> tzOffsetMinutes;
  final Value<String?> seriesId;
  final Value<String?> promptId;
  final Value<int> revisionCount;
  final Value<StoredVisibility> visibility;
  final Value<StoredSyncState> syncState;
  final Value<int> rowid;
  const EntriesCompanion({
    this.id = const Value.absent(),
    this.body = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.dayKey = const Value.absent(),
    this.tzOffsetMinutes = const Value.absent(),
    this.seriesId = const Value.absent(),
    this.promptId = const Value.absent(),
    this.revisionCount = const Value.absent(),
    this.visibility = const Value.absent(),
    this.syncState = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EntriesCompanion.insert({
    required String id,
    required String body,
    required DateTime createdAt,
    required String dayKey,
    required int tzOffsetMinutes,
    this.seriesId = const Value.absent(),
    this.promptId = const Value.absent(),
    this.revisionCount = const Value.absent(),
    required StoredVisibility visibility,
    required StoredSyncState syncState,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       body = Value(body),
       createdAt = Value(createdAt),
       dayKey = Value(dayKey),
       tzOffsetMinutes = Value(tzOffsetMinutes),
       visibility = Value(visibility),
       syncState = Value(syncState);
  static Insertable<EntryRow> custom({
    Expression<String>? id,
    Expression<String>? body,
    Expression<DateTime>? createdAt,
    Expression<String>? dayKey,
    Expression<int>? tzOffsetMinutes,
    Expression<String>? seriesId,
    Expression<String>? promptId,
    Expression<int>? revisionCount,
    Expression<int>? visibility,
    Expression<int>? syncState,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (body != null) 'body': body,
      if (createdAt != null) 'created_at': createdAt,
      if (dayKey != null) 'day_key': dayKey,
      if (tzOffsetMinutes != null) 'tz_offset_minutes': tzOffsetMinutes,
      if (seriesId != null) 'series_id': seriesId,
      if (promptId != null) 'prompt_id': promptId,
      if (revisionCount != null) 'revision_count': revisionCount,
      if (visibility != null) 'visibility': visibility,
      if (syncState != null) 'sync_state': syncState,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? body,
    Value<DateTime>? createdAt,
    Value<String>? dayKey,
    Value<int>? tzOffsetMinutes,
    Value<String?>? seriesId,
    Value<String?>? promptId,
    Value<int>? revisionCount,
    Value<StoredVisibility>? visibility,
    Value<StoredSyncState>? syncState,
    Value<int>? rowid,
  }) {
    return EntriesCompanion(
      id: id ?? this.id,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
      dayKey: dayKey ?? this.dayKey,
      tzOffsetMinutes: tzOffsetMinutes ?? this.tzOffsetMinutes,
      seriesId: seriesId ?? this.seriesId,
      promptId: promptId ?? this.promptId,
      revisionCount: revisionCount ?? this.revisionCount,
      visibility: visibility ?? this.visibility,
      syncState: syncState ?? this.syncState,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (dayKey.present) {
      map['day_key'] = Variable<String>(dayKey.value);
    }
    if (tzOffsetMinutes.present) {
      map['tz_offset_minutes'] = Variable<int>(tzOffsetMinutes.value);
    }
    if (seriesId.present) {
      map['series_id'] = Variable<String>(seriesId.value);
    }
    if (promptId.present) {
      map['prompt_id'] = Variable<String>(promptId.value);
    }
    if (revisionCount.present) {
      map['revision_count'] = Variable<int>(revisionCount.value);
    }
    if (visibility.present) {
      map['visibility'] = Variable<int>(
        $EntriesTable.$convertervisibility.toSql(visibility.value),
      );
    }
    if (syncState.present) {
      map['sync_state'] = Variable<int>(
        $EntriesTable.$convertersyncState.toSql(syncState.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntriesCompanion(')
          ..write('id: $id, ')
          ..write('body: $body, ')
          ..write('createdAt: $createdAt, ')
          ..write('dayKey: $dayKey, ')
          ..write('tzOffsetMinutes: $tzOffsetMinutes, ')
          ..write('seriesId: $seriesId, ')
          ..write('promptId: $promptId, ')
          ..write('revisionCount: $revisionCount, ')
          ..write('visibility: $visibility, ')
          ..write('syncState: $syncState, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RevisionsTable extends Revisions
    with TableInfo<$RevisionsTable, RevisionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RevisionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entryIdMeta = const VerificationMeta(
    'entryId',
  );
  @override
  late final GeneratedColumn<String> entryId = GeneratedColumn<String>(
    'entry_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES entries (id)',
    ),
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sequenceMeta = const VerificationMeta(
    'sequence',
  );
  @override
  late final GeneratedColumn<int> sequence = GeneratedColumn<int>(
    'sequence',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _replacedAtMeta = const VerificationMeta(
    'replacedAt',
  );
  @override
  late final GeneratedColumn<DateTime> replacedAt = GeneratedColumn<DateTime>(
    'replaced_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entryId,
    body,
    sequence,
    replacedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'revisions';
  @override
  VerificationContext validateIntegrity(
    Insertable<RevisionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('entry_id')) {
      context.handle(
        _entryIdMeta,
        entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('sequence')) {
      context.handle(
        _sequenceMeta,
        sequence.isAcceptableOrUnknown(data['sequence']!, _sequenceMeta),
      );
    } else if (isInserting) {
      context.missing(_sequenceMeta);
    }
    if (data.containsKey('replaced_at')) {
      context.handle(
        _replacedAtMeta,
        replacedAt.isAcceptableOrUnknown(data['replaced_at']!, _replacedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_replacedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RevisionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RevisionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      entryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entry_id'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      sequence: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sequence'],
      )!,
      replacedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}replaced_at'],
      )!,
    );
  }

  @override
  $RevisionsTable createAlias(String alias) {
    return $RevisionsTable(attachedDatabase, alias);
  }
}

class RevisionRow extends DataClass implements Insertable<RevisionRow> {
  final String id;
  final String entryId;
  final String body;
  final int sequence;
  final DateTime replacedAt;
  const RevisionRow({
    required this.id,
    required this.entryId,
    required this.body,
    required this.sequence,
    required this.replacedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['entry_id'] = Variable<String>(entryId);
    map['body'] = Variable<String>(body);
    map['sequence'] = Variable<int>(sequence);
    map['replaced_at'] = Variable<DateTime>(replacedAt);
    return map;
  }

  RevisionsCompanion toCompanion(bool nullToAbsent) {
    return RevisionsCompanion(
      id: Value(id),
      entryId: Value(entryId),
      body: Value(body),
      sequence: Value(sequence),
      replacedAt: Value(replacedAt),
    );
  }

  factory RevisionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RevisionRow(
      id: serializer.fromJson<String>(json['id']),
      entryId: serializer.fromJson<String>(json['entryId']),
      body: serializer.fromJson<String>(json['body']),
      sequence: serializer.fromJson<int>(json['sequence']),
      replacedAt: serializer.fromJson<DateTime>(json['replacedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'entryId': serializer.toJson<String>(entryId),
      'body': serializer.toJson<String>(body),
      'sequence': serializer.toJson<int>(sequence),
      'replacedAt': serializer.toJson<DateTime>(replacedAt),
    };
  }

  RevisionRow copyWith({
    String? id,
    String? entryId,
    String? body,
    int? sequence,
    DateTime? replacedAt,
  }) => RevisionRow(
    id: id ?? this.id,
    entryId: entryId ?? this.entryId,
    body: body ?? this.body,
    sequence: sequence ?? this.sequence,
    replacedAt: replacedAt ?? this.replacedAt,
  );
  RevisionRow copyWithCompanion(RevisionsCompanion data) {
    return RevisionRow(
      id: data.id.present ? data.id.value : this.id,
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
      body: data.body.present ? data.body.value : this.body,
      sequence: data.sequence.present ? data.sequence.value : this.sequence,
      replacedAt: data.replacedAt.present
          ? data.replacedAt.value
          : this.replacedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RevisionRow(')
          ..write('id: $id, ')
          ..write('entryId: $entryId, ')
          ..write('body: $body, ')
          ..write('sequence: $sequence, ')
          ..write('replacedAt: $replacedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, entryId, body, sequence, replacedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RevisionRow &&
          other.id == this.id &&
          other.entryId == this.entryId &&
          other.body == this.body &&
          other.sequence == this.sequence &&
          other.replacedAt == this.replacedAt);
}

class RevisionsCompanion extends UpdateCompanion<RevisionRow> {
  final Value<String> id;
  final Value<String> entryId;
  final Value<String> body;
  final Value<int> sequence;
  final Value<DateTime> replacedAt;
  final Value<int> rowid;
  const RevisionsCompanion({
    this.id = const Value.absent(),
    this.entryId = const Value.absent(),
    this.body = const Value.absent(),
    this.sequence = const Value.absent(),
    this.replacedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RevisionsCompanion.insert({
    required String id,
    required String entryId,
    required String body,
    required int sequence,
    required DateTime replacedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       entryId = Value(entryId),
       body = Value(body),
       sequence = Value(sequence),
       replacedAt = Value(replacedAt);
  static Insertable<RevisionRow> custom({
    Expression<String>? id,
    Expression<String>? entryId,
    Expression<String>? body,
    Expression<int>? sequence,
    Expression<DateTime>? replacedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entryId != null) 'entry_id': entryId,
      if (body != null) 'body': body,
      if (sequence != null) 'sequence': sequence,
      if (replacedAt != null) 'replaced_at': replacedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RevisionsCompanion copyWith({
    Value<String>? id,
    Value<String>? entryId,
    Value<String>? body,
    Value<int>? sequence,
    Value<DateTime>? replacedAt,
    Value<int>? rowid,
  }) {
    return RevisionsCompanion(
      id: id ?? this.id,
      entryId: entryId ?? this.entryId,
      body: body ?? this.body,
      sequence: sequence ?? this.sequence,
      replacedAt: replacedAt ?? this.replacedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (entryId.present) {
      map['entry_id'] = Variable<String>(entryId.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (sequence.present) {
      map['sequence'] = Variable<int>(sequence.value);
    }
    if (replacedAt.present) {
      map['replaced_at'] = Variable<DateTime>(replacedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RevisionsCompanion(')
          ..write('id: $id, ')
          ..write('entryId: $entryId, ')
          ..write('body: $body, ')
          ..write('sequence: $sequence, ')
          ..write('replacedAt: $replacedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SeriesTableTable extends SeriesTable
    with TableInfo<$SeriesTableTable, SeriesRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SeriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cadenceKindMeta = const VerificationMeta(
    'cadenceKind',
  );
  @override
  late final GeneratedColumn<int> cadenceKind = GeneratedColumn<int>(
    'cadence_kind',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cadenceWeekdayMeta = const VerificationMeta(
    'cadenceWeekday',
  );
  @override
  late final GeneratedColumn<int> cadenceWeekday = GeneratedColumn<int>(
    'cadence_weekday',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<StoredVisibility, int>
  visibility = GeneratedColumn<int>(
    'visibility',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  ).withConverter<StoredVisibility>($SeriesTableTable.$convertervisibility);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    cadenceKind,
    cadenceWeekday,
    createdAt,
    visibility,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'series';
  @override
  VerificationContext validateIntegrity(
    Insertable<SeriesRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('cadence_kind')) {
      context.handle(
        _cadenceKindMeta,
        cadenceKind.isAcceptableOrUnknown(
          data['cadence_kind']!,
          _cadenceKindMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cadenceKindMeta);
    }
    if (data.containsKey('cadence_weekday')) {
      context.handle(
        _cadenceWeekdayMeta,
        cadenceWeekday.isAcceptableOrUnknown(
          data['cadence_weekday']!,
          _cadenceWeekdayMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SeriesRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SeriesRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      cadenceKind: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cadence_kind'],
      )!,
      cadenceWeekday: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cadence_weekday'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      visibility: $SeriesTableTable.$convertervisibility.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}visibility'],
        )!,
      ),
    );
  }

  @override
  $SeriesTableTable createAlias(String alias) {
    return $SeriesTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<StoredVisibility, int, int> $convertervisibility =
      const EnumIndexConverter<StoredVisibility>(StoredVisibility.values);
}

class SeriesRow extends DataClass implements Insertable<SeriesRow> {
  final String id;
  final String title;
  final String? description;
  final int cadenceKind;
  final int? cadenceWeekday;
  final DateTime createdAt;
  final StoredVisibility visibility;
  const SeriesRow({
    required this.id,
    required this.title,
    this.description,
    required this.cadenceKind,
    this.cadenceWeekday,
    required this.createdAt,
    required this.visibility,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['cadence_kind'] = Variable<int>(cadenceKind);
    if (!nullToAbsent || cadenceWeekday != null) {
      map['cadence_weekday'] = Variable<int>(cadenceWeekday);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    {
      map['visibility'] = Variable<int>(
        $SeriesTableTable.$convertervisibility.toSql(visibility),
      );
    }
    return map;
  }

  SeriesTableCompanion toCompanion(bool nullToAbsent) {
    return SeriesTableCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      cadenceKind: Value(cadenceKind),
      cadenceWeekday: cadenceWeekday == null && nullToAbsent
          ? const Value.absent()
          : Value(cadenceWeekday),
      createdAt: Value(createdAt),
      visibility: Value(visibility),
    );
  }

  factory SeriesRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SeriesRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      cadenceKind: serializer.fromJson<int>(json['cadenceKind']),
      cadenceWeekday: serializer.fromJson<int?>(json['cadenceWeekday']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      visibility: $SeriesTableTable.$convertervisibility.fromJson(
        serializer.fromJson<int>(json['visibility']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'cadenceKind': serializer.toJson<int>(cadenceKind),
      'cadenceWeekday': serializer.toJson<int?>(cadenceWeekday),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'visibility': serializer.toJson<int>(
        $SeriesTableTable.$convertervisibility.toJson(visibility),
      ),
    };
  }

  SeriesRow copyWith({
    String? id,
    String? title,
    Value<String?> description = const Value.absent(),
    int? cadenceKind,
    Value<int?> cadenceWeekday = const Value.absent(),
    DateTime? createdAt,
    StoredVisibility? visibility,
  }) => SeriesRow(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    cadenceKind: cadenceKind ?? this.cadenceKind,
    cadenceWeekday: cadenceWeekday.present
        ? cadenceWeekday.value
        : this.cadenceWeekday,
    createdAt: createdAt ?? this.createdAt,
    visibility: visibility ?? this.visibility,
  );
  SeriesRow copyWithCompanion(SeriesTableCompanion data) {
    return SeriesRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      cadenceKind: data.cadenceKind.present
          ? data.cadenceKind.value
          : this.cadenceKind,
      cadenceWeekday: data.cadenceWeekday.present
          ? data.cadenceWeekday.value
          : this.cadenceWeekday,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      visibility: data.visibility.present
          ? data.visibility.value
          : this.visibility,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SeriesRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('cadenceKind: $cadenceKind, ')
          ..write('cadenceWeekday: $cadenceWeekday, ')
          ..write('createdAt: $createdAt, ')
          ..write('visibility: $visibility')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    cadenceKind,
    cadenceWeekday,
    createdAt,
    visibility,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SeriesRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.cadenceKind == this.cadenceKind &&
          other.cadenceWeekday == this.cadenceWeekday &&
          other.createdAt == this.createdAt &&
          other.visibility == this.visibility);
}

class SeriesTableCompanion extends UpdateCompanion<SeriesRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<int> cadenceKind;
  final Value<int?> cadenceWeekday;
  final Value<DateTime> createdAt;
  final Value<StoredVisibility> visibility;
  final Value<int> rowid;
  const SeriesTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.cadenceKind = const Value.absent(),
    this.cadenceWeekday = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.visibility = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SeriesTableCompanion.insert({
    required String id,
    required String title,
    this.description = const Value.absent(),
    required int cadenceKind,
    this.cadenceWeekday = const Value.absent(),
    required DateTime createdAt,
    required StoredVisibility visibility,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       cadenceKind = Value(cadenceKind),
       createdAt = Value(createdAt),
       visibility = Value(visibility);
  static Insertable<SeriesRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<int>? cadenceKind,
    Expression<int>? cadenceWeekday,
    Expression<DateTime>? createdAt,
    Expression<int>? visibility,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (cadenceKind != null) 'cadence_kind': cadenceKind,
      if (cadenceWeekday != null) 'cadence_weekday': cadenceWeekday,
      if (createdAt != null) 'created_at': createdAt,
      if (visibility != null) 'visibility': visibility,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SeriesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String?>? description,
    Value<int>? cadenceKind,
    Value<int?>? cadenceWeekday,
    Value<DateTime>? createdAt,
    Value<StoredVisibility>? visibility,
    Value<int>? rowid,
  }) {
    return SeriesTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      cadenceKind: cadenceKind ?? this.cadenceKind,
      cadenceWeekday: cadenceWeekday ?? this.cadenceWeekday,
      createdAt: createdAt ?? this.createdAt,
      visibility: visibility ?? this.visibility,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (cadenceKind.present) {
      map['cadence_kind'] = Variable<int>(cadenceKind.value);
    }
    if (cadenceWeekday.present) {
      map['cadence_weekday'] = Variable<int>(cadenceWeekday.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (visibility.present) {
      map['visibility'] = Variable<int>(
        $SeriesTableTable.$convertervisibility.toSql(visibility.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SeriesTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('cadenceKind: $cadenceKind, ')
          ..write('cadenceWeekday: $cadenceWeekday, ')
          ..write('createdAt: $createdAt, ')
          ..write('visibility: $visibility, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $EntriesTable entries = $EntriesTable(this);
  late final $RevisionsTable revisions = $RevisionsTable(this);
  late final $SeriesTableTable seriesTable = $SeriesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    entries,
    revisions,
    seriesTable,
  ];
}

typedef $$EntriesTableCreateCompanionBuilder =
    EntriesCompanion Function({
      required String id,
      required String body,
      required DateTime createdAt,
      required String dayKey,
      required int tzOffsetMinutes,
      Value<String?> seriesId,
      Value<String?> promptId,
      Value<int> revisionCount,
      required StoredVisibility visibility,
      required StoredSyncState syncState,
      Value<int> rowid,
    });
typedef $$EntriesTableUpdateCompanionBuilder =
    EntriesCompanion Function({
      Value<String> id,
      Value<String> body,
      Value<DateTime> createdAt,
      Value<String> dayKey,
      Value<int> tzOffsetMinutes,
      Value<String?> seriesId,
      Value<String?> promptId,
      Value<int> revisionCount,
      Value<StoredVisibility> visibility,
      Value<StoredSyncState> syncState,
      Value<int> rowid,
    });

final class $$EntriesTableReferences
    extends BaseReferences<_$AppDatabase, $EntriesTable, EntryRow> {
  $$EntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RevisionsTable, List<RevisionRow>>
  _revisionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.revisions,
    aliasName: $_aliasNameGenerator(db.entries.id, db.revisions.entryId),
  );

  $$RevisionsTableProcessedTableManager get revisionsRefs {
    final manager = $$RevisionsTableTableManager(
      $_db,
      $_db.revisions,
    ).filter((f) => f.entryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_revisionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EntriesTableFilterComposer
    extends Composer<_$AppDatabase, $EntriesTable> {
  $$EntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dayKey => $composableBuilder(
    column: $table.dayKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tzOffsetMinutes => $composableBuilder(
    column: $table.tzOffsetMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get seriesId => $composableBuilder(
    column: $table.seriesId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get promptId => $composableBuilder(
    column: $table.promptId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revisionCount => $composableBuilder(
    column: $table.revisionCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<StoredVisibility, StoredVisibility, int>
  get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<StoredSyncState, StoredSyncState, int>
  get syncState => $composableBuilder(
    column: $table.syncState,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  Expression<bool> revisionsRefs(
    Expression<bool> Function($$RevisionsTableFilterComposer f) f,
  ) {
    final $$RevisionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.revisions,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RevisionsTableFilterComposer(
            $db: $db,
            $table: $db.revisions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $EntriesTable> {
  $$EntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dayKey => $composableBuilder(
    column: $table.dayKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tzOffsetMinutes => $composableBuilder(
    column: $table.tzOffsetMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get seriesId => $composableBuilder(
    column: $table.seriesId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get promptId => $composableBuilder(
    column: $table.promptId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revisionCount => $composableBuilder(
    column: $table.revisionCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get syncState => $composableBuilder(
    column: $table.syncState,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EntriesTable> {
  $$EntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get dayKey =>
      $composableBuilder(column: $table.dayKey, builder: (column) => column);

  GeneratedColumn<int> get tzOffsetMinutes => $composableBuilder(
    column: $table.tzOffsetMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get seriesId =>
      $composableBuilder(column: $table.seriesId, builder: (column) => column);

  GeneratedColumn<String> get promptId =>
      $composableBuilder(column: $table.promptId, builder: (column) => column);

  GeneratedColumn<int> get revisionCount => $composableBuilder(
    column: $table.revisionCount,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<StoredVisibility, int> get visibility =>
      $composableBuilder(
        column: $table.visibility,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<StoredSyncState, int> get syncState =>
      $composableBuilder(column: $table.syncState, builder: (column) => column);

  Expression<T> revisionsRefs<T extends Object>(
    Expression<T> Function($$RevisionsTableAnnotationComposer a) f,
  ) {
    final $$RevisionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.revisions,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RevisionsTableAnnotationComposer(
            $db: $db,
            $table: $db.revisions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EntriesTable,
          EntryRow,
          $$EntriesTableFilterComposer,
          $$EntriesTableOrderingComposer,
          $$EntriesTableAnnotationComposer,
          $$EntriesTableCreateCompanionBuilder,
          $$EntriesTableUpdateCompanionBuilder,
          (EntryRow, $$EntriesTableReferences),
          EntryRow,
          PrefetchHooks Function({bool revisionsRefs})
        > {
  $$EntriesTableTableManager(_$AppDatabase db, $EntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> dayKey = const Value.absent(),
                Value<int> tzOffsetMinutes = const Value.absent(),
                Value<String?> seriesId = const Value.absent(),
                Value<String?> promptId = const Value.absent(),
                Value<int> revisionCount = const Value.absent(),
                Value<StoredVisibility> visibility = const Value.absent(),
                Value<StoredSyncState> syncState = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EntriesCompanion(
                id: id,
                body: body,
                createdAt: createdAt,
                dayKey: dayKey,
                tzOffsetMinutes: tzOffsetMinutes,
                seriesId: seriesId,
                promptId: promptId,
                revisionCount: revisionCount,
                visibility: visibility,
                syncState: syncState,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String body,
                required DateTime createdAt,
                required String dayKey,
                required int tzOffsetMinutes,
                Value<String?> seriesId = const Value.absent(),
                Value<String?> promptId = const Value.absent(),
                Value<int> revisionCount = const Value.absent(),
                required StoredVisibility visibility,
                required StoredSyncState syncState,
                Value<int> rowid = const Value.absent(),
              }) => EntriesCompanion.insert(
                id: id,
                body: body,
                createdAt: createdAt,
                dayKey: dayKey,
                tzOffsetMinutes: tzOffsetMinutes,
                seriesId: seriesId,
                promptId: promptId,
                revisionCount: revisionCount,
                visibility: visibility,
                syncState: syncState,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({revisionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (revisionsRefs) db.revisions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (revisionsRefs)
                    await $_getPrefetchedData<
                      EntryRow,
                      $EntriesTable,
                      RevisionRow
                    >(
                      currentTable: table,
                      referencedTable: $$EntriesTableReferences
                          ._revisionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$EntriesTableReferences(db, table, p0).revisionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.entryId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$EntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EntriesTable,
      EntryRow,
      $$EntriesTableFilterComposer,
      $$EntriesTableOrderingComposer,
      $$EntriesTableAnnotationComposer,
      $$EntriesTableCreateCompanionBuilder,
      $$EntriesTableUpdateCompanionBuilder,
      (EntryRow, $$EntriesTableReferences),
      EntryRow,
      PrefetchHooks Function({bool revisionsRefs})
    >;
typedef $$RevisionsTableCreateCompanionBuilder =
    RevisionsCompanion Function({
      required String id,
      required String entryId,
      required String body,
      required int sequence,
      required DateTime replacedAt,
      Value<int> rowid,
    });
typedef $$RevisionsTableUpdateCompanionBuilder =
    RevisionsCompanion Function({
      Value<String> id,
      Value<String> entryId,
      Value<String> body,
      Value<int> sequence,
      Value<DateTime> replacedAt,
      Value<int> rowid,
    });

final class $$RevisionsTableReferences
    extends BaseReferences<_$AppDatabase, $RevisionsTable, RevisionRow> {
  $$RevisionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EntriesTable _entryIdTable(_$AppDatabase db) => db.entries
      .createAlias($_aliasNameGenerator(db.revisions.entryId, db.entries.id));

  $$EntriesTableProcessedTableManager get entryId {
    final $_column = $_itemColumn<String>('entry_id')!;

    final manager = $$EntriesTableTableManager(
      $_db,
      $_db.entries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RevisionsTableFilterComposer
    extends Composer<_$AppDatabase, $RevisionsTable> {
  $$RevisionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sequence => $composableBuilder(
    column: $table.sequence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get replacedAt => $composableBuilder(
    column: $table.replacedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$EntriesTableFilterComposer get entryId {
    final $$EntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.entries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntriesTableFilterComposer(
            $db: $db,
            $table: $db.entries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RevisionsTableOrderingComposer
    extends Composer<_$AppDatabase, $RevisionsTable> {
  $$RevisionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sequence => $composableBuilder(
    column: $table.sequence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get replacedAt => $composableBuilder(
    column: $table.replacedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$EntriesTableOrderingComposer get entryId {
    final $$EntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.entries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntriesTableOrderingComposer(
            $db: $db,
            $table: $db.entries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RevisionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RevisionsTable> {
  $$RevisionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<int> get sequence =>
      $composableBuilder(column: $table.sequence, builder: (column) => column);

  GeneratedColumn<DateTime> get replacedAt => $composableBuilder(
    column: $table.replacedAt,
    builder: (column) => column,
  );

  $$EntriesTableAnnotationComposer get entryId {
    final $$EntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.entries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.entries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RevisionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RevisionsTable,
          RevisionRow,
          $$RevisionsTableFilterComposer,
          $$RevisionsTableOrderingComposer,
          $$RevisionsTableAnnotationComposer,
          $$RevisionsTableCreateCompanionBuilder,
          $$RevisionsTableUpdateCompanionBuilder,
          (RevisionRow, $$RevisionsTableReferences),
          RevisionRow,
          PrefetchHooks Function({bool entryId})
        > {
  $$RevisionsTableTableManager(_$AppDatabase db, $RevisionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RevisionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RevisionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RevisionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> entryId = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<int> sequence = const Value.absent(),
                Value<DateTime> replacedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RevisionsCompanion(
                id: id,
                entryId: entryId,
                body: body,
                sequence: sequence,
                replacedAt: replacedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String entryId,
                required String body,
                required int sequence,
                required DateTime replacedAt,
                Value<int> rowid = const Value.absent(),
              }) => RevisionsCompanion.insert(
                id: id,
                entryId: entryId,
                body: body,
                sequence: sequence,
                replacedAt: replacedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RevisionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({entryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (entryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.entryId,
                                referencedTable: $$RevisionsTableReferences
                                    ._entryIdTable(db),
                                referencedColumn: $$RevisionsTableReferences
                                    ._entryIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RevisionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RevisionsTable,
      RevisionRow,
      $$RevisionsTableFilterComposer,
      $$RevisionsTableOrderingComposer,
      $$RevisionsTableAnnotationComposer,
      $$RevisionsTableCreateCompanionBuilder,
      $$RevisionsTableUpdateCompanionBuilder,
      (RevisionRow, $$RevisionsTableReferences),
      RevisionRow,
      PrefetchHooks Function({bool entryId})
    >;
typedef $$SeriesTableTableCreateCompanionBuilder =
    SeriesTableCompanion Function({
      required String id,
      required String title,
      Value<String?> description,
      required int cadenceKind,
      Value<int?> cadenceWeekday,
      required DateTime createdAt,
      required StoredVisibility visibility,
      Value<int> rowid,
    });
typedef $$SeriesTableTableUpdateCompanionBuilder =
    SeriesTableCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String?> description,
      Value<int> cadenceKind,
      Value<int?> cadenceWeekday,
      Value<DateTime> createdAt,
      Value<StoredVisibility> visibility,
      Value<int> rowid,
    });

class $$SeriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $SeriesTableTable> {
  $$SeriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cadenceKind => $composableBuilder(
    column: $table.cadenceKind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cadenceWeekday => $composableBuilder(
    column: $table.cadenceWeekday,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<StoredVisibility, StoredVisibility, int>
  get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$SeriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SeriesTableTable> {
  $$SeriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cadenceKind => $composableBuilder(
    column: $table.cadenceKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cadenceWeekday => $composableBuilder(
    column: $table.cadenceWeekday,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get visibility => $composableBuilder(
    column: $table.visibility,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SeriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SeriesTableTable> {
  $$SeriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cadenceKind => $composableBuilder(
    column: $table.cadenceKind,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cadenceWeekday => $composableBuilder(
    column: $table.cadenceWeekday,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<StoredVisibility, int> get visibility =>
      $composableBuilder(
        column: $table.visibility,
        builder: (column) => column,
      );
}

class $$SeriesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SeriesTableTable,
          SeriesRow,
          $$SeriesTableTableFilterComposer,
          $$SeriesTableTableOrderingComposer,
          $$SeriesTableTableAnnotationComposer,
          $$SeriesTableTableCreateCompanionBuilder,
          $$SeriesTableTableUpdateCompanionBuilder,
          (
            SeriesRow,
            BaseReferences<_$AppDatabase, $SeriesTableTable, SeriesRow>,
          ),
          SeriesRow,
          PrefetchHooks Function()
        > {
  $$SeriesTableTableTableManager(_$AppDatabase db, $SeriesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SeriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SeriesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SeriesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> cadenceKind = const Value.absent(),
                Value<int?> cadenceWeekday = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<StoredVisibility> visibility = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SeriesTableCompanion(
                id: id,
                title: title,
                description: description,
                cadenceKind: cadenceKind,
                cadenceWeekday: cadenceWeekday,
                createdAt: createdAt,
                visibility: visibility,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<String?> description = const Value.absent(),
                required int cadenceKind,
                Value<int?> cadenceWeekday = const Value.absent(),
                required DateTime createdAt,
                required StoredVisibility visibility,
                Value<int> rowid = const Value.absent(),
              }) => SeriesTableCompanion.insert(
                id: id,
                title: title,
                description: description,
                cadenceKind: cadenceKind,
                cadenceWeekday: cadenceWeekday,
                createdAt: createdAt,
                visibility: visibility,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SeriesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SeriesTableTable,
      SeriesRow,
      $$SeriesTableTableFilterComposer,
      $$SeriesTableTableOrderingComposer,
      $$SeriesTableTableAnnotationComposer,
      $$SeriesTableTableCreateCompanionBuilder,
      $$SeriesTableTableUpdateCompanionBuilder,
      (SeriesRow, BaseReferences<_$AppDatabase, $SeriesTableTable, SeriesRow>),
      SeriesRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$EntriesTableTableManager get entries =>
      $$EntriesTableTableManager(_db, _db.entries);
  $$RevisionsTableTableManager get revisions =>
      $$RevisionsTableTableManager(_db, _db.revisions);
  $$SeriesTableTableTableManager get seriesTable =>
      $$SeriesTableTableTableManager(_db, _db.seriesTable);
}
