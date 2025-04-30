import 'dart:async';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:ema_cal_ai/enums/enums.dart';
import 'package:path_provider/path_provider.dart';

part 'db_user_profile.dart';
part 'db_onboarding_save.dart';
part 'db_reminders.dart';
part 'db_nutrition_plan.dart';
part 'db_meal_data.dart';
part 'db_streak_record.dart';
part 'db_history.dart';
part 'interceptor.dart';
part 'database.g.dart';

@DriftDatabase(
  tables: [
    DbUserProfiles,
    DbOnboardingDatas,
    DbReminders,
    DbMealDatas,
    DbNutritionPlans,
    DbStreakRecords,
    DbHistories,
  ],
)
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'database',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    ).interceptWith(LogInterceptor());
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // if (from < 2) {
        //   // we added the dueDate property in the change from version 1 to
        //   // version 2
        //   await m.addColumn(todos, todos.dueDate);
        // }
        // if (from < 3) {
        //   // we added the priority property in the change from version 1 or 2
        //   // to version 3
        //   await m.addColumn(todos, todos.priority);
        // }
      },
    );
  }
}
