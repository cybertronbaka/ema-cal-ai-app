part of 'database.dart';

enum LogLevel { info, error, perf }

class LogInterceptor extends QueryInterceptor {
  LogInterceptor({this.logLevels = const []});

  final List<LogLevel> logLevels;
  Future<T> _run<T>(
    String description,
    FutureOr<T> Function() operation,
  ) async {
    final stopwatch = Stopwatch()..start();
    log(LogLevel.info, 'Running $description');

    try {
      final result = await operation();
      log(
        LogLevel.perf,
        ' => succeeded after ${stopwatch.elapsedMilliseconds}ms',
      );
      return result;
    } on Object catch (e) {
      log(
        LogLevel.error,
        ' => failed after ${stopwatch.elapsedMilliseconds}ms ($e)',
      );
      rethrow;
    }
  }

  @override
  TransactionExecutor beginTransaction(QueryExecutor parent) {
    log(LogLevel.info, 'begin transaction');
    return super.beginTransaction(parent);
  }

  @override
  Future<void> commitTransaction(TransactionExecutor inner) {
    log(LogLevel.info, 'commit transaction');
    return _run('commit', () => inner.send());
  }

  @override
  Future<void> rollbackTransaction(TransactionExecutor inner) {
    log(LogLevel.info, 'rollback transaction');
    return _run('rollback', () => inner.rollback());
  }

  @override
  Future<void> runBatched(
    QueryExecutor executor,
    BatchedStatements statements,
  ) {
    return _run(
      'batch with $statements',
      () => executor.runBatched(statements),
    );
  }

  @override
  Future<int> runInsert(
    QueryExecutor executor,
    String statement,
    List<Object?> args,
  ) {
    return _run(
      '$statement with $args',
      () => executor.runInsert(statement, args),
    );
  }

  @override
  Future<int> runUpdate(
    QueryExecutor executor,
    String statement,
    List<Object?> args,
  ) {
    return _run(
      '$statement with $args',
      () => executor.runUpdate(statement, args),
    );
  }

  @override
  Future<int> runDelete(
    QueryExecutor executor,
    String statement,
    List<Object?> args,
  ) {
    return _run(
      '$statement with $args',
      () => executor.runDelete(statement, args),
    );
  }

  @override
  Future<void> runCustom(
    QueryExecutor executor,
    String statement,
    List<Object?> args,
  ) {
    return _run(
      '$statement with $args',
      () => executor.runCustom(statement, args),
    );
  }

  @override
  Future<List<Map<String, Object?>>> runSelect(
    QueryExecutor executor,
    String statement,
    List<Object?> args,
  ) {
    return _run(
      '$statement with $args',
      () => executor.runSelect(statement, args),
    );
  }

  void log(LogLevel level, String message) {
    if (logLevels.contains(level)) {
      // ignore: avoid_print
      print(message);
    }
  }
}
