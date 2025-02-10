import 'package:sqflite/sqflite.dart';
import 'package:water_reminder/features/water/domain/entities/water_consumption_history.dart';

import '../../domain/entities/water_consumption.dart';
import '../../domain/repositories/water_consumption_repository.dart';

class WaterConsumptionSqliteRepositoryImpl
    implements WaterConsumptionRepository {
  final Database _db;
  static const String _tableName = 'water_consumption';
  static const String _consumedKey = 'consumed';
  static const String _targetKey = 'target';
  static const String _dateKey = 'date';
  static const double _defaultTarget = 5.0;

  @override
  Future<List<WaterConsumptionHistory>> getHistory() async {
    final result = await _db.query(_tableName, orderBy: '$_dateKey DESC');

    return result
        .map(
          (record) => WaterConsumptionHistory(
            consumed: record[_consumedKey] as double,
            target: record[_targetKey] as double,
            date: DateTime.parse(record[_dateKey] as String),
          ),
        )
        .toList();
  }

  WaterConsumptionSqliteRepositoryImpl(this._db);

  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $_tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        $_consumedKey REAL NOT NULL,
        $_targetKey REAL NOT NULL,
        $_dateKey DATETIME DEFAULT CURRENT_TIMESTAMP
      )
      ''');

    // Insert default values if table is empty
    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM $_tableName'),
    );

    if (count == 0) {
      await db.insert(_tableName, {
        _consumedKey: 0.0,
        _targetKey: _defaultTarget,
        _dateKey: DateTime.now().toIso8601String(),
      });
    }
  }

  @override
  Future<WaterConsumption> getCurrentConsumption() async {
    final today = DateTime.now();
    final todayStr =
        '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

    final result = await _db.query(
      _tableName,
      where: "date($_dateKey) = date(?)",
      whereArgs: [todayStr],
      limit: 1,
    );

    if (result.isEmpty) {
      await _db.insert(_tableName, {
        _consumedKey: 0.0,
        _targetKey: _defaultTarget,
        _dateKey: today.toIso8601String(),
      });
      return WaterConsumption(consumed: 0, target: _defaultTarget, date: today);
    }

    return WaterConsumption(
      consumed: result.first[_consumedKey] as double,
      target: result.first[_targetKey] as double,
      date: DateTime.parse(result.first[_dateKey] as String),
    );
  }

  @override
  Future<void> updateConsumption(double amount) async {
    final current = await getCurrentConsumption();
    await _db.update(
      _tableName,
      {
        _consumedKey: current.consumed + amount,
        _dateKey: DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [1],
    );
  }

  @override
  Future<void> updateTarget(double target) async {
    await _db.update(
      _tableName,
      {_targetKey: target},
      where: 'id = ?',
      whereArgs: [1],
    );
  }
}
