// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $DbUserProfilesTable extends DbUserProfiles
    with TableInfo<$DbUserProfilesTable, DbUserProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbUserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<BigInt> id = GeneratedColumn<BigInt>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Gender, String> gender =
      GeneratedColumn<String>(
        'gender',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Gender>($DbUserProfilesTable.$convertergender);
  @override
  late final GeneratedColumnWithTypeConverter<WorkoutFrequency, String>
  workoutFrequency = GeneratedColumn<String>(
    'workout_frequency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<WorkoutFrequency>(
    $DbUserProfilesTable.$converterworkoutFrequency,
  );
  static const VerificationMeta _isMetricMeta = const VerificationMeta(
    'isMetric',
  );
  @override
  late final GeneratedColumn<bool> isMetric = GeneratedColumn<bool>(
    'is_metric',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_metric" IN (0, 1))',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Diet, String> diet =
      GeneratedColumn<String>(
        'diet',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Diet>($DbUserProfilesTable.$converterdiet);
  static const VerificationMeta _isOnboardingCompleteMeta =
      const VerificationMeta('isOnboardingComplete');
  @override
  late final GeneratedColumn<bool> isOnboardingComplete = GeneratedColumn<bool>(
    'is_onboarding_complete',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_onboarding_complete" IN (0, 1))',
    ),
  );
  static const VerificationMeta _dobMeta = const VerificationMeta('dob');
  @override
  late final GeneratedColumn<DateTime> dob = GeneratedColumn<DateTime>(
    'dob',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gptApiKeyMeta = const VerificationMeta(
    'gptApiKey',
  );
  @override
  late final GeneratedColumn<String> gptApiKey = GeneratedColumn<String>(
    'gpt_api_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heightCmMeta = const VerificationMeta(
    'heightCm',
  );
  @override
  late final GeneratedColumn<double> heightCm = GeneratedColumn<double>(
    'height_cm',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightGoalKgMeta = const VerificationMeta(
    'weightGoalKg',
  );
  @override
  late final GeneratedColumn<double> weightGoalKg = GeneratedColumn<double>(
    'weight_goal_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gender,
    workoutFrequency,
    isMetric,
    diet,
    isOnboardingComplete,
    dob,
    gptApiKey,
    heightCm,
    weightKg,
    weightGoalKg,
    updatedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'db_user_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbUserProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('is_metric')) {
      context.handle(
        _isMetricMeta,
        isMetric.isAcceptableOrUnknown(data['is_metric']!, _isMetricMeta),
      );
    } else if (isInserting) {
      context.missing(_isMetricMeta);
    }
    if (data.containsKey('is_onboarding_complete')) {
      context.handle(
        _isOnboardingCompleteMeta,
        isOnboardingComplete.isAcceptableOrUnknown(
          data['is_onboarding_complete']!,
          _isOnboardingCompleteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isOnboardingCompleteMeta);
    }
    if (data.containsKey('dob')) {
      context.handle(
        _dobMeta,
        dob.isAcceptableOrUnknown(data['dob']!, _dobMeta),
      );
    } else if (isInserting) {
      context.missing(_dobMeta);
    }
    if (data.containsKey('gpt_api_key')) {
      context.handle(
        _gptApiKeyMeta,
        gptApiKey.isAcceptableOrUnknown(data['gpt_api_key']!, _gptApiKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_gptApiKeyMeta);
    }
    if (data.containsKey('height_cm')) {
      context.handle(
        _heightCmMeta,
        heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta),
      );
    } else if (isInserting) {
      context.missing(_heightCmMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('weight_goal_kg')) {
      context.handle(
        _weightGoalKgMeta,
        weightGoalKg.isAcceptableOrUnknown(
          data['weight_goal_kg']!,
          _weightGoalKgMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_weightGoalKgMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
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
  DbUserProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbUserProfile(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bigInt,
            data['${effectivePrefix}id'],
          )!,
      gender: $DbUserProfilesTable.$convertergender.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}gender'],
        )!,
      ),
      workoutFrequency: $DbUserProfilesTable.$converterworkoutFrequency.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}workout_frequency'],
        )!,
      ),
      isMetric:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_metric'],
          )!,
      diet: $DbUserProfilesTable.$converterdiet.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}diet'],
        )!,
      ),
      isOnboardingComplete:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_onboarding_complete'],
          )!,
      dob:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}dob'],
          )!,
      gptApiKey:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}gpt_api_key'],
          )!,
      heightCm:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}height_cm'],
          )!,
      weightKg:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}weight_kg'],
          )!,
      weightGoalKg:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}weight_goal_kg'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $DbUserProfilesTable createAlias(String alias) {
    return $DbUserProfilesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Gender, String, String> $convertergender =
      const EnumNameConverter<Gender>(Gender.values);
  static JsonTypeConverter2<WorkoutFrequency, String, String>
  $converterworkoutFrequency = const EnumNameConverter<WorkoutFrequency>(
    WorkoutFrequency.values,
  );
  static JsonTypeConverter2<Diet, String, String> $converterdiet =
      const EnumNameConverter<Diet>(Diet.values);
}

class DbUserProfile extends DataClass implements Insertable<DbUserProfile> {
  final BigInt id;
  final Gender gender;
  final WorkoutFrequency workoutFrequency;
  final bool isMetric;
  final Diet diet;
  final bool isOnboardingComplete;
  final DateTime dob;
  final String gptApiKey;
  final double heightCm;
  final double weightKg;
  final double weightGoalKg;
  final DateTime updatedAt;
  final DateTime createdAt;
  const DbUserProfile({
    required this.id,
    required this.gender,
    required this.workoutFrequency,
    required this.isMetric,
    required this.diet,
    required this.isOnboardingComplete,
    required this.dob,
    required this.gptApiKey,
    required this.heightCm,
    required this.weightKg,
    required this.weightGoalKg,
    required this.updatedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<BigInt>(id);
    {
      map['gender'] = Variable<String>(
        $DbUserProfilesTable.$convertergender.toSql(gender),
      );
    }
    {
      map['workout_frequency'] = Variable<String>(
        $DbUserProfilesTable.$converterworkoutFrequency.toSql(workoutFrequency),
      );
    }
    map['is_metric'] = Variable<bool>(isMetric);
    {
      map['diet'] = Variable<String>(
        $DbUserProfilesTable.$converterdiet.toSql(diet),
      );
    }
    map['is_onboarding_complete'] = Variable<bool>(isOnboardingComplete);
    map['dob'] = Variable<DateTime>(dob);
    map['gpt_api_key'] = Variable<String>(gptApiKey);
    map['height_cm'] = Variable<double>(heightCm);
    map['weight_kg'] = Variable<double>(weightKg);
    map['weight_goal_kg'] = Variable<double>(weightGoalKg);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DbUserProfilesCompanion toCompanion(bool nullToAbsent) {
    return DbUserProfilesCompanion(
      id: Value(id),
      gender: Value(gender),
      workoutFrequency: Value(workoutFrequency),
      isMetric: Value(isMetric),
      diet: Value(diet),
      isOnboardingComplete: Value(isOnboardingComplete),
      dob: Value(dob),
      gptApiKey: Value(gptApiKey),
      heightCm: Value(heightCm),
      weightKg: Value(weightKg),
      weightGoalKg: Value(weightGoalKg),
      updatedAt: Value(updatedAt),
      createdAt: Value(createdAt),
    );
  }

  factory DbUserProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbUserProfile(
      id: serializer.fromJson<BigInt>(json['id']),
      gender: $DbUserProfilesTable.$convertergender.fromJson(
        serializer.fromJson<String>(json['gender']),
      ),
      workoutFrequency: $DbUserProfilesTable.$converterworkoutFrequency
          .fromJson(serializer.fromJson<String>(json['workoutFrequency'])),
      isMetric: serializer.fromJson<bool>(json['isMetric']),
      diet: $DbUserProfilesTable.$converterdiet.fromJson(
        serializer.fromJson<String>(json['diet']),
      ),
      isOnboardingComplete: serializer.fromJson<bool>(
        json['isOnboardingComplete'],
      ),
      dob: serializer.fromJson<DateTime>(json['dob']),
      gptApiKey: serializer.fromJson<String>(json['gptApiKey']),
      heightCm: serializer.fromJson<double>(json['heightCm']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      weightGoalKg: serializer.fromJson<double>(json['weightGoalKg']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<BigInt>(id),
      'gender': serializer.toJson<String>(
        $DbUserProfilesTable.$convertergender.toJson(gender),
      ),
      'workoutFrequency': serializer.toJson<String>(
        $DbUserProfilesTable.$converterworkoutFrequency.toJson(
          workoutFrequency,
        ),
      ),
      'isMetric': serializer.toJson<bool>(isMetric),
      'diet': serializer.toJson<String>(
        $DbUserProfilesTable.$converterdiet.toJson(diet),
      ),
      'isOnboardingComplete': serializer.toJson<bool>(isOnboardingComplete),
      'dob': serializer.toJson<DateTime>(dob),
      'gptApiKey': serializer.toJson<String>(gptApiKey),
      'heightCm': serializer.toJson<double>(heightCm),
      'weightKg': serializer.toJson<double>(weightKg),
      'weightGoalKg': serializer.toJson<double>(weightGoalKg),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DbUserProfile copyWith({
    BigInt? id,
    Gender? gender,
    WorkoutFrequency? workoutFrequency,
    bool? isMetric,
    Diet? diet,
    bool? isOnboardingComplete,
    DateTime? dob,
    String? gptApiKey,
    double? heightCm,
    double? weightKg,
    double? weightGoalKg,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) => DbUserProfile(
    id: id ?? this.id,
    gender: gender ?? this.gender,
    workoutFrequency: workoutFrequency ?? this.workoutFrequency,
    isMetric: isMetric ?? this.isMetric,
    diet: diet ?? this.diet,
    isOnboardingComplete: isOnboardingComplete ?? this.isOnboardingComplete,
    dob: dob ?? this.dob,
    gptApiKey: gptApiKey ?? this.gptApiKey,
    heightCm: heightCm ?? this.heightCm,
    weightKg: weightKg ?? this.weightKg,
    weightGoalKg: weightGoalKg ?? this.weightGoalKg,
    updatedAt: updatedAt ?? this.updatedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  DbUserProfile copyWithCompanion(DbUserProfilesCompanion data) {
    return DbUserProfile(
      id: data.id.present ? data.id.value : this.id,
      gender: data.gender.present ? data.gender.value : this.gender,
      workoutFrequency:
          data.workoutFrequency.present
              ? data.workoutFrequency.value
              : this.workoutFrequency,
      isMetric: data.isMetric.present ? data.isMetric.value : this.isMetric,
      diet: data.diet.present ? data.diet.value : this.diet,
      isOnboardingComplete:
          data.isOnboardingComplete.present
              ? data.isOnboardingComplete.value
              : this.isOnboardingComplete,
      dob: data.dob.present ? data.dob.value : this.dob,
      gptApiKey: data.gptApiKey.present ? data.gptApiKey.value : this.gptApiKey,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      weightGoalKg:
          data.weightGoalKg.present
              ? data.weightGoalKg.value
              : this.weightGoalKg,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbUserProfile(')
          ..write('id: $id, ')
          ..write('gender: $gender, ')
          ..write('workoutFrequency: $workoutFrequency, ')
          ..write('isMetric: $isMetric, ')
          ..write('diet: $diet, ')
          ..write('isOnboardingComplete: $isOnboardingComplete, ')
          ..write('dob: $dob, ')
          ..write('gptApiKey: $gptApiKey, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('weightGoalKg: $weightGoalKg, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    gender,
    workoutFrequency,
    isMetric,
    diet,
    isOnboardingComplete,
    dob,
    gptApiKey,
    heightCm,
    weightKg,
    weightGoalKg,
    updatedAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbUserProfile &&
          other.id == this.id &&
          other.gender == this.gender &&
          other.workoutFrequency == this.workoutFrequency &&
          other.isMetric == this.isMetric &&
          other.diet == this.diet &&
          other.isOnboardingComplete == this.isOnboardingComplete &&
          other.dob == this.dob &&
          other.gptApiKey == this.gptApiKey &&
          other.heightCm == this.heightCm &&
          other.weightKg == this.weightKg &&
          other.weightGoalKg == this.weightGoalKg &&
          other.updatedAt == this.updatedAt &&
          other.createdAt == this.createdAt);
}

class DbUserProfilesCompanion extends UpdateCompanion<DbUserProfile> {
  final Value<BigInt> id;
  final Value<Gender> gender;
  final Value<WorkoutFrequency> workoutFrequency;
  final Value<bool> isMetric;
  final Value<Diet> diet;
  final Value<bool> isOnboardingComplete;
  final Value<DateTime> dob;
  final Value<String> gptApiKey;
  final Value<double> heightCm;
  final Value<double> weightKg;
  final Value<double> weightGoalKg;
  final Value<DateTime> updatedAt;
  final Value<DateTime> createdAt;
  const DbUserProfilesCompanion({
    this.id = const Value.absent(),
    this.gender = const Value.absent(),
    this.workoutFrequency = const Value.absent(),
    this.isMetric = const Value.absent(),
    this.diet = const Value.absent(),
    this.isOnboardingComplete = const Value.absent(),
    this.dob = const Value.absent(),
    this.gptApiKey = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.weightGoalKg = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DbUserProfilesCompanion.insert({
    this.id = const Value.absent(),
    required Gender gender,
    required WorkoutFrequency workoutFrequency,
    required bool isMetric,
    required Diet diet,
    required bool isOnboardingComplete,
    required DateTime dob,
    required String gptApiKey,
    required double heightCm,
    required double weightKg,
    required double weightGoalKg,
    required DateTime updatedAt,
    required DateTime createdAt,
  }) : gender = Value(gender),
       workoutFrequency = Value(workoutFrequency),
       isMetric = Value(isMetric),
       diet = Value(diet),
       isOnboardingComplete = Value(isOnboardingComplete),
       dob = Value(dob),
       gptApiKey = Value(gptApiKey),
       heightCm = Value(heightCm),
       weightKg = Value(weightKg),
       weightGoalKg = Value(weightGoalKg),
       updatedAt = Value(updatedAt),
       createdAt = Value(createdAt);
  static Insertable<DbUserProfile> custom({
    Expression<BigInt>? id,
    Expression<String>? gender,
    Expression<String>? workoutFrequency,
    Expression<bool>? isMetric,
    Expression<String>? diet,
    Expression<bool>? isOnboardingComplete,
    Expression<DateTime>? dob,
    Expression<String>? gptApiKey,
    Expression<double>? heightCm,
    Expression<double>? weightKg,
    Expression<double>? weightGoalKg,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gender != null) 'gender': gender,
      if (workoutFrequency != null) 'workout_frequency': workoutFrequency,
      if (isMetric != null) 'is_metric': isMetric,
      if (diet != null) 'diet': diet,
      if (isOnboardingComplete != null)
        'is_onboarding_complete': isOnboardingComplete,
      if (dob != null) 'dob': dob,
      if (gptApiKey != null) 'gpt_api_key': gptApiKey,
      if (heightCm != null) 'height_cm': heightCm,
      if (weightKg != null) 'weight_kg': weightKg,
      if (weightGoalKg != null) 'weight_goal_kg': weightGoalKg,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DbUserProfilesCompanion copyWith({
    Value<BigInt>? id,
    Value<Gender>? gender,
    Value<WorkoutFrequency>? workoutFrequency,
    Value<bool>? isMetric,
    Value<Diet>? diet,
    Value<bool>? isOnboardingComplete,
    Value<DateTime>? dob,
    Value<String>? gptApiKey,
    Value<double>? heightCm,
    Value<double>? weightKg,
    Value<double>? weightGoalKg,
    Value<DateTime>? updatedAt,
    Value<DateTime>? createdAt,
  }) {
    return DbUserProfilesCompanion(
      id: id ?? this.id,
      gender: gender ?? this.gender,
      workoutFrequency: workoutFrequency ?? this.workoutFrequency,
      isMetric: isMetric ?? this.isMetric,
      diet: diet ?? this.diet,
      isOnboardingComplete: isOnboardingComplete ?? this.isOnboardingComplete,
      dob: dob ?? this.dob,
      gptApiKey: gptApiKey ?? this.gptApiKey,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      weightGoalKg: weightGoalKg ?? this.weightGoalKg,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<BigInt>(id.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(
        $DbUserProfilesTable.$convertergender.toSql(gender.value),
      );
    }
    if (workoutFrequency.present) {
      map['workout_frequency'] = Variable<String>(
        $DbUserProfilesTable.$converterworkoutFrequency.toSql(
          workoutFrequency.value,
        ),
      );
    }
    if (isMetric.present) {
      map['is_metric'] = Variable<bool>(isMetric.value);
    }
    if (diet.present) {
      map['diet'] = Variable<String>(
        $DbUserProfilesTable.$converterdiet.toSql(diet.value),
      );
    }
    if (isOnboardingComplete.present) {
      map['is_onboarding_complete'] = Variable<bool>(
        isOnboardingComplete.value,
      );
    }
    if (dob.present) {
      map['dob'] = Variable<DateTime>(dob.value);
    }
    if (gptApiKey.present) {
      map['gpt_api_key'] = Variable<String>(gptApiKey.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<double>(heightCm.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (weightGoalKg.present) {
      map['weight_goal_kg'] = Variable<double>(weightGoalKg.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbUserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('gender: $gender, ')
          ..write('workoutFrequency: $workoutFrequency, ')
          ..write('isMetric: $isMetric, ')
          ..write('diet: $diet, ')
          ..write('isOnboardingComplete: $isOnboardingComplete, ')
          ..write('dob: $dob, ')
          ..write('gptApiKey: $gptApiKey, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('weightGoalKg: $weightGoalKg, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DbOnboardingDatasTable extends DbOnboardingDatas
    with TableInfo<$DbOnboardingDatasTable, DbOnboardingData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbOnboardingDatasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<BigInt> id = GeneratedColumn<BigInt>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<OnboardingStep, String>
  currentStep = GeneratedColumn<String>(
    'current_step',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<OnboardingStep>(
    $DbOnboardingDatasTable.$convertercurrentStep,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Gender?, String> gender =
      GeneratedColumn<String>(
        'gender',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<Gender?>($DbOnboardingDatasTable.$convertergendern);
  @override
  late final GeneratedColumnWithTypeConverter<WorkoutFrequency?, String>
  workoutFrequency = GeneratedColumn<String>(
    'workout_frequency',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<WorkoutFrequency?>(
    $DbOnboardingDatasTable.$converterworkoutFrequencyn,
  );
  static const VerificationMeta _isMetricMeta = const VerificationMeta(
    'isMetric',
  );
  @override
  late final GeneratedColumn<bool> isMetric = GeneratedColumn<bool>(
    'is_metric',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_metric" IN (0, 1))',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Diet?, String> diet =
      GeneratedColumn<String>(
        'diet',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<Diet?>($DbOnboardingDatasTable.$converterdietn);
  static const VerificationMeta _dobMeta = const VerificationMeta('dob');
  @override
  late final GeneratedColumn<DateTime> dob = GeneratedColumn<DateTime>(
    'dob',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gptApiKeyMeta = const VerificationMeta(
    'gptApiKey',
  );
  @override
  late final GeneratedColumn<String> gptApiKey = GeneratedColumn<String>(
    'gpt_api_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightCmMeta = const VerificationMeta(
    'heightCm',
  );
  @override
  late final GeneratedColumn<double> heightCm = GeneratedColumn<double>(
    'height_cm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightGoalKgMeta = const VerificationMeta(
    'weightGoalKg',
  );
  @override
  late final GeneratedColumn<double> weightGoalKg = GeneratedColumn<double>(
    'weight_goal_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    currentStep,
    gender,
    workoutFrequency,
    isMetric,
    diet,
    dob,
    gptApiKey,
    heightCm,
    weightKg,
    weightGoalKg,
    updatedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'db_onboarding_datas';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbOnboardingData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('is_metric')) {
      context.handle(
        _isMetricMeta,
        isMetric.isAcceptableOrUnknown(data['is_metric']!, _isMetricMeta),
      );
    }
    if (data.containsKey('dob')) {
      context.handle(
        _dobMeta,
        dob.isAcceptableOrUnknown(data['dob']!, _dobMeta),
      );
    }
    if (data.containsKey('gpt_api_key')) {
      context.handle(
        _gptApiKeyMeta,
        gptApiKey.isAcceptableOrUnknown(data['gpt_api_key']!, _gptApiKeyMeta),
      );
    }
    if (data.containsKey('height_cm')) {
      context.handle(
        _heightCmMeta,
        heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta),
      );
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    }
    if (data.containsKey('weight_goal_kg')) {
      context.handle(
        _weightGoalKgMeta,
        weightGoalKg.isAcceptableOrUnknown(
          data['weight_goal_kg']!,
          _weightGoalKgMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
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
  DbOnboardingData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbOnboardingData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bigInt,
            data['${effectivePrefix}id'],
          )!,
      currentStep: $DbOnboardingDatasTable.$convertercurrentStep.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}current_step'],
        )!,
      ),
      gender: $DbOnboardingDatasTable.$convertergendern.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}gender'],
        ),
      ),
      workoutFrequency: $DbOnboardingDatasTable.$converterworkoutFrequencyn
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}workout_frequency'],
            ),
          ),
      isMetric: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_metric'],
      ),
      diet: $DbOnboardingDatasTable.$converterdietn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}diet'],
        ),
      ),
      dob: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}dob'],
      ),
      gptApiKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gpt_api_key'],
      ),
      heightCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height_cm'],
      ),
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      ),
      weightGoalKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_goal_kg'],
      ),
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $DbOnboardingDatasTable createAlias(String alias) {
    return $DbOnboardingDatasTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<OnboardingStep, String, String>
  $convertercurrentStep = const EnumNameConverter<OnboardingStep>(
    OnboardingStep.values,
  );
  static JsonTypeConverter2<Gender, String, String> $convertergender =
      const EnumNameConverter<Gender>(Gender.values);
  static JsonTypeConverter2<Gender?, String?, String?> $convertergendern =
      JsonTypeConverter2.asNullable($convertergender);
  static JsonTypeConverter2<WorkoutFrequency, String, String>
  $converterworkoutFrequency = const EnumNameConverter<WorkoutFrequency>(
    WorkoutFrequency.values,
  );
  static JsonTypeConverter2<WorkoutFrequency?, String?, String?>
  $converterworkoutFrequencyn = JsonTypeConverter2.asNullable(
    $converterworkoutFrequency,
  );
  static JsonTypeConverter2<Diet, String, String> $converterdiet =
      const EnumNameConverter<Diet>(Diet.values);
  static JsonTypeConverter2<Diet?, String?, String?> $converterdietn =
      JsonTypeConverter2.asNullable($converterdiet);
}

class DbOnboardingData extends DataClass
    implements Insertable<DbOnboardingData> {
  final BigInt id;
  final OnboardingStep currentStep;
  final Gender? gender;
  final WorkoutFrequency? workoutFrequency;
  final bool? isMetric;
  final Diet? diet;
  final DateTime? dob;
  final String? gptApiKey;
  final double? heightCm;
  final double? weightKg;
  final double? weightGoalKg;
  final DateTime updatedAt;
  final DateTime createdAt;
  const DbOnboardingData({
    required this.id,
    required this.currentStep,
    this.gender,
    this.workoutFrequency,
    this.isMetric,
    this.diet,
    this.dob,
    this.gptApiKey,
    this.heightCm,
    this.weightKg,
    this.weightGoalKg,
    required this.updatedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<BigInt>(id);
    {
      map['current_step'] = Variable<String>(
        $DbOnboardingDatasTable.$convertercurrentStep.toSql(currentStep),
      );
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(
        $DbOnboardingDatasTable.$convertergendern.toSql(gender),
      );
    }
    if (!nullToAbsent || workoutFrequency != null) {
      map['workout_frequency'] = Variable<String>(
        $DbOnboardingDatasTable.$converterworkoutFrequencyn.toSql(
          workoutFrequency,
        ),
      );
    }
    if (!nullToAbsent || isMetric != null) {
      map['is_metric'] = Variable<bool>(isMetric);
    }
    if (!nullToAbsent || diet != null) {
      map['diet'] = Variable<String>(
        $DbOnboardingDatasTable.$converterdietn.toSql(diet),
      );
    }
    if (!nullToAbsent || dob != null) {
      map['dob'] = Variable<DateTime>(dob);
    }
    if (!nullToAbsent || gptApiKey != null) {
      map['gpt_api_key'] = Variable<String>(gptApiKey);
    }
    if (!nullToAbsent || heightCm != null) {
      map['height_cm'] = Variable<double>(heightCm);
    }
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    if (!nullToAbsent || weightGoalKg != null) {
      map['weight_goal_kg'] = Variable<double>(weightGoalKg);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DbOnboardingDatasCompanion toCompanion(bool nullToAbsent) {
    return DbOnboardingDatasCompanion(
      id: Value(id),
      currentStep: Value(currentStep),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      workoutFrequency:
          workoutFrequency == null && nullToAbsent
              ? const Value.absent()
              : Value(workoutFrequency),
      isMetric:
          isMetric == null && nullToAbsent
              ? const Value.absent()
              : Value(isMetric),
      diet: diet == null && nullToAbsent ? const Value.absent() : Value(diet),
      dob: dob == null && nullToAbsent ? const Value.absent() : Value(dob),
      gptApiKey:
          gptApiKey == null && nullToAbsent
              ? const Value.absent()
              : Value(gptApiKey),
      heightCm:
          heightCm == null && nullToAbsent
              ? const Value.absent()
              : Value(heightCm),
      weightKg:
          weightKg == null && nullToAbsent
              ? const Value.absent()
              : Value(weightKg),
      weightGoalKg:
          weightGoalKg == null && nullToAbsent
              ? const Value.absent()
              : Value(weightGoalKg),
      updatedAt: Value(updatedAt),
      createdAt: Value(createdAt),
    );
  }

  factory DbOnboardingData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbOnboardingData(
      id: serializer.fromJson<BigInt>(json['id']),
      currentStep: $DbOnboardingDatasTable.$convertercurrentStep.fromJson(
        serializer.fromJson<String>(json['currentStep']),
      ),
      gender: $DbOnboardingDatasTable.$convertergendern.fromJson(
        serializer.fromJson<String?>(json['gender']),
      ),
      workoutFrequency: $DbOnboardingDatasTable.$converterworkoutFrequencyn
          .fromJson(serializer.fromJson<String?>(json['workoutFrequency'])),
      isMetric: serializer.fromJson<bool?>(json['isMetric']),
      diet: $DbOnboardingDatasTable.$converterdietn.fromJson(
        serializer.fromJson<String?>(json['diet']),
      ),
      dob: serializer.fromJson<DateTime?>(json['dob']),
      gptApiKey: serializer.fromJson<String?>(json['gptApiKey']),
      heightCm: serializer.fromJson<double?>(json['heightCm']),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      weightGoalKg: serializer.fromJson<double?>(json['weightGoalKg']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<BigInt>(id),
      'currentStep': serializer.toJson<String>(
        $DbOnboardingDatasTable.$convertercurrentStep.toJson(currentStep),
      ),
      'gender': serializer.toJson<String?>(
        $DbOnboardingDatasTable.$convertergendern.toJson(gender),
      ),
      'workoutFrequency': serializer.toJson<String?>(
        $DbOnboardingDatasTable.$converterworkoutFrequencyn.toJson(
          workoutFrequency,
        ),
      ),
      'isMetric': serializer.toJson<bool?>(isMetric),
      'diet': serializer.toJson<String?>(
        $DbOnboardingDatasTable.$converterdietn.toJson(diet),
      ),
      'dob': serializer.toJson<DateTime?>(dob),
      'gptApiKey': serializer.toJson<String?>(gptApiKey),
      'heightCm': serializer.toJson<double?>(heightCm),
      'weightKg': serializer.toJson<double?>(weightKg),
      'weightGoalKg': serializer.toJson<double?>(weightGoalKg),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DbOnboardingData copyWith({
    BigInt? id,
    OnboardingStep? currentStep,
    Value<Gender?> gender = const Value.absent(),
    Value<WorkoutFrequency?> workoutFrequency = const Value.absent(),
    Value<bool?> isMetric = const Value.absent(),
    Value<Diet?> diet = const Value.absent(),
    Value<DateTime?> dob = const Value.absent(),
    Value<String?> gptApiKey = const Value.absent(),
    Value<double?> heightCm = const Value.absent(),
    Value<double?> weightKg = const Value.absent(),
    Value<double?> weightGoalKg = const Value.absent(),
    DateTime? updatedAt,
    DateTime? createdAt,
  }) => DbOnboardingData(
    id: id ?? this.id,
    currentStep: currentStep ?? this.currentStep,
    gender: gender.present ? gender.value : this.gender,
    workoutFrequency:
        workoutFrequency.present
            ? workoutFrequency.value
            : this.workoutFrequency,
    isMetric: isMetric.present ? isMetric.value : this.isMetric,
    diet: diet.present ? diet.value : this.diet,
    dob: dob.present ? dob.value : this.dob,
    gptApiKey: gptApiKey.present ? gptApiKey.value : this.gptApiKey,
    heightCm: heightCm.present ? heightCm.value : this.heightCm,
    weightKg: weightKg.present ? weightKg.value : this.weightKg,
    weightGoalKg: weightGoalKg.present ? weightGoalKg.value : this.weightGoalKg,
    updatedAt: updatedAt ?? this.updatedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  DbOnboardingData copyWithCompanion(DbOnboardingDatasCompanion data) {
    return DbOnboardingData(
      id: data.id.present ? data.id.value : this.id,
      currentStep:
          data.currentStep.present ? data.currentStep.value : this.currentStep,
      gender: data.gender.present ? data.gender.value : this.gender,
      workoutFrequency:
          data.workoutFrequency.present
              ? data.workoutFrequency.value
              : this.workoutFrequency,
      isMetric: data.isMetric.present ? data.isMetric.value : this.isMetric,
      diet: data.diet.present ? data.diet.value : this.diet,
      dob: data.dob.present ? data.dob.value : this.dob,
      gptApiKey: data.gptApiKey.present ? data.gptApiKey.value : this.gptApiKey,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      weightGoalKg:
          data.weightGoalKg.present
              ? data.weightGoalKg.value
              : this.weightGoalKg,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbOnboardingData(')
          ..write('id: $id, ')
          ..write('currentStep: $currentStep, ')
          ..write('gender: $gender, ')
          ..write('workoutFrequency: $workoutFrequency, ')
          ..write('isMetric: $isMetric, ')
          ..write('diet: $diet, ')
          ..write('dob: $dob, ')
          ..write('gptApiKey: $gptApiKey, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('weightGoalKg: $weightGoalKg, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    currentStep,
    gender,
    workoutFrequency,
    isMetric,
    diet,
    dob,
    gptApiKey,
    heightCm,
    weightKg,
    weightGoalKg,
    updatedAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbOnboardingData &&
          other.id == this.id &&
          other.currentStep == this.currentStep &&
          other.gender == this.gender &&
          other.workoutFrequency == this.workoutFrequency &&
          other.isMetric == this.isMetric &&
          other.diet == this.diet &&
          other.dob == this.dob &&
          other.gptApiKey == this.gptApiKey &&
          other.heightCm == this.heightCm &&
          other.weightKg == this.weightKg &&
          other.weightGoalKg == this.weightGoalKg &&
          other.updatedAt == this.updatedAt &&
          other.createdAt == this.createdAt);
}

class DbOnboardingDatasCompanion extends UpdateCompanion<DbOnboardingData> {
  final Value<BigInt> id;
  final Value<OnboardingStep> currentStep;
  final Value<Gender?> gender;
  final Value<WorkoutFrequency?> workoutFrequency;
  final Value<bool?> isMetric;
  final Value<Diet?> diet;
  final Value<DateTime?> dob;
  final Value<String?> gptApiKey;
  final Value<double?> heightCm;
  final Value<double?> weightKg;
  final Value<double?> weightGoalKg;
  final Value<DateTime> updatedAt;
  final Value<DateTime> createdAt;
  const DbOnboardingDatasCompanion({
    this.id = const Value.absent(),
    this.currentStep = const Value.absent(),
    this.gender = const Value.absent(),
    this.workoutFrequency = const Value.absent(),
    this.isMetric = const Value.absent(),
    this.diet = const Value.absent(),
    this.dob = const Value.absent(),
    this.gptApiKey = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.weightGoalKg = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DbOnboardingDatasCompanion.insert({
    this.id = const Value.absent(),
    required OnboardingStep currentStep,
    this.gender = const Value.absent(),
    this.workoutFrequency = const Value.absent(),
    this.isMetric = const Value.absent(),
    this.diet = const Value.absent(),
    this.dob = const Value.absent(),
    this.gptApiKey = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.weightGoalKg = const Value.absent(),
    required DateTime updatedAt,
    required DateTime createdAt,
  }) : currentStep = Value(currentStep),
       updatedAt = Value(updatedAt),
       createdAt = Value(createdAt);
  static Insertable<DbOnboardingData> custom({
    Expression<BigInt>? id,
    Expression<String>? currentStep,
    Expression<String>? gender,
    Expression<String>? workoutFrequency,
    Expression<bool>? isMetric,
    Expression<String>? diet,
    Expression<DateTime>? dob,
    Expression<String>? gptApiKey,
    Expression<double>? heightCm,
    Expression<double>? weightKg,
    Expression<double>? weightGoalKg,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (currentStep != null) 'current_step': currentStep,
      if (gender != null) 'gender': gender,
      if (workoutFrequency != null) 'workout_frequency': workoutFrequency,
      if (isMetric != null) 'is_metric': isMetric,
      if (diet != null) 'diet': diet,
      if (dob != null) 'dob': dob,
      if (gptApiKey != null) 'gpt_api_key': gptApiKey,
      if (heightCm != null) 'height_cm': heightCm,
      if (weightKg != null) 'weight_kg': weightKg,
      if (weightGoalKg != null) 'weight_goal_kg': weightGoalKg,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DbOnboardingDatasCompanion copyWith({
    Value<BigInt>? id,
    Value<OnboardingStep>? currentStep,
    Value<Gender?>? gender,
    Value<WorkoutFrequency?>? workoutFrequency,
    Value<bool?>? isMetric,
    Value<Diet?>? diet,
    Value<DateTime?>? dob,
    Value<String?>? gptApiKey,
    Value<double?>? heightCm,
    Value<double?>? weightKg,
    Value<double?>? weightGoalKg,
    Value<DateTime>? updatedAt,
    Value<DateTime>? createdAt,
  }) {
    return DbOnboardingDatasCompanion(
      id: id ?? this.id,
      currentStep: currentStep ?? this.currentStep,
      gender: gender ?? this.gender,
      workoutFrequency: workoutFrequency ?? this.workoutFrequency,
      isMetric: isMetric ?? this.isMetric,
      diet: diet ?? this.diet,
      dob: dob ?? this.dob,
      gptApiKey: gptApiKey ?? this.gptApiKey,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      weightGoalKg: weightGoalKg ?? this.weightGoalKg,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<BigInt>(id.value);
    }
    if (currentStep.present) {
      map['current_step'] = Variable<String>(
        $DbOnboardingDatasTable.$convertercurrentStep.toSql(currentStep.value),
      );
    }
    if (gender.present) {
      map['gender'] = Variable<String>(
        $DbOnboardingDatasTable.$convertergendern.toSql(gender.value),
      );
    }
    if (workoutFrequency.present) {
      map['workout_frequency'] = Variable<String>(
        $DbOnboardingDatasTable.$converterworkoutFrequencyn.toSql(
          workoutFrequency.value,
        ),
      );
    }
    if (isMetric.present) {
      map['is_metric'] = Variable<bool>(isMetric.value);
    }
    if (diet.present) {
      map['diet'] = Variable<String>(
        $DbOnboardingDatasTable.$converterdietn.toSql(diet.value),
      );
    }
    if (dob.present) {
      map['dob'] = Variable<DateTime>(dob.value);
    }
    if (gptApiKey.present) {
      map['gpt_api_key'] = Variable<String>(gptApiKey.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<double>(heightCm.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (weightGoalKg.present) {
      map['weight_goal_kg'] = Variable<double>(weightGoalKg.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbOnboardingDatasCompanion(')
          ..write('id: $id, ')
          ..write('currentStep: $currentStep, ')
          ..write('gender: $gender, ')
          ..write('workoutFrequency: $workoutFrequency, ')
          ..write('isMetric: $isMetric, ')
          ..write('diet: $diet, ')
          ..write('dob: $dob, ')
          ..write('gptApiKey: $gptApiKey, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('weightGoalKg: $weightGoalKg, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DbRemindersTable extends DbReminders
    with TableInfo<$DbRemindersTable, DbReminder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbRemindersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<BigInt> id = GeneratedColumn<BigInt>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<DbReminderType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<DbReminderType>($DbRemindersTable.$convertertype);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hourMeta = const VerificationMeta('hour');
  @override
  late final GeneratedColumn<int> hour = GeneratedColumn<int>(
    'hour',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _minuteMeta = const VerificationMeta('minute');
  @override
  late final GeneratedColumn<int> minute = GeneratedColumn<int>(
    'minute',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
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
  static const VerificationMeta _onboardingDataMeta = const VerificationMeta(
    'onboardingData',
  );
  @override
  late final GeneratedColumn<BigInt> onboardingData = GeneratedColumn<BigInt>(
    'onboarding_data',
    aliasedName,
    true,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES db_onboarding_datas (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    label,
    hour,
    minute,
    updatedAt,
    createdAt,
    onboardingData,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'db_reminders';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbReminder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('hour')) {
      context.handle(
        _hourMeta,
        hour.isAcceptableOrUnknown(data['hour']!, _hourMeta),
      );
    }
    if (data.containsKey('minute')) {
      context.handle(
        _minuteMeta,
        minute.isAcceptableOrUnknown(data['minute']!, _minuteMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('onboarding_data')) {
      context.handle(
        _onboardingDataMeta,
        onboardingData.isAcceptableOrUnknown(
          data['onboarding_data']!,
          _onboardingDataMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbReminder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbReminder(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bigInt,
            data['${effectivePrefix}id'],
          )!,
      type: $DbRemindersTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      label:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}label'],
          )!,
      hour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hour'],
      ),
      minute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minute'],
      ),
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
      onboardingData: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}onboarding_data'],
      ),
    );
  }

  @override
  $DbRemindersTable createAlias(String alias) {
    return $DbRemindersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<DbReminderType, String, String> $convertertype =
      const EnumNameConverter<DbReminderType>(DbReminderType.values);
}

class DbReminder extends DataClass implements Insertable<DbReminder> {
  final BigInt id;
  final DbReminderType type;
  final String label;
  final int? hour;
  final int? minute;
  final DateTime updatedAt;
  final DateTime createdAt;
  final BigInt? onboardingData;
  const DbReminder({
    required this.id,
    required this.type,
    required this.label,
    this.hour,
    this.minute,
    required this.updatedAt,
    required this.createdAt,
    this.onboardingData,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<BigInt>(id);
    {
      map['type'] = Variable<String>(
        $DbRemindersTable.$convertertype.toSql(type),
      );
    }
    map['label'] = Variable<String>(label);
    if (!nullToAbsent || hour != null) {
      map['hour'] = Variable<int>(hour);
    }
    if (!nullToAbsent || minute != null) {
      map['minute'] = Variable<int>(minute);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || onboardingData != null) {
      map['onboarding_data'] = Variable<BigInt>(onboardingData);
    }
    return map;
  }

  DbRemindersCompanion toCompanion(bool nullToAbsent) {
    return DbRemindersCompanion(
      id: Value(id),
      type: Value(type),
      label: Value(label),
      hour: hour == null && nullToAbsent ? const Value.absent() : Value(hour),
      minute:
          minute == null && nullToAbsent ? const Value.absent() : Value(minute),
      updatedAt: Value(updatedAt),
      createdAt: Value(createdAt),
      onboardingData:
          onboardingData == null && nullToAbsent
              ? const Value.absent()
              : Value(onboardingData),
    );
  }

  factory DbReminder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbReminder(
      id: serializer.fromJson<BigInt>(json['id']),
      type: $DbRemindersTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      label: serializer.fromJson<String>(json['label']),
      hour: serializer.fromJson<int?>(json['hour']),
      minute: serializer.fromJson<int?>(json['minute']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      onboardingData: serializer.fromJson<BigInt?>(json['onboardingData']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<BigInt>(id),
      'type': serializer.toJson<String>(
        $DbRemindersTable.$convertertype.toJson(type),
      ),
      'label': serializer.toJson<String>(label),
      'hour': serializer.toJson<int?>(hour),
      'minute': serializer.toJson<int?>(minute),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'onboardingData': serializer.toJson<BigInt?>(onboardingData),
    };
  }

  DbReminder copyWith({
    BigInt? id,
    DbReminderType? type,
    String? label,
    Value<int?> hour = const Value.absent(),
    Value<int?> minute = const Value.absent(),
    DateTime? updatedAt,
    DateTime? createdAt,
    Value<BigInt?> onboardingData = const Value.absent(),
  }) => DbReminder(
    id: id ?? this.id,
    type: type ?? this.type,
    label: label ?? this.label,
    hour: hour.present ? hour.value : this.hour,
    minute: minute.present ? minute.value : this.minute,
    updatedAt: updatedAt ?? this.updatedAt,
    createdAt: createdAt ?? this.createdAt,
    onboardingData:
        onboardingData.present ? onboardingData.value : this.onboardingData,
  );
  DbReminder copyWithCompanion(DbRemindersCompanion data) {
    return DbReminder(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      label: data.label.present ? data.label.value : this.label,
      hour: data.hour.present ? data.hour.value : this.hour,
      minute: data.minute.present ? data.minute.value : this.minute,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      onboardingData:
          data.onboardingData.present
              ? data.onboardingData.value
              : this.onboardingData,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbReminder(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('label: $label, ')
          ..write('hour: $hour, ')
          ..write('minute: $minute, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('onboardingData: $onboardingData')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    label,
    hour,
    minute,
    updatedAt,
    createdAt,
    onboardingData,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbReminder &&
          other.id == this.id &&
          other.type == this.type &&
          other.label == this.label &&
          other.hour == this.hour &&
          other.minute == this.minute &&
          other.updatedAt == this.updatedAt &&
          other.createdAt == this.createdAt &&
          other.onboardingData == this.onboardingData);
}

class DbRemindersCompanion extends UpdateCompanion<DbReminder> {
  final Value<BigInt> id;
  final Value<DbReminderType> type;
  final Value<String> label;
  final Value<int?> hour;
  final Value<int?> minute;
  final Value<DateTime> updatedAt;
  final Value<DateTime> createdAt;
  final Value<BigInt?> onboardingData;
  const DbRemindersCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.label = const Value.absent(),
    this.hour = const Value.absent(),
    this.minute = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.onboardingData = const Value.absent(),
  });
  DbRemindersCompanion.insert({
    this.id = const Value.absent(),
    required DbReminderType type,
    required String label,
    this.hour = const Value.absent(),
    this.minute = const Value.absent(),
    required DateTime updatedAt,
    required DateTime createdAt,
    this.onboardingData = const Value.absent(),
  }) : type = Value(type),
       label = Value(label),
       updatedAt = Value(updatedAt),
       createdAt = Value(createdAt);
  static Insertable<DbReminder> custom({
    Expression<BigInt>? id,
    Expression<String>? type,
    Expression<String>? label,
    Expression<int>? hour,
    Expression<int>? minute,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? createdAt,
    Expression<BigInt>? onboardingData,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (label != null) 'label': label,
      if (hour != null) 'hour': hour,
      if (minute != null) 'minute': minute,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (onboardingData != null) 'onboarding_data': onboardingData,
    });
  }

  DbRemindersCompanion copyWith({
    Value<BigInt>? id,
    Value<DbReminderType>? type,
    Value<String>? label,
    Value<int?>? hour,
    Value<int?>? minute,
    Value<DateTime>? updatedAt,
    Value<DateTime>? createdAt,
    Value<BigInt?>? onboardingData,
  }) {
    return DbRemindersCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      label: label ?? this.label,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      onboardingData: onboardingData ?? this.onboardingData,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<BigInt>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $DbRemindersTable.$convertertype.toSql(type.value),
      );
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (hour.present) {
      map['hour'] = Variable<int>(hour.value);
    }
    if (minute.present) {
      map['minute'] = Variable<int>(minute.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (onboardingData.present) {
      map['onboarding_data'] = Variable<BigInt>(onboardingData.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbRemindersCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('label: $label, ')
          ..write('hour: $hour, ')
          ..write('minute: $minute, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('onboardingData: $onboardingData')
          ..write(')'))
        .toString();
  }
}

class $DbMealDatasTable extends DbMealDatas
    with TableInfo<$DbMealDatasTable, DbMealData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbMealDatasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<BigInt> id = GeneratedColumn<BigInt>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _caloriesMeta = const VerificationMeta(
    'calories',
  );
  @override
  late final GeneratedColumn<double> calories = GeneratedColumn<double>(
    'calories',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proteinMeta = const VerificationMeta(
    'protein',
  );
  @override
  late final GeneratedColumn<double> protein = GeneratedColumn<double>(
    'protein',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carbsMeta = const VerificationMeta('carbs');
  @override
  late final GeneratedColumn<double> carbs = GeneratedColumn<double>(
    'carbs',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fatsMeta = const VerificationMeta('fats');
  @override
  late final GeneratedColumn<double> fats = GeneratedColumn<double>(
    'fats',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _waterMeta = const VerificationMeta('water');
  @override
  late final GeneratedColumn<double> water = GeneratedColumn<double>(
    'water',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mealNameMeta = const VerificationMeta(
    'mealName',
  );
  @override
  late final GeneratedColumn<String> mealName = GeneratedColumn<String>(
    'meal_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mealDescriptionMeta = const VerificationMeta(
    'mealDescription',
  );
  @override
  late final GeneratedColumn<String> mealDescription = GeneratedColumn<String>(
    'meal_description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    calories,
    protein,
    carbs,
    fats,
    water,
    mealName,
    mealDescription,
    updatedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'db_meal_datas';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbMealData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('calories')) {
      context.handle(
        _caloriesMeta,
        calories.isAcceptableOrUnknown(data['calories']!, _caloriesMeta),
      );
    } else if (isInserting) {
      context.missing(_caloriesMeta);
    }
    if (data.containsKey('protein')) {
      context.handle(
        _proteinMeta,
        protein.isAcceptableOrUnknown(data['protein']!, _proteinMeta),
      );
    } else if (isInserting) {
      context.missing(_proteinMeta);
    }
    if (data.containsKey('carbs')) {
      context.handle(
        _carbsMeta,
        carbs.isAcceptableOrUnknown(data['carbs']!, _carbsMeta),
      );
    } else if (isInserting) {
      context.missing(_carbsMeta);
    }
    if (data.containsKey('fats')) {
      context.handle(
        _fatsMeta,
        fats.isAcceptableOrUnknown(data['fats']!, _fatsMeta),
      );
    } else if (isInserting) {
      context.missing(_fatsMeta);
    }
    if (data.containsKey('water')) {
      context.handle(
        _waterMeta,
        water.isAcceptableOrUnknown(data['water']!, _waterMeta),
      );
    } else if (isInserting) {
      context.missing(_waterMeta);
    }
    if (data.containsKey('meal_name')) {
      context.handle(
        _mealNameMeta,
        mealName.isAcceptableOrUnknown(data['meal_name']!, _mealNameMeta),
      );
    } else if (isInserting) {
      context.missing(_mealNameMeta);
    }
    if (data.containsKey('meal_description')) {
      context.handle(
        _mealDescriptionMeta,
        mealDescription.isAcceptableOrUnknown(
          data['meal_description']!,
          _mealDescriptionMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
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
  DbMealData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbMealData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bigInt,
            data['${effectivePrefix}id'],
          )!,
      calories:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}calories'],
          )!,
      protein:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}protein'],
          )!,
      carbs:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}carbs'],
          )!,
      fats:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}fats'],
          )!,
      water:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}water'],
          )!,
      mealName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}meal_name'],
          )!,
      mealDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_description'],
      ),
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $DbMealDatasTable createAlias(String alias) {
    return $DbMealDatasTable(attachedDatabase, alias);
  }
}

class DbMealData extends DataClass implements Insertable<DbMealData> {
  final BigInt id;
  final double calories;
  final double protein;
  final double carbs;
  final double fats;
  final double water;
  final String mealName;
  final String? mealDescription;
  final DateTime updatedAt;
  final DateTime createdAt;
  const DbMealData({
    required this.id,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
    required this.water,
    required this.mealName,
    this.mealDescription,
    required this.updatedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<BigInt>(id);
    map['calories'] = Variable<double>(calories);
    map['protein'] = Variable<double>(protein);
    map['carbs'] = Variable<double>(carbs);
    map['fats'] = Variable<double>(fats);
    map['water'] = Variable<double>(water);
    map['meal_name'] = Variable<String>(mealName);
    if (!nullToAbsent || mealDescription != null) {
      map['meal_description'] = Variable<String>(mealDescription);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DbMealDatasCompanion toCompanion(bool nullToAbsent) {
    return DbMealDatasCompanion(
      id: Value(id),
      calories: Value(calories),
      protein: Value(protein),
      carbs: Value(carbs),
      fats: Value(fats),
      water: Value(water),
      mealName: Value(mealName),
      mealDescription:
          mealDescription == null && nullToAbsent
              ? const Value.absent()
              : Value(mealDescription),
      updatedAt: Value(updatedAt),
      createdAt: Value(createdAt),
    );
  }

  factory DbMealData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbMealData(
      id: serializer.fromJson<BigInt>(json['id']),
      calories: serializer.fromJson<double>(json['calories']),
      protein: serializer.fromJson<double>(json['protein']),
      carbs: serializer.fromJson<double>(json['carbs']),
      fats: serializer.fromJson<double>(json['fats']),
      water: serializer.fromJson<double>(json['water']),
      mealName: serializer.fromJson<String>(json['mealName']),
      mealDescription: serializer.fromJson<String?>(json['mealDescription']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<BigInt>(id),
      'calories': serializer.toJson<double>(calories),
      'protein': serializer.toJson<double>(protein),
      'carbs': serializer.toJson<double>(carbs),
      'fats': serializer.toJson<double>(fats),
      'water': serializer.toJson<double>(water),
      'mealName': serializer.toJson<String>(mealName),
      'mealDescription': serializer.toJson<String?>(mealDescription),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DbMealData copyWith({
    BigInt? id,
    double? calories,
    double? protein,
    double? carbs,
    double? fats,
    double? water,
    String? mealName,
    Value<String?> mealDescription = const Value.absent(),
    DateTime? updatedAt,
    DateTime? createdAt,
  }) => DbMealData(
    id: id ?? this.id,
    calories: calories ?? this.calories,
    protein: protein ?? this.protein,
    carbs: carbs ?? this.carbs,
    fats: fats ?? this.fats,
    water: water ?? this.water,
    mealName: mealName ?? this.mealName,
    mealDescription:
        mealDescription.present ? mealDescription.value : this.mealDescription,
    updatedAt: updatedAt ?? this.updatedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  DbMealData copyWithCompanion(DbMealDatasCompanion data) {
    return DbMealData(
      id: data.id.present ? data.id.value : this.id,
      calories: data.calories.present ? data.calories.value : this.calories,
      protein: data.protein.present ? data.protein.value : this.protein,
      carbs: data.carbs.present ? data.carbs.value : this.carbs,
      fats: data.fats.present ? data.fats.value : this.fats,
      water: data.water.present ? data.water.value : this.water,
      mealName: data.mealName.present ? data.mealName.value : this.mealName,
      mealDescription:
          data.mealDescription.present
              ? data.mealDescription.value
              : this.mealDescription,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbMealData(')
          ..write('id: $id, ')
          ..write('calories: $calories, ')
          ..write('protein: $protein, ')
          ..write('carbs: $carbs, ')
          ..write('fats: $fats, ')
          ..write('water: $water, ')
          ..write('mealName: $mealName, ')
          ..write('mealDescription: $mealDescription, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    calories,
    protein,
    carbs,
    fats,
    water,
    mealName,
    mealDescription,
    updatedAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbMealData &&
          other.id == this.id &&
          other.calories == this.calories &&
          other.protein == this.protein &&
          other.carbs == this.carbs &&
          other.fats == this.fats &&
          other.water == this.water &&
          other.mealName == this.mealName &&
          other.mealDescription == this.mealDescription &&
          other.updatedAt == this.updatedAt &&
          other.createdAt == this.createdAt);
}

class DbMealDatasCompanion extends UpdateCompanion<DbMealData> {
  final Value<BigInt> id;
  final Value<double> calories;
  final Value<double> protein;
  final Value<double> carbs;
  final Value<double> fats;
  final Value<double> water;
  final Value<String> mealName;
  final Value<String?> mealDescription;
  final Value<DateTime> updatedAt;
  final Value<DateTime> createdAt;
  const DbMealDatasCompanion({
    this.id = const Value.absent(),
    this.calories = const Value.absent(),
    this.protein = const Value.absent(),
    this.carbs = const Value.absent(),
    this.fats = const Value.absent(),
    this.water = const Value.absent(),
    this.mealName = const Value.absent(),
    this.mealDescription = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DbMealDatasCompanion.insert({
    this.id = const Value.absent(),
    required double calories,
    required double protein,
    required double carbs,
    required double fats,
    required double water,
    required String mealName,
    this.mealDescription = const Value.absent(),
    required DateTime updatedAt,
    required DateTime createdAt,
  }) : calories = Value(calories),
       protein = Value(protein),
       carbs = Value(carbs),
       fats = Value(fats),
       water = Value(water),
       mealName = Value(mealName),
       updatedAt = Value(updatedAt),
       createdAt = Value(createdAt);
  static Insertable<DbMealData> custom({
    Expression<BigInt>? id,
    Expression<double>? calories,
    Expression<double>? protein,
    Expression<double>? carbs,
    Expression<double>? fats,
    Expression<double>? water,
    Expression<String>? mealName,
    Expression<String>? mealDescription,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (calories != null) 'calories': calories,
      if (protein != null) 'protein': protein,
      if (carbs != null) 'carbs': carbs,
      if (fats != null) 'fats': fats,
      if (water != null) 'water': water,
      if (mealName != null) 'meal_name': mealName,
      if (mealDescription != null) 'meal_description': mealDescription,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DbMealDatasCompanion copyWith({
    Value<BigInt>? id,
    Value<double>? calories,
    Value<double>? protein,
    Value<double>? carbs,
    Value<double>? fats,
    Value<double>? water,
    Value<String>? mealName,
    Value<String?>? mealDescription,
    Value<DateTime>? updatedAt,
    Value<DateTime>? createdAt,
  }) {
    return DbMealDatasCompanion(
      id: id ?? this.id,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fats: fats ?? this.fats,
      water: water ?? this.water,
      mealName: mealName ?? this.mealName,
      mealDescription: mealDescription ?? this.mealDescription,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<BigInt>(id.value);
    }
    if (calories.present) {
      map['calories'] = Variable<double>(calories.value);
    }
    if (protein.present) {
      map['protein'] = Variable<double>(protein.value);
    }
    if (carbs.present) {
      map['carbs'] = Variable<double>(carbs.value);
    }
    if (fats.present) {
      map['fats'] = Variable<double>(fats.value);
    }
    if (water.present) {
      map['water'] = Variable<double>(water.value);
    }
    if (mealName.present) {
      map['meal_name'] = Variable<String>(mealName.value);
    }
    if (mealDescription.present) {
      map['meal_description'] = Variable<String>(mealDescription.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbMealDatasCompanion(')
          ..write('id: $id, ')
          ..write('calories: $calories, ')
          ..write('protein: $protein, ')
          ..write('carbs: $carbs, ')
          ..write('fats: $fats, ')
          ..write('water: $water, ')
          ..write('mealName: $mealName, ')
          ..write('mealDescription: $mealDescription, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DbNutritionPlansTable extends DbNutritionPlans
    with TableInfo<$DbNutritionPlansTable, DbNutritionPlan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbNutritionPlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<BigInt> id = GeneratedColumn<BigInt>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _timeframeInWeeksMeta = const VerificationMeta(
    'timeframeInWeeks',
  );
  @override
  late final GeneratedColumn<int> timeframeInWeeks = GeneratedColumn<int>(
    'timeframe_in_weeks',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caloriesMeta = const VerificationMeta(
    'calories',
  );
  @override
  late final GeneratedColumn<int> calories = GeneratedColumn<int>(
    'calories',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proteinGMeta = const VerificationMeta(
    'proteinG',
  );
  @override
  late final GeneratedColumn<double> proteinG = GeneratedColumn<double>(
    'protein_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carbsGMeta = const VerificationMeta('carbsG');
  @override
  late final GeneratedColumn<double> carbsG = GeneratedColumn<double>(
    'carbs_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fatsGMeta = const VerificationMeta('fatsG');
  @override
  late final GeneratedColumn<double> fatsG = GeneratedColumn<double>(
    'fats_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _waterLitersMeta = const VerificationMeta(
    'waterLiters',
  );
  @override
  late final GeneratedColumn<double> waterLiters = GeneratedColumn<double>(
    'water_liters',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gymAdviceMeta = const VerificationMeta(
    'gymAdvice',
  );
  @override
  late final GeneratedColumn<String> gymAdvice = GeneratedColumn<String>(
    'gym_advice',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _medicalAdviceMeta = const VerificationMeta(
    'medicalAdvice',
  );
  @override
  late final GeneratedColumn<String> medicalAdvice = GeneratedColumn<String>(
    'medical_advice',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _warningsMeta = const VerificationMeta(
    'warnings',
  );
  @override
  late final GeneratedColumn<String> warnings = GeneratedColumn<String>(
    'warnings',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    timeframeInWeeks,
    calories,
    proteinG,
    carbsG,
    fatsG,
    waterLiters,
    gymAdvice,
    medicalAdvice,
    warnings,
    updatedAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'db_nutrition_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbNutritionPlan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('timeframe_in_weeks')) {
      context.handle(
        _timeframeInWeeksMeta,
        timeframeInWeeks.isAcceptableOrUnknown(
          data['timeframe_in_weeks']!,
          _timeframeInWeeksMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timeframeInWeeksMeta);
    }
    if (data.containsKey('calories')) {
      context.handle(
        _caloriesMeta,
        calories.isAcceptableOrUnknown(data['calories']!, _caloriesMeta),
      );
    } else if (isInserting) {
      context.missing(_caloriesMeta);
    }
    if (data.containsKey('protein_g')) {
      context.handle(
        _proteinGMeta,
        proteinG.isAcceptableOrUnknown(data['protein_g']!, _proteinGMeta),
      );
    } else if (isInserting) {
      context.missing(_proteinGMeta);
    }
    if (data.containsKey('carbs_g')) {
      context.handle(
        _carbsGMeta,
        carbsG.isAcceptableOrUnknown(data['carbs_g']!, _carbsGMeta),
      );
    } else if (isInserting) {
      context.missing(_carbsGMeta);
    }
    if (data.containsKey('fats_g')) {
      context.handle(
        _fatsGMeta,
        fatsG.isAcceptableOrUnknown(data['fats_g']!, _fatsGMeta),
      );
    } else if (isInserting) {
      context.missing(_fatsGMeta);
    }
    if (data.containsKey('water_liters')) {
      context.handle(
        _waterLitersMeta,
        waterLiters.isAcceptableOrUnknown(
          data['water_liters']!,
          _waterLitersMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_waterLitersMeta);
    }
    if (data.containsKey('gym_advice')) {
      context.handle(
        _gymAdviceMeta,
        gymAdvice.isAcceptableOrUnknown(data['gym_advice']!, _gymAdviceMeta),
      );
    } else if (isInserting) {
      context.missing(_gymAdviceMeta);
    }
    if (data.containsKey('medical_advice')) {
      context.handle(
        _medicalAdviceMeta,
        medicalAdvice.isAcceptableOrUnknown(
          data['medical_advice']!,
          _medicalAdviceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_medicalAdviceMeta);
    }
    if (data.containsKey('warnings')) {
      context.handle(
        _warningsMeta,
        warnings.isAcceptableOrUnknown(data['warnings']!, _warningsMeta),
      );
    } else if (isInserting) {
      context.missing(_warningsMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
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
  DbNutritionPlan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbNutritionPlan(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bigInt,
            data['${effectivePrefix}id'],
          )!,
      timeframeInWeeks:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}timeframe_in_weeks'],
          )!,
      calories:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}calories'],
          )!,
      proteinG:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}protein_g'],
          )!,
      carbsG:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}carbs_g'],
          )!,
      fatsG:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}fats_g'],
          )!,
      waterLiters:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}water_liters'],
          )!,
      gymAdvice:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}gym_advice'],
          )!,
      medicalAdvice:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}medical_advice'],
          )!,
      warnings:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}warnings'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $DbNutritionPlansTable createAlias(String alias) {
    return $DbNutritionPlansTable(attachedDatabase, alias);
  }
}

class DbNutritionPlan extends DataClass implements Insertable<DbNutritionPlan> {
  final BigInt id;
  final int timeframeInWeeks;
  final int calories;
  final double proteinG;
  final double carbsG;
  final double fatsG;
  final double waterLiters;
  final String gymAdvice;
  final String medicalAdvice;
  final String warnings;
  final DateTime updatedAt;
  final DateTime createdAt;
  const DbNutritionPlan({
    required this.id,
    required this.timeframeInWeeks,
    required this.calories,
    required this.proteinG,
    required this.carbsG,
    required this.fatsG,
    required this.waterLiters,
    required this.gymAdvice,
    required this.medicalAdvice,
    required this.warnings,
    required this.updatedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<BigInt>(id);
    map['timeframe_in_weeks'] = Variable<int>(timeframeInWeeks);
    map['calories'] = Variable<int>(calories);
    map['protein_g'] = Variable<double>(proteinG);
    map['carbs_g'] = Variable<double>(carbsG);
    map['fats_g'] = Variable<double>(fatsG);
    map['water_liters'] = Variable<double>(waterLiters);
    map['gym_advice'] = Variable<String>(gymAdvice);
    map['medical_advice'] = Variable<String>(medicalAdvice);
    map['warnings'] = Variable<String>(warnings);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DbNutritionPlansCompanion toCompanion(bool nullToAbsent) {
    return DbNutritionPlansCompanion(
      id: Value(id),
      timeframeInWeeks: Value(timeframeInWeeks),
      calories: Value(calories),
      proteinG: Value(proteinG),
      carbsG: Value(carbsG),
      fatsG: Value(fatsG),
      waterLiters: Value(waterLiters),
      gymAdvice: Value(gymAdvice),
      medicalAdvice: Value(medicalAdvice),
      warnings: Value(warnings),
      updatedAt: Value(updatedAt),
      createdAt: Value(createdAt),
    );
  }

  factory DbNutritionPlan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbNutritionPlan(
      id: serializer.fromJson<BigInt>(json['id']),
      timeframeInWeeks: serializer.fromJson<int>(json['timeframeInWeeks']),
      calories: serializer.fromJson<int>(json['calories']),
      proteinG: serializer.fromJson<double>(json['proteinG']),
      carbsG: serializer.fromJson<double>(json['carbsG']),
      fatsG: serializer.fromJson<double>(json['fatsG']),
      waterLiters: serializer.fromJson<double>(json['waterLiters']),
      gymAdvice: serializer.fromJson<String>(json['gymAdvice']),
      medicalAdvice: serializer.fromJson<String>(json['medicalAdvice']),
      warnings: serializer.fromJson<String>(json['warnings']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<BigInt>(id),
      'timeframeInWeeks': serializer.toJson<int>(timeframeInWeeks),
      'calories': serializer.toJson<int>(calories),
      'proteinG': serializer.toJson<double>(proteinG),
      'carbsG': serializer.toJson<double>(carbsG),
      'fatsG': serializer.toJson<double>(fatsG),
      'waterLiters': serializer.toJson<double>(waterLiters),
      'gymAdvice': serializer.toJson<String>(gymAdvice),
      'medicalAdvice': serializer.toJson<String>(medicalAdvice),
      'warnings': serializer.toJson<String>(warnings),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DbNutritionPlan copyWith({
    BigInt? id,
    int? timeframeInWeeks,
    int? calories,
    double? proteinG,
    double? carbsG,
    double? fatsG,
    double? waterLiters,
    String? gymAdvice,
    String? medicalAdvice,
    String? warnings,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) => DbNutritionPlan(
    id: id ?? this.id,
    timeframeInWeeks: timeframeInWeeks ?? this.timeframeInWeeks,
    calories: calories ?? this.calories,
    proteinG: proteinG ?? this.proteinG,
    carbsG: carbsG ?? this.carbsG,
    fatsG: fatsG ?? this.fatsG,
    waterLiters: waterLiters ?? this.waterLiters,
    gymAdvice: gymAdvice ?? this.gymAdvice,
    medicalAdvice: medicalAdvice ?? this.medicalAdvice,
    warnings: warnings ?? this.warnings,
    updatedAt: updatedAt ?? this.updatedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  DbNutritionPlan copyWithCompanion(DbNutritionPlansCompanion data) {
    return DbNutritionPlan(
      id: data.id.present ? data.id.value : this.id,
      timeframeInWeeks:
          data.timeframeInWeeks.present
              ? data.timeframeInWeeks.value
              : this.timeframeInWeeks,
      calories: data.calories.present ? data.calories.value : this.calories,
      proteinG: data.proteinG.present ? data.proteinG.value : this.proteinG,
      carbsG: data.carbsG.present ? data.carbsG.value : this.carbsG,
      fatsG: data.fatsG.present ? data.fatsG.value : this.fatsG,
      waterLiters:
          data.waterLiters.present ? data.waterLiters.value : this.waterLiters,
      gymAdvice: data.gymAdvice.present ? data.gymAdvice.value : this.gymAdvice,
      medicalAdvice:
          data.medicalAdvice.present
              ? data.medicalAdvice.value
              : this.medicalAdvice,
      warnings: data.warnings.present ? data.warnings.value : this.warnings,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbNutritionPlan(')
          ..write('id: $id, ')
          ..write('timeframeInWeeks: $timeframeInWeeks, ')
          ..write('calories: $calories, ')
          ..write('proteinG: $proteinG, ')
          ..write('carbsG: $carbsG, ')
          ..write('fatsG: $fatsG, ')
          ..write('waterLiters: $waterLiters, ')
          ..write('gymAdvice: $gymAdvice, ')
          ..write('medicalAdvice: $medicalAdvice, ')
          ..write('warnings: $warnings, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    timeframeInWeeks,
    calories,
    proteinG,
    carbsG,
    fatsG,
    waterLiters,
    gymAdvice,
    medicalAdvice,
    warnings,
    updatedAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbNutritionPlan &&
          other.id == this.id &&
          other.timeframeInWeeks == this.timeframeInWeeks &&
          other.calories == this.calories &&
          other.proteinG == this.proteinG &&
          other.carbsG == this.carbsG &&
          other.fatsG == this.fatsG &&
          other.waterLiters == this.waterLiters &&
          other.gymAdvice == this.gymAdvice &&
          other.medicalAdvice == this.medicalAdvice &&
          other.warnings == this.warnings &&
          other.updatedAt == this.updatedAt &&
          other.createdAt == this.createdAt);
}

class DbNutritionPlansCompanion extends UpdateCompanion<DbNutritionPlan> {
  final Value<BigInt> id;
  final Value<int> timeframeInWeeks;
  final Value<int> calories;
  final Value<double> proteinG;
  final Value<double> carbsG;
  final Value<double> fatsG;
  final Value<double> waterLiters;
  final Value<String> gymAdvice;
  final Value<String> medicalAdvice;
  final Value<String> warnings;
  final Value<DateTime> updatedAt;
  final Value<DateTime> createdAt;
  const DbNutritionPlansCompanion({
    this.id = const Value.absent(),
    this.timeframeInWeeks = const Value.absent(),
    this.calories = const Value.absent(),
    this.proteinG = const Value.absent(),
    this.carbsG = const Value.absent(),
    this.fatsG = const Value.absent(),
    this.waterLiters = const Value.absent(),
    this.gymAdvice = const Value.absent(),
    this.medicalAdvice = const Value.absent(),
    this.warnings = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DbNutritionPlansCompanion.insert({
    this.id = const Value.absent(),
    required int timeframeInWeeks,
    required int calories,
    required double proteinG,
    required double carbsG,
    required double fatsG,
    required double waterLiters,
    required String gymAdvice,
    required String medicalAdvice,
    required String warnings,
    required DateTime updatedAt,
    required DateTime createdAt,
  }) : timeframeInWeeks = Value(timeframeInWeeks),
       calories = Value(calories),
       proteinG = Value(proteinG),
       carbsG = Value(carbsG),
       fatsG = Value(fatsG),
       waterLiters = Value(waterLiters),
       gymAdvice = Value(gymAdvice),
       medicalAdvice = Value(medicalAdvice),
       warnings = Value(warnings),
       updatedAt = Value(updatedAt),
       createdAt = Value(createdAt);
  static Insertable<DbNutritionPlan> custom({
    Expression<BigInt>? id,
    Expression<int>? timeframeInWeeks,
    Expression<int>? calories,
    Expression<double>? proteinG,
    Expression<double>? carbsG,
    Expression<double>? fatsG,
    Expression<double>? waterLiters,
    Expression<String>? gymAdvice,
    Expression<String>? medicalAdvice,
    Expression<String>? warnings,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (timeframeInWeeks != null) 'timeframe_in_weeks': timeframeInWeeks,
      if (calories != null) 'calories': calories,
      if (proteinG != null) 'protein_g': proteinG,
      if (carbsG != null) 'carbs_g': carbsG,
      if (fatsG != null) 'fats_g': fatsG,
      if (waterLiters != null) 'water_liters': waterLiters,
      if (gymAdvice != null) 'gym_advice': gymAdvice,
      if (medicalAdvice != null) 'medical_advice': medicalAdvice,
      if (warnings != null) 'warnings': warnings,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DbNutritionPlansCompanion copyWith({
    Value<BigInt>? id,
    Value<int>? timeframeInWeeks,
    Value<int>? calories,
    Value<double>? proteinG,
    Value<double>? carbsG,
    Value<double>? fatsG,
    Value<double>? waterLiters,
    Value<String>? gymAdvice,
    Value<String>? medicalAdvice,
    Value<String>? warnings,
    Value<DateTime>? updatedAt,
    Value<DateTime>? createdAt,
  }) {
    return DbNutritionPlansCompanion(
      id: id ?? this.id,
      timeframeInWeeks: timeframeInWeeks ?? this.timeframeInWeeks,
      calories: calories ?? this.calories,
      proteinG: proteinG ?? this.proteinG,
      carbsG: carbsG ?? this.carbsG,
      fatsG: fatsG ?? this.fatsG,
      waterLiters: waterLiters ?? this.waterLiters,
      gymAdvice: gymAdvice ?? this.gymAdvice,
      medicalAdvice: medicalAdvice ?? this.medicalAdvice,
      warnings: warnings ?? this.warnings,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<BigInt>(id.value);
    }
    if (timeframeInWeeks.present) {
      map['timeframe_in_weeks'] = Variable<int>(timeframeInWeeks.value);
    }
    if (calories.present) {
      map['calories'] = Variable<int>(calories.value);
    }
    if (proteinG.present) {
      map['protein_g'] = Variable<double>(proteinG.value);
    }
    if (carbsG.present) {
      map['carbs_g'] = Variable<double>(carbsG.value);
    }
    if (fatsG.present) {
      map['fats_g'] = Variable<double>(fatsG.value);
    }
    if (waterLiters.present) {
      map['water_liters'] = Variable<double>(waterLiters.value);
    }
    if (gymAdvice.present) {
      map['gym_advice'] = Variable<String>(gymAdvice.value);
    }
    if (medicalAdvice.present) {
      map['medical_advice'] = Variable<String>(medicalAdvice.value);
    }
    if (warnings.present) {
      map['warnings'] = Variable<String>(warnings.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbNutritionPlansCompanion(')
          ..write('id: $id, ')
          ..write('timeframeInWeeks: $timeframeInWeeks, ')
          ..write('calories: $calories, ')
          ..write('proteinG: $proteinG, ')
          ..write('carbsG: $carbsG, ')
          ..write('fatsG: $fatsG, ')
          ..write('waterLiters: $waterLiters, ')
          ..write('gymAdvice: $gymAdvice, ')
          ..write('medicalAdvice: $medicalAdvice, ')
          ..write('warnings: $warnings, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DbStreakRecordsTable extends DbStreakRecords
    with TableInfo<$DbStreakRecordsTable, DbStreakRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbStreakRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
    'count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
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
  @override
  List<GeneratedColumn> get $columns => [id, count, updatedAt, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'db_streak_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbStreakRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('count')) {
      context.handle(
        _countMeta,
        count.isAcceptableOrUnknown(data['count']!, _countMeta),
      );
    } else if (isInserting) {
      context.missing(_countMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
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
  DbStreakRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbStreakRecord(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      count:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}count'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $DbStreakRecordsTable createAlias(String alias) {
    return $DbStreakRecordsTable(attachedDatabase, alias);
  }
}

class DbStreakRecord extends DataClass implements Insertable<DbStreakRecord> {
  final int id;
  final int count;
  final DateTime updatedAt;
  final DateTime createdAt;
  const DbStreakRecord({
    required this.id,
    required this.count,
    required this.updatedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['count'] = Variable<int>(count);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DbStreakRecordsCompanion toCompanion(bool nullToAbsent) {
    return DbStreakRecordsCompanion(
      id: Value(id),
      count: Value(count),
      updatedAt: Value(updatedAt),
      createdAt: Value(createdAt),
    );
  }

  factory DbStreakRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbStreakRecord(
      id: serializer.fromJson<int>(json['id']),
      count: serializer.fromJson<int>(json['count']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'count': serializer.toJson<int>(count),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DbStreakRecord copyWith({
    int? id,
    int? count,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) => DbStreakRecord(
    id: id ?? this.id,
    count: count ?? this.count,
    updatedAt: updatedAt ?? this.updatedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  DbStreakRecord copyWithCompanion(DbStreakRecordsCompanion data) {
    return DbStreakRecord(
      id: data.id.present ? data.id.value : this.id,
      count: data.count.present ? data.count.value : this.count,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbStreakRecord(')
          ..write('id: $id, ')
          ..write('count: $count, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, count, updatedAt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbStreakRecord &&
          other.id == this.id &&
          other.count == this.count &&
          other.updatedAt == this.updatedAt &&
          other.createdAt == this.createdAt);
}

class DbStreakRecordsCompanion extends UpdateCompanion<DbStreakRecord> {
  final Value<int> id;
  final Value<int> count;
  final Value<DateTime> updatedAt;
  final Value<DateTime> createdAt;
  const DbStreakRecordsCompanion({
    this.id = const Value.absent(),
    this.count = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DbStreakRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int count,
    required DateTime updatedAt,
    required DateTime createdAt,
  }) : count = Value(count),
       updatedAt = Value(updatedAt),
       createdAt = Value(createdAt);
  static Insertable<DbStreakRecord> custom({
    Expression<int>? id,
    Expression<int>? count,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (count != null) 'count': count,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DbStreakRecordsCompanion copyWith({
    Value<int>? id,
    Value<int>? count,
    Value<DateTime>? updatedAt,
    Value<DateTime>? createdAt,
  }) {
    return DbStreakRecordsCompanion(
      id: id ?? this.id,
      count: count ?? this.count,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbStreakRecordsCompanion(')
          ..write('id: $id, ')
          ..write('count: $count, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DbHistoriesTable extends DbHistories
    with TableInfo<$DbHistoriesTable, DbHistory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbHistoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<BigInt> id = GeneratedColumn<BigInt>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<HistoryType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<HistoryType>($DbHistoriesTable.$convertertype);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
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
  @override
  List<GeneratedColumn> get $columns => [id, type, value, updatedAt, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'db_histories';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbHistory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
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
  DbHistory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbHistory(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bigInt,
            data['${effectivePrefix}id'],
          )!,
      type: $DbHistoriesTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      value:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}value'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated_at'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $DbHistoriesTable createAlias(String alias) {
    return $DbHistoriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<HistoryType, String, String> $convertertype =
      const EnumNameConverter<HistoryType>(HistoryType.values);
}

class DbHistory extends DataClass implements Insertable<DbHistory> {
  final BigInt id;
  final HistoryType type;
  final double value;
  final DateTime updatedAt;
  final DateTime createdAt;
  const DbHistory({
    required this.id,
    required this.type,
    required this.value,
    required this.updatedAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<BigInt>(id);
    {
      map['type'] = Variable<String>(
        $DbHistoriesTable.$convertertype.toSql(type),
      );
    }
    map['value'] = Variable<double>(value);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DbHistoriesCompanion toCompanion(bool nullToAbsent) {
    return DbHistoriesCompanion(
      id: Value(id),
      type: Value(type),
      value: Value(value),
      updatedAt: Value(updatedAt),
      createdAt: Value(createdAt),
    );
  }

  factory DbHistory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbHistory(
      id: serializer.fromJson<BigInt>(json['id']),
      type: $DbHistoriesTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      value: serializer.fromJson<double>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<BigInt>(id),
      'type': serializer.toJson<String>(
        $DbHistoriesTable.$convertertype.toJson(type),
      ),
      'value': serializer.toJson<double>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  DbHistory copyWith({
    BigInt? id,
    HistoryType? type,
    double? value,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) => DbHistory(
    id: id ?? this.id,
    type: type ?? this.type,
    value: value ?? this.value,
    updatedAt: updatedAt ?? this.updatedAt,
    createdAt: createdAt ?? this.createdAt,
  );
  DbHistory copyWithCompanion(DbHistoriesCompanion data) {
    return DbHistory(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbHistory(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, value, updatedAt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbHistory &&
          other.id == this.id &&
          other.type == this.type &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt &&
          other.createdAt == this.createdAt);
}

class DbHistoriesCompanion extends UpdateCompanion<DbHistory> {
  final Value<BigInt> id;
  final Value<HistoryType> type;
  final Value<double> value;
  final Value<DateTime> updatedAt;
  final Value<DateTime> createdAt;
  const DbHistoriesCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  DbHistoriesCompanion.insert({
    this.id = const Value.absent(),
    required HistoryType type,
    required double value,
    required DateTime updatedAt,
    required DateTime createdAt,
  }) : type = Value(type),
       value = Value(value),
       updatedAt = Value(updatedAt),
       createdAt = Value(createdAt);
  static Insertable<DbHistory> custom({
    Expression<BigInt>? id,
    Expression<String>? type,
    Expression<double>? value,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  DbHistoriesCompanion copyWith({
    Value<BigInt>? id,
    Value<HistoryType>? type,
    Value<double>? value,
    Value<DateTime>? updatedAt,
    Value<DateTime>? createdAt,
  }) {
    return DbHistoriesCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<BigInt>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $DbHistoriesTable.$convertertype.toSql(type.value),
      );
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbHistoriesCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DbUserProfilesTable dbUserProfiles = $DbUserProfilesTable(this);
  late final $DbOnboardingDatasTable dbOnboardingDatas =
      $DbOnboardingDatasTable(this);
  late final $DbRemindersTable dbReminders = $DbRemindersTable(this);
  late final $DbMealDatasTable dbMealDatas = $DbMealDatasTable(this);
  late final $DbNutritionPlansTable dbNutritionPlans = $DbNutritionPlansTable(
    this,
  );
  late final $DbStreakRecordsTable dbStreakRecords = $DbStreakRecordsTable(
    this,
  );
  late final $DbHistoriesTable dbHistories = $DbHistoriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    dbUserProfiles,
    dbOnboardingDatas,
    dbReminders,
    dbMealDatas,
    dbNutritionPlans,
    dbStreakRecords,
    dbHistories,
  ];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$DbUserProfilesTableCreateCompanionBuilder =
    DbUserProfilesCompanion Function({
      Value<BigInt> id,
      required Gender gender,
      required WorkoutFrequency workoutFrequency,
      required bool isMetric,
      required Diet diet,
      required bool isOnboardingComplete,
      required DateTime dob,
      required String gptApiKey,
      required double heightCm,
      required double weightKg,
      required double weightGoalKg,
      required DateTime updatedAt,
      required DateTime createdAt,
    });
typedef $$DbUserProfilesTableUpdateCompanionBuilder =
    DbUserProfilesCompanion Function({
      Value<BigInt> id,
      Value<Gender> gender,
      Value<WorkoutFrequency> workoutFrequency,
      Value<bool> isMetric,
      Value<Diet> diet,
      Value<bool> isOnboardingComplete,
      Value<DateTime> dob,
      Value<String> gptApiKey,
      Value<double> heightCm,
      Value<double> weightKg,
      Value<double> weightGoalKg,
      Value<DateTime> updatedAt,
      Value<DateTime> createdAt,
    });

class $$DbUserProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $DbUserProfilesTable> {
  $$DbUserProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<BigInt> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Gender, Gender, String> get gender =>
      $composableBuilder(
        column: $table.gender,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<WorkoutFrequency, WorkoutFrequency, String>
  get workoutFrequency => $composableBuilder(
    column: $table.workoutFrequency,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get isMetric => $composableBuilder(
    column: $table.isMetric,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Diet, Diet, String> get diet =>
      $composableBuilder(
        column: $table.diet,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<bool> get isOnboardingComplete => $composableBuilder(
    column: $table.isOnboardingComplete,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dob => $composableBuilder(
    column: $table.dob,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gptApiKey => $composableBuilder(
    column: $table.gptApiKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightGoalKg => $composableBuilder(
    column: $table.weightGoalKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DbUserProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $DbUserProfilesTable> {
  $$DbUserProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<BigInt> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workoutFrequency => $composableBuilder(
    column: $table.workoutFrequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMetric => $composableBuilder(
    column: $table.isMetric,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get diet => $composableBuilder(
    column: $table.diet,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isOnboardingComplete => $composableBuilder(
    column: $table.isOnboardingComplete,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dob => $composableBuilder(
    column: $table.dob,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gptApiKey => $composableBuilder(
    column: $table.gptApiKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightGoalKg => $composableBuilder(
    column: $table.weightGoalKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DbUserProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DbUserProfilesTable> {
  $$DbUserProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<BigInt> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Gender, String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumnWithTypeConverter<WorkoutFrequency, String>
  get workoutFrequency => $composableBuilder(
    column: $table.workoutFrequency,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isMetric =>
      $composableBuilder(column: $table.isMetric, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Diet, String> get diet =>
      $composableBuilder(column: $table.diet, builder: (column) => column);

  GeneratedColumn<bool> get isOnboardingComplete => $composableBuilder(
    column: $table.isOnboardingComplete,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dob =>
      $composableBuilder(column: $table.dob, builder: (column) => column);

  GeneratedColumn<String> get gptApiKey =>
      $composableBuilder(column: $table.gptApiKey, builder: (column) => column);

  GeneratedColumn<double> get heightCm =>
      $composableBuilder(column: $table.heightCm, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<double> get weightGoalKg => $composableBuilder(
    column: $table.weightGoalKg,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DbUserProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DbUserProfilesTable,
          DbUserProfile,
          $$DbUserProfilesTableFilterComposer,
          $$DbUserProfilesTableOrderingComposer,
          $$DbUserProfilesTableAnnotationComposer,
          $$DbUserProfilesTableCreateCompanionBuilder,
          $$DbUserProfilesTableUpdateCompanionBuilder,
          (
            DbUserProfile,
            BaseReferences<_$AppDatabase, $DbUserProfilesTable, DbUserProfile>,
          ),
          DbUserProfile,
          PrefetchHooks Function()
        > {
  $$DbUserProfilesTableTableManager(
    _$AppDatabase db,
    $DbUserProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$DbUserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$DbUserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$DbUserProfilesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<BigInt> id = const Value.absent(),
                Value<Gender> gender = const Value.absent(),
                Value<WorkoutFrequency> workoutFrequency = const Value.absent(),
                Value<bool> isMetric = const Value.absent(),
                Value<Diet> diet = const Value.absent(),
                Value<bool> isOnboardingComplete = const Value.absent(),
                Value<DateTime> dob = const Value.absent(),
                Value<String> gptApiKey = const Value.absent(),
                Value<double> heightCm = const Value.absent(),
                Value<double> weightKg = const Value.absent(),
                Value<double> weightGoalKg = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => DbUserProfilesCompanion(
                id: id,
                gender: gender,
                workoutFrequency: workoutFrequency,
                isMetric: isMetric,
                diet: diet,
                isOnboardingComplete: isOnboardingComplete,
                dob: dob,
                gptApiKey: gptApiKey,
                heightCm: heightCm,
                weightKg: weightKg,
                weightGoalKg: weightGoalKg,
                updatedAt: updatedAt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<BigInt> id = const Value.absent(),
                required Gender gender,
                required WorkoutFrequency workoutFrequency,
                required bool isMetric,
                required Diet diet,
                required bool isOnboardingComplete,
                required DateTime dob,
                required String gptApiKey,
                required double heightCm,
                required double weightKg,
                required double weightGoalKg,
                required DateTime updatedAt,
                required DateTime createdAt,
              }) => DbUserProfilesCompanion.insert(
                id: id,
                gender: gender,
                workoutFrequency: workoutFrequency,
                isMetric: isMetric,
                diet: diet,
                isOnboardingComplete: isOnboardingComplete,
                dob: dob,
                gptApiKey: gptApiKey,
                heightCm: heightCm,
                weightKg: weightKg,
                weightGoalKg: weightGoalKg,
                updatedAt: updatedAt,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DbUserProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DbUserProfilesTable,
      DbUserProfile,
      $$DbUserProfilesTableFilterComposer,
      $$DbUserProfilesTableOrderingComposer,
      $$DbUserProfilesTableAnnotationComposer,
      $$DbUserProfilesTableCreateCompanionBuilder,
      $$DbUserProfilesTableUpdateCompanionBuilder,
      (
        DbUserProfile,
        BaseReferences<_$AppDatabase, $DbUserProfilesTable, DbUserProfile>,
      ),
      DbUserProfile,
      PrefetchHooks Function()
    >;
typedef $$DbOnboardingDatasTableCreateCompanionBuilder =
    DbOnboardingDatasCompanion Function({
      Value<BigInt> id,
      required OnboardingStep currentStep,
      Value<Gender?> gender,
      Value<WorkoutFrequency?> workoutFrequency,
      Value<bool?> isMetric,
      Value<Diet?> diet,
      Value<DateTime?> dob,
      Value<String?> gptApiKey,
      Value<double?> heightCm,
      Value<double?> weightKg,
      Value<double?> weightGoalKg,
      required DateTime updatedAt,
      required DateTime createdAt,
    });
typedef $$DbOnboardingDatasTableUpdateCompanionBuilder =
    DbOnboardingDatasCompanion Function({
      Value<BigInt> id,
      Value<OnboardingStep> currentStep,
      Value<Gender?> gender,
      Value<WorkoutFrequency?> workoutFrequency,
      Value<bool?> isMetric,
      Value<Diet?> diet,
      Value<DateTime?> dob,
      Value<String?> gptApiKey,
      Value<double?> heightCm,
      Value<double?> weightKg,
      Value<double?> weightGoalKg,
      Value<DateTime> updatedAt,
      Value<DateTime> createdAt,
    });

final class $$DbOnboardingDatasTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $DbOnboardingDatasTable,
          DbOnboardingData
        > {
  $$DbOnboardingDatasTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$DbRemindersTable, List<DbReminder>>
  _dbRemindersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.dbReminders,
    aliasName: $_aliasNameGenerator(
      db.dbOnboardingDatas.id,
      db.dbReminders.onboardingData,
    ),
  );

  $$DbRemindersTableProcessedTableManager get dbRemindersRefs {
    final manager = $$DbRemindersTableTableManager(
      $_db,
      $_db.dbReminders,
    ).filter((f) => f.onboardingData.id.sqlEquals($_itemColumn<BigInt>('id')!));

    final cache = $_typedResult.readTableOrNull(_dbRemindersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DbOnboardingDatasTableFilterComposer
    extends Composer<_$AppDatabase, $DbOnboardingDatasTable> {
  $$DbOnboardingDatasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<BigInt> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<OnboardingStep, OnboardingStep, String>
  get currentStep => $composableBuilder(
    column: $table.currentStep,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<Gender?, Gender, String> get gender =>
      $composableBuilder(
        column: $table.gender,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<WorkoutFrequency?, WorkoutFrequency, String>
  get workoutFrequency => $composableBuilder(
    column: $table.workoutFrequency,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get isMetric => $composableBuilder(
    column: $table.isMetric,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Diet?, Diet, String> get diet =>
      $composableBuilder(
        column: $table.diet,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get dob => $composableBuilder(
    column: $table.dob,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gptApiKey => $composableBuilder(
    column: $table.gptApiKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightGoalKg => $composableBuilder(
    column: $table.weightGoalKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> dbRemindersRefs(
    Expression<bool> Function($$DbRemindersTableFilterComposer f) f,
  ) {
    final $$DbRemindersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dbReminders,
      getReferencedColumn: (t) => t.onboardingData,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbRemindersTableFilterComposer(
            $db: $db,
            $table: $db.dbReminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DbOnboardingDatasTableOrderingComposer
    extends Composer<_$AppDatabase, $DbOnboardingDatasTable> {
  $$DbOnboardingDatasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<BigInt> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentStep => $composableBuilder(
    column: $table.currentStep,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workoutFrequency => $composableBuilder(
    column: $table.workoutFrequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMetric => $composableBuilder(
    column: $table.isMetric,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get diet => $composableBuilder(
    column: $table.diet,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dob => $composableBuilder(
    column: $table.dob,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gptApiKey => $composableBuilder(
    column: $table.gptApiKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightGoalKg => $composableBuilder(
    column: $table.weightGoalKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DbOnboardingDatasTableAnnotationComposer
    extends Composer<_$AppDatabase, $DbOnboardingDatasTable> {
  $$DbOnboardingDatasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<BigInt> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<OnboardingStep, String> get currentStep =>
      $composableBuilder(
        column: $table.currentStep,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<Gender?, String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumnWithTypeConverter<WorkoutFrequency?, String>
  get workoutFrequency => $composableBuilder(
    column: $table.workoutFrequency,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isMetric =>
      $composableBuilder(column: $table.isMetric, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Diet?, String> get diet =>
      $composableBuilder(column: $table.diet, builder: (column) => column);

  GeneratedColumn<DateTime> get dob =>
      $composableBuilder(column: $table.dob, builder: (column) => column);

  GeneratedColumn<String> get gptApiKey =>
      $composableBuilder(column: $table.gptApiKey, builder: (column) => column);

  GeneratedColumn<double> get heightCm =>
      $composableBuilder(column: $table.heightCm, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<double> get weightGoalKg => $composableBuilder(
    column: $table.weightGoalKg,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> dbRemindersRefs<T extends Object>(
    Expression<T> Function($$DbRemindersTableAnnotationComposer a) f,
  ) {
    final $$DbRemindersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.dbReminders,
      getReferencedColumn: (t) => t.onboardingData,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbRemindersTableAnnotationComposer(
            $db: $db,
            $table: $db.dbReminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DbOnboardingDatasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DbOnboardingDatasTable,
          DbOnboardingData,
          $$DbOnboardingDatasTableFilterComposer,
          $$DbOnboardingDatasTableOrderingComposer,
          $$DbOnboardingDatasTableAnnotationComposer,
          $$DbOnboardingDatasTableCreateCompanionBuilder,
          $$DbOnboardingDatasTableUpdateCompanionBuilder,
          (DbOnboardingData, $$DbOnboardingDatasTableReferences),
          DbOnboardingData,
          PrefetchHooks Function({bool dbRemindersRefs})
        > {
  $$DbOnboardingDatasTableTableManager(
    _$AppDatabase db,
    $DbOnboardingDatasTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$DbOnboardingDatasTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$DbOnboardingDatasTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$DbOnboardingDatasTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<BigInt> id = const Value.absent(),
                Value<OnboardingStep> currentStep = const Value.absent(),
                Value<Gender?> gender = const Value.absent(),
                Value<WorkoutFrequency?> workoutFrequency =
                    const Value.absent(),
                Value<bool?> isMetric = const Value.absent(),
                Value<Diet?> diet = const Value.absent(),
                Value<DateTime?> dob = const Value.absent(),
                Value<String?> gptApiKey = const Value.absent(),
                Value<double?> heightCm = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<double?> weightGoalKg = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => DbOnboardingDatasCompanion(
                id: id,
                currentStep: currentStep,
                gender: gender,
                workoutFrequency: workoutFrequency,
                isMetric: isMetric,
                diet: diet,
                dob: dob,
                gptApiKey: gptApiKey,
                heightCm: heightCm,
                weightKg: weightKg,
                weightGoalKg: weightGoalKg,
                updatedAt: updatedAt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<BigInt> id = const Value.absent(),
                required OnboardingStep currentStep,
                Value<Gender?> gender = const Value.absent(),
                Value<WorkoutFrequency?> workoutFrequency =
                    const Value.absent(),
                Value<bool?> isMetric = const Value.absent(),
                Value<Diet?> diet = const Value.absent(),
                Value<DateTime?> dob = const Value.absent(),
                Value<String?> gptApiKey = const Value.absent(),
                Value<double?> heightCm = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<double?> weightGoalKg = const Value.absent(),
                required DateTime updatedAt,
                required DateTime createdAt,
              }) => DbOnboardingDatasCompanion.insert(
                id: id,
                currentStep: currentStep,
                gender: gender,
                workoutFrequency: workoutFrequency,
                isMetric: isMetric,
                diet: diet,
                dob: dob,
                gptApiKey: gptApiKey,
                heightCm: heightCm,
                weightKg: weightKg,
                weightGoalKg: weightGoalKg,
                updatedAt: updatedAt,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$DbOnboardingDatasTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({dbRemindersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (dbRemindersRefs) db.dbReminders],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (dbRemindersRefs)
                    await $_getPrefetchedData<
                      DbOnboardingData,
                      $DbOnboardingDatasTable,
                      DbReminder
                    >(
                      currentTable: table,
                      referencedTable: $$DbOnboardingDatasTableReferences
                          ._dbRemindersRefsTable(db),
                      managerFromTypedResult:
                          (p0) =>
                              $$DbOnboardingDatasTableReferences(
                                db,
                                table,
                                p0,
                              ).dbRemindersRefs,
                      referencedItemsForCurrentItem:
                          (item, referencedItems) => referencedItems.where(
                            (e) => e.onboardingData == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$DbOnboardingDatasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DbOnboardingDatasTable,
      DbOnboardingData,
      $$DbOnboardingDatasTableFilterComposer,
      $$DbOnboardingDatasTableOrderingComposer,
      $$DbOnboardingDatasTableAnnotationComposer,
      $$DbOnboardingDatasTableCreateCompanionBuilder,
      $$DbOnboardingDatasTableUpdateCompanionBuilder,
      (DbOnboardingData, $$DbOnboardingDatasTableReferences),
      DbOnboardingData,
      PrefetchHooks Function({bool dbRemindersRefs})
    >;
typedef $$DbRemindersTableCreateCompanionBuilder =
    DbRemindersCompanion Function({
      Value<BigInt> id,
      required DbReminderType type,
      required String label,
      Value<int?> hour,
      Value<int?> minute,
      required DateTime updatedAt,
      required DateTime createdAt,
      Value<BigInt?> onboardingData,
    });
typedef $$DbRemindersTableUpdateCompanionBuilder =
    DbRemindersCompanion Function({
      Value<BigInt> id,
      Value<DbReminderType> type,
      Value<String> label,
      Value<int?> hour,
      Value<int?> minute,
      Value<DateTime> updatedAt,
      Value<DateTime> createdAt,
      Value<BigInt?> onboardingData,
    });

final class $$DbRemindersTableReferences
    extends BaseReferences<_$AppDatabase, $DbRemindersTable, DbReminder> {
  $$DbRemindersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DbOnboardingDatasTable _onboardingDataTable(_$AppDatabase db) =>
      db.dbOnboardingDatas.createAlias(
        $_aliasNameGenerator(
          db.dbReminders.onboardingData,
          db.dbOnboardingDatas.id,
        ),
      );

  $$DbOnboardingDatasTableProcessedTableManager? get onboardingData {
    final $_column = $_itemColumn<BigInt>('onboarding_data');
    if ($_column == null) return null;
    final manager = $$DbOnboardingDatasTableTableManager(
      $_db,
      $_db.dbOnboardingDatas,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_onboardingDataTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DbRemindersTableFilterComposer
    extends Composer<_$AppDatabase, $DbRemindersTable> {
  $$DbRemindersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<BigInt> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DbReminderType, DbReminderType, String>
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hour => $composableBuilder(
    column: $table.hour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minute => $composableBuilder(
    column: $table.minute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$DbOnboardingDatasTableFilterComposer get onboardingData {
    final $$DbOnboardingDatasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.onboardingData,
      referencedTable: $db.dbOnboardingDatas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbOnboardingDatasTableFilterComposer(
            $db: $db,
            $table: $db.dbOnboardingDatas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DbRemindersTableOrderingComposer
    extends Composer<_$AppDatabase, $DbRemindersTable> {
  $$DbRemindersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<BigInt> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hour => $composableBuilder(
    column: $table.hour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minute => $composableBuilder(
    column: $table.minute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$DbOnboardingDatasTableOrderingComposer get onboardingData {
    final $$DbOnboardingDatasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.onboardingData,
      referencedTable: $db.dbOnboardingDatas,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DbOnboardingDatasTableOrderingComposer(
            $db: $db,
            $table: $db.dbOnboardingDatas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DbRemindersTableAnnotationComposer
    extends Composer<_$AppDatabase, $DbRemindersTable> {
  $$DbRemindersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<BigInt> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DbReminderType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<int> get hour =>
      $composableBuilder(column: $table.hour, builder: (column) => column);

  GeneratedColumn<int> get minute =>
      $composableBuilder(column: $table.minute, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$DbOnboardingDatasTableAnnotationComposer get onboardingData {
    final $$DbOnboardingDatasTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.onboardingData,
          referencedTable: $db.dbOnboardingDatas,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$DbOnboardingDatasTableAnnotationComposer(
                $db: $db,
                $table: $db.dbOnboardingDatas,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$DbRemindersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DbRemindersTable,
          DbReminder,
          $$DbRemindersTableFilterComposer,
          $$DbRemindersTableOrderingComposer,
          $$DbRemindersTableAnnotationComposer,
          $$DbRemindersTableCreateCompanionBuilder,
          $$DbRemindersTableUpdateCompanionBuilder,
          (DbReminder, $$DbRemindersTableReferences),
          DbReminder,
          PrefetchHooks Function({bool onboardingData})
        > {
  $$DbRemindersTableTableManager(_$AppDatabase db, $DbRemindersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$DbRemindersTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$DbRemindersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$DbRemindersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<BigInt> id = const Value.absent(),
                Value<DbReminderType> type = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<int?> hour = const Value.absent(),
                Value<int?> minute = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<BigInt?> onboardingData = const Value.absent(),
              }) => DbRemindersCompanion(
                id: id,
                type: type,
                label: label,
                hour: hour,
                minute: minute,
                updatedAt: updatedAt,
                createdAt: createdAt,
                onboardingData: onboardingData,
              ),
          createCompanionCallback:
              ({
                Value<BigInt> id = const Value.absent(),
                required DbReminderType type,
                required String label,
                Value<int?> hour = const Value.absent(),
                Value<int?> minute = const Value.absent(),
                required DateTime updatedAt,
                required DateTime createdAt,
                Value<BigInt?> onboardingData = const Value.absent(),
              }) => DbRemindersCompanion.insert(
                id: id,
                type: type,
                label: label,
                hour: hour,
                minute: minute,
                updatedAt: updatedAt,
                createdAt: createdAt,
                onboardingData: onboardingData,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$DbRemindersTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({onboardingData = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                if (onboardingData) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.onboardingData,
                            referencedTable: $$DbRemindersTableReferences
                                ._onboardingDataTable(db),
                            referencedColumn:
                                $$DbRemindersTableReferences
                                    ._onboardingDataTable(db)
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

typedef $$DbRemindersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DbRemindersTable,
      DbReminder,
      $$DbRemindersTableFilterComposer,
      $$DbRemindersTableOrderingComposer,
      $$DbRemindersTableAnnotationComposer,
      $$DbRemindersTableCreateCompanionBuilder,
      $$DbRemindersTableUpdateCompanionBuilder,
      (DbReminder, $$DbRemindersTableReferences),
      DbReminder,
      PrefetchHooks Function({bool onboardingData})
    >;
typedef $$DbMealDatasTableCreateCompanionBuilder =
    DbMealDatasCompanion Function({
      Value<BigInt> id,
      required double calories,
      required double protein,
      required double carbs,
      required double fats,
      required double water,
      required String mealName,
      Value<String?> mealDescription,
      required DateTime updatedAt,
      required DateTime createdAt,
    });
typedef $$DbMealDatasTableUpdateCompanionBuilder =
    DbMealDatasCompanion Function({
      Value<BigInt> id,
      Value<double> calories,
      Value<double> protein,
      Value<double> carbs,
      Value<double> fats,
      Value<double> water,
      Value<String> mealName,
      Value<String?> mealDescription,
      Value<DateTime> updatedAt,
      Value<DateTime> createdAt,
    });

class $$DbMealDatasTableFilterComposer
    extends Composer<_$AppDatabase, $DbMealDatasTable> {
  $$DbMealDatasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<BigInt> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get calories => $composableBuilder(
    column: $table.calories,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get protein => $composableBuilder(
    column: $table.protein,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbs => $composableBuilder(
    column: $table.carbs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fats => $composableBuilder(
    column: $table.fats,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get water => $composableBuilder(
    column: $table.water,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mealName => $composableBuilder(
    column: $table.mealName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mealDescription => $composableBuilder(
    column: $table.mealDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DbMealDatasTableOrderingComposer
    extends Composer<_$AppDatabase, $DbMealDatasTable> {
  $$DbMealDatasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<BigInt> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get calories => $composableBuilder(
    column: $table.calories,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get protein => $composableBuilder(
    column: $table.protein,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbs => $composableBuilder(
    column: $table.carbs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fats => $composableBuilder(
    column: $table.fats,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get water => $composableBuilder(
    column: $table.water,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mealName => $composableBuilder(
    column: $table.mealName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mealDescription => $composableBuilder(
    column: $table.mealDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DbMealDatasTableAnnotationComposer
    extends Composer<_$AppDatabase, $DbMealDatasTable> {
  $$DbMealDatasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<BigInt> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get calories =>
      $composableBuilder(column: $table.calories, builder: (column) => column);

  GeneratedColumn<double> get protein =>
      $composableBuilder(column: $table.protein, builder: (column) => column);

  GeneratedColumn<double> get carbs =>
      $composableBuilder(column: $table.carbs, builder: (column) => column);

  GeneratedColumn<double> get fats =>
      $composableBuilder(column: $table.fats, builder: (column) => column);

  GeneratedColumn<double> get water =>
      $composableBuilder(column: $table.water, builder: (column) => column);

  GeneratedColumn<String> get mealName =>
      $composableBuilder(column: $table.mealName, builder: (column) => column);

  GeneratedColumn<String> get mealDescription => $composableBuilder(
    column: $table.mealDescription,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DbMealDatasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DbMealDatasTable,
          DbMealData,
          $$DbMealDatasTableFilterComposer,
          $$DbMealDatasTableOrderingComposer,
          $$DbMealDatasTableAnnotationComposer,
          $$DbMealDatasTableCreateCompanionBuilder,
          $$DbMealDatasTableUpdateCompanionBuilder,
          (
            DbMealData,
            BaseReferences<_$AppDatabase, $DbMealDatasTable, DbMealData>,
          ),
          DbMealData,
          PrefetchHooks Function()
        > {
  $$DbMealDatasTableTableManager(_$AppDatabase db, $DbMealDatasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$DbMealDatasTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$DbMealDatasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$DbMealDatasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<BigInt> id = const Value.absent(),
                Value<double> calories = const Value.absent(),
                Value<double> protein = const Value.absent(),
                Value<double> carbs = const Value.absent(),
                Value<double> fats = const Value.absent(),
                Value<double> water = const Value.absent(),
                Value<String> mealName = const Value.absent(),
                Value<String?> mealDescription = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => DbMealDatasCompanion(
                id: id,
                calories: calories,
                protein: protein,
                carbs: carbs,
                fats: fats,
                water: water,
                mealName: mealName,
                mealDescription: mealDescription,
                updatedAt: updatedAt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<BigInt> id = const Value.absent(),
                required double calories,
                required double protein,
                required double carbs,
                required double fats,
                required double water,
                required String mealName,
                Value<String?> mealDescription = const Value.absent(),
                required DateTime updatedAt,
                required DateTime createdAt,
              }) => DbMealDatasCompanion.insert(
                id: id,
                calories: calories,
                protein: protein,
                carbs: carbs,
                fats: fats,
                water: water,
                mealName: mealName,
                mealDescription: mealDescription,
                updatedAt: updatedAt,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DbMealDatasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DbMealDatasTable,
      DbMealData,
      $$DbMealDatasTableFilterComposer,
      $$DbMealDatasTableOrderingComposer,
      $$DbMealDatasTableAnnotationComposer,
      $$DbMealDatasTableCreateCompanionBuilder,
      $$DbMealDatasTableUpdateCompanionBuilder,
      (
        DbMealData,
        BaseReferences<_$AppDatabase, $DbMealDatasTable, DbMealData>,
      ),
      DbMealData,
      PrefetchHooks Function()
    >;
typedef $$DbNutritionPlansTableCreateCompanionBuilder =
    DbNutritionPlansCompanion Function({
      Value<BigInt> id,
      required int timeframeInWeeks,
      required int calories,
      required double proteinG,
      required double carbsG,
      required double fatsG,
      required double waterLiters,
      required String gymAdvice,
      required String medicalAdvice,
      required String warnings,
      required DateTime updatedAt,
      required DateTime createdAt,
    });
typedef $$DbNutritionPlansTableUpdateCompanionBuilder =
    DbNutritionPlansCompanion Function({
      Value<BigInt> id,
      Value<int> timeframeInWeeks,
      Value<int> calories,
      Value<double> proteinG,
      Value<double> carbsG,
      Value<double> fatsG,
      Value<double> waterLiters,
      Value<String> gymAdvice,
      Value<String> medicalAdvice,
      Value<String> warnings,
      Value<DateTime> updatedAt,
      Value<DateTime> createdAt,
    });

class $$DbNutritionPlansTableFilterComposer
    extends Composer<_$AppDatabase, $DbNutritionPlansTable> {
  $$DbNutritionPlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<BigInt> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timeframeInWeeks => $composableBuilder(
    column: $table.timeframeInWeeks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get calories => $composableBuilder(
    column: $table.calories,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinG => $composableBuilder(
    column: $table.proteinG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbsG => $composableBuilder(
    column: $table.carbsG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatsG => $composableBuilder(
    column: $table.fatsG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get waterLiters => $composableBuilder(
    column: $table.waterLiters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gymAdvice => $composableBuilder(
    column: $table.gymAdvice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get medicalAdvice => $composableBuilder(
    column: $table.medicalAdvice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get warnings => $composableBuilder(
    column: $table.warnings,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DbNutritionPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $DbNutritionPlansTable> {
  $$DbNutritionPlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<BigInt> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timeframeInWeeks => $composableBuilder(
    column: $table.timeframeInWeeks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get calories => $composableBuilder(
    column: $table.calories,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinG => $composableBuilder(
    column: $table.proteinG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbsG => $composableBuilder(
    column: $table.carbsG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatsG => $composableBuilder(
    column: $table.fatsG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get waterLiters => $composableBuilder(
    column: $table.waterLiters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gymAdvice => $composableBuilder(
    column: $table.gymAdvice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get medicalAdvice => $composableBuilder(
    column: $table.medicalAdvice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get warnings => $composableBuilder(
    column: $table.warnings,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DbNutritionPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $DbNutritionPlansTable> {
  $$DbNutritionPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<BigInt> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get timeframeInWeeks => $composableBuilder(
    column: $table.timeframeInWeeks,
    builder: (column) => column,
  );

  GeneratedColumn<int> get calories =>
      $composableBuilder(column: $table.calories, builder: (column) => column);

  GeneratedColumn<double> get proteinG =>
      $composableBuilder(column: $table.proteinG, builder: (column) => column);

  GeneratedColumn<double> get carbsG =>
      $composableBuilder(column: $table.carbsG, builder: (column) => column);

  GeneratedColumn<double> get fatsG =>
      $composableBuilder(column: $table.fatsG, builder: (column) => column);

  GeneratedColumn<double> get waterLiters => $composableBuilder(
    column: $table.waterLiters,
    builder: (column) => column,
  );

  GeneratedColumn<String> get gymAdvice =>
      $composableBuilder(column: $table.gymAdvice, builder: (column) => column);

  GeneratedColumn<String> get medicalAdvice => $composableBuilder(
    column: $table.medicalAdvice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get warnings =>
      $composableBuilder(column: $table.warnings, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DbNutritionPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DbNutritionPlansTable,
          DbNutritionPlan,
          $$DbNutritionPlansTableFilterComposer,
          $$DbNutritionPlansTableOrderingComposer,
          $$DbNutritionPlansTableAnnotationComposer,
          $$DbNutritionPlansTableCreateCompanionBuilder,
          $$DbNutritionPlansTableUpdateCompanionBuilder,
          (
            DbNutritionPlan,
            BaseReferences<
              _$AppDatabase,
              $DbNutritionPlansTable,
              DbNutritionPlan
            >,
          ),
          DbNutritionPlan,
          PrefetchHooks Function()
        > {
  $$DbNutritionPlansTableTableManager(
    _$AppDatabase db,
    $DbNutritionPlansTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$DbNutritionPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$DbNutritionPlansTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$DbNutritionPlansTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<BigInt> id = const Value.absent(),
                Value<int> timeframeInWeeks = const Value.absent(),
                Value<int> calories = const Value.absent(),
                Value<double> proteinG = const Value.absent(),
                Value<double> carbsG = const Value.absent(),
                Value<double> fatsG = const Value.absent(),
                Value<double> waterLiters = const Value.absent(),
                Value<String> gymAdvice = const Value.absent(),
                Value<String> medicalAdvice = const Value.absent(),
                Value<String> warnings = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => DbNutritionPlansCompanion(
                id: id,
                timeframeInWeeks: timeframeInWeeks,
                calories: calories,
                proteinG: proteinG,
                carbsG: carbsG,
                fatsG: fatsG,
                waterLiters: waterLiters,
                gymAdvice: gymAdvice,
                medicalAdvice: medicalAdvice,
                warnings: warnings,
                updatedAt: updatedAt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<BigInt> id = const Value.absent(),
                required int timeframeInWeeks,
                required int calories,
                required double proteinG,
                required double carbsG,
                required double fatsG,
                required double waterLiters,
                required String gymAdvice,
                required String medicalAdvice,
                required String warnings,
                required DateTime updatedAt,
                required DateTime createdAt,
              }) => DbNutritionPlansCompanion.insert(
                id: id,
                timeframeInWeeks: timeframeInWeeks,
                calories: calories,
                proteinG: proteinG,
                carbsG: carbsG,
                fatsG: fatsG,
                waterLiters: waterLiters,
                gymAdvice: gymAdvice,
                medicalAdvice: medicalAdvice,
                warnings: warnings,
                updatedAt: updatedAt,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DbNutritionPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DbNutritionPlansTable,
      DbNutritionPlan,
      $$DbNutritionPlansTableFilterComposer,
      $$DbNutritionPlansTableOrderingComposer,
      $$DbNutritionPlansTableAnnotationComposer,
      $$DbNutritionPlansTableCreateCompanionBuilder,
      $$DbNutritionPlansTableUpdateCompanionBuilder,
      (
        DbNutritionPlan,
        BaseReferences<_$AppDatabase, $DbNutritionPlansTable, DbNutritionPlan>,
      ),
      DbNutritionPlan,
      PrefetchHooks Function()
    >;
typedef $$DbStreakRecordsTableCreateCompanionBuilder =
    DbStreakRecordsCompanion Function({
      Value<int> id,
      required int count,
      required DateTime updatedAt,
      required DateTime createdAt,
    });
typedef $$DbStreakRecordsTableUpdateCompanionBuilder =
    DbStreakRecordsCompanion Function({
      Value<int> id,
      Value<int> count,
      Value<DateTime> updatedAt,
      Value<DateTime> createdAt,
    });

class $$DbStreakRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $DbStreakRecordsTable> {
  $$DbStreakRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DbStreakRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $DbStreakRecordsTable> {
  $$DbStreakRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DbStreakRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DbStreakRecordsTable> {
  $$DbStreakRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get count =>
      $composableBuilder(column: $table.count, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DbStreakRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DbStreakRecordsTable,
          DbStreakRecord,
          $$DbStreakRecordsTableFilterComposer,
          $$DbStreakRecordsTableOrderingComposer,
          $$DbStreakRecordsTableAnnotationComposer,
          $$DbStreakRecordsTableCreateCompanionBuilder,
          $$DbStreakRecordsTableUpdateCompanionBuilder,
          (
            DbStreakRecord,
            BaseReferences<
              _$AppDatabase,
              $DbStreakRecordsTable,
              DbStreakRecord
            >,
          ),
          DbStreakRecord,
          PrefetchHooks Function()
        > {
  $$DbStreakRecordsTableTableManager(
    _$AppDatabase db,
    $DbStreakRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$DbStreakRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$DbStreakRecordsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$DbStreakRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> count = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => DbStreakRecordsCompanion(
                id: id,
                count: count,
                updatedAt: updatedAt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int count,
                required DateTime updatedAt,
                required DateTime createdAt,
              }) => DbStreakRecordsCompanion.insert(
                id: id,
                count: count,
                updatedAt: updatedAt,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DbStreakRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DbStreakRecordsTable,
      DbStreakRecord,
      $$DbStreakRecordsTableFilterComposer,
      $$DbStreakRecordsTableOrderingComposer,
      $$DbStreakRecordsTableAnnotationComposer,
      $$DbStreakRecordsTableCreateCompanionBuilder,
      $$DbStreakRecordsTableUpdateCompanionBuilder,
      (
        DbStreakRecord,
        BaseReferences<_$AppDatabase, $DbStreakRecordsTable, DbStreakRecord>,
      ),
      DbStreakRecord,
      PrefetchHooks Function()
    >;
typedef $$DbHistoriesTableCreateCompanionBuilder =
    DbHistoriesCompanion Function({
      Value<BigInt> id,
      required HistoryType type,
      required double value,
      required DateTime updatedAt,
      required DateTime createdAt,
    });
typedef $$DbHistoriesTableUpdateCompanionBuilder =
    DbHistoriesCompanion Function({
      Value<BigInt> id,
      Value<HistoryType> type,
      Value<double> value,
      Value<DateTime> updatedAt,
      Value<DateTime> createdAt,
    });

class $$DbHistoriesTableFilterComposer
    extends Composer<_$AppDatabase, $DbHistoriesTable> {
  $$DbHistoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<BigInt> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<HistoryType, HistoryType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DbHistoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $DbHistoriesTable> {
  $$DbHistoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<BigInt> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DbHistoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DbHistoriesTable> {
  $$DbHistoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<BigInt> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<HistoryType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DbHistoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DbHistoriesTable,
          DbHistory,
          $$DbHistoriesTableFilterComposer,
          $$DbHistoriesTableOrderingComposer,
          $$DbHistoriesTableAnnotationComposer,
          $$DbHistoriesTableCreateCompanionBuilder,
          $$DbHistoriesTableUpdateCompanionBuilder,
          (
            DbHistory,
            BaseReferences<_$AppDatabase, $DbHistoriesTable, DbHistory>,
          ),
          DbHistory,
          PrefetchHooks Function()
        > {
  $$DbHistoriesTableTableManager(_$AppDatabase db, $DbHistoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$DbHistoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$DbHistoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$DbHistoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<BigInt> id = const Value.absent(),
                Value<HistoryType> type = const Value.absent(),
                Value<double> value = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => DbHistoriesCompanion(
                id: id,
                type: type,
                value: value,
                updatedAt: updatedAt,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<BigInt> id = const Value.absent(),
                required HistoryType type,
                required double value,
                required DateTime updatedAt,
                required DateTime createdAt,
              }) => DbHistoriesCompanion.insert(
                id: id,
                type: type,
                value: value,
                updatedAt: updatedAt,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DbHistoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DbHistoriesTable,
      DbHistory,
      $$DbHistoriesTableFilterComposer,
      $$DbHistoriesTableOrderingComposer,
      $$DbHistoriesTableAnnotationComposer,
      $$DbHistoriesTableCreateCompanionBuilder,
      $$DbHistoriesTableUpdateCompanionBuilder,
      (DbHistory, BaseReferences<_$AppDatabase, $DbHistoriesTable, DbHistory>),
      DbHistory,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DbUserProfilesTableTableManager get dbUserProfiles =>
      $$DbUserProfilesTableTableManager(_db, _db.dbUserProfiles);
  $$DbOnboardingDatasTableTableManager get dbOnboardingDatas =>
      $$DbOnboardingDatasTableTableManager(_db, _db.dbOnboardingDatas);
  $$DbRemindersTableTableManager get dbReminders =>
      $$DbRemindersTableTableManager(_db, _db.dbReminders);
  $$DbMealDatasTableTableManager get dbMealDatas =>
      $$DbMealDatasTableTableManager(_db, _db.dbMealDatas);
  $$DbNutritionPlansTableTableManager get dbNutritionPlans =>
      $$DbNutritionPlansTableTableManager(_db, _db.dbNutritionPlans);
  $$DbStreakRecordsTableTableManager get dbStreakRecords =>
      $$DbStreakRecordsTableTableManager(_db, _db.dbStreakRecords);
  $$DbHistoriesTableTableManager get dbHistories =>
      $$DbHistoriesTableTableManager(_db, _db.dbHistories);
}
