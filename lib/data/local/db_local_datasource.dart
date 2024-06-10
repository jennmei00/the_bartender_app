import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

abstract class DBLocalDatasource {
  Future<Database> openDatabase();
  Future<void> deleteDatabase();
  Future<List<Map<String, dynamic>>> getData(String table,
      {List<String>? columns, String? where, String? orderBy});
  Future<Map<String, dynamic>> getOneData(String table,
      {List<String>? columns, String? where, String? orderBy});
  Future<void> multipleInsert(
      String table, List<Map<String, dynamic>> dataList);
  Future<void> multipleInsertOrUpdate(
      String table, List<Map<String, dynamic>> dataList, String primaryKey);
  Future<void> insert(String table, Map<String, dynamic> data);
  Future<void> update(String table, Map<String, dynamic> data, {String? where});
  Future<void> delete(String table, {String? where});
  Future<int> count(String table, {String where = ''});
}

class DBLocalDatasourceImpl implements DBLocalDatasource {
  static Database? _database;
  static const int _versionNumber = 1;

  @override
  Future<Database> openDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    return _database ??= await sql.openDatabase(
        path.join(dbPath, 'RecipeDetail.db'),
        onCreate: _createTables,
        onUpgrade: _upgradeTables,
        version: _versionNumber);
  }

  @override
  Future<void> deleteDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    await sql.deleteDatabase('$dbPath/TheBartender.db');
    _database = null;
  }

  @override
  Future<List<Map<String, dynamic>>> getData(String table,
      {List<String>? columns, String? where, String? orderBy}) async {
    final db = await openDatabase();
    return db.transaction((txn) async {
      return await txn.query(table,
          columns: columns, where: where, orderBy: orderBy);
    });
  }

  @override
  Future<Map<String, dynamic>> getOneData(String table,
      {List<String>? columns, String? where, String? orderBy}) async {
    List<Map<String, dynamic>> data =
        await getData(table, columns: columns, where: where, orderBy: orderBy);

    return data[0];
  }

  @override
  Future<void> multipleInsert(
      String table, List<Map<String, dynamic>> dataList) async {
    final db = await openDatabase();
    for (var data in dataList) {
      db.insert(table, data);
    }
  }

  @override
  Future<void> multipleInsertOrUpdate(String table,
      List<Map<String, dynamic>> dataList, String primaryKey) async {
    final db = await openDatabase();

    for (var data in dataList) {
      var primaryKeyValue = data[primaryKey];
      int countInt = await count(table,
          where: "WHERE $primaryKey = '${data[primaryKey]}'");
      if (countInt > 0) {
        data.removeWhere((k, v) => k == primaryKey);
        await db.update(table, data, where: "$primaryKey = '$primaryKeyValue'");
      } else {
        await db.insert(table, data);
      }
    }
  }

  @override
  Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await openDatabase();
    await db.insert(table, data);
  }

  @override
  Future<void> update(String table, Map<String, dynamic> data,
      {String? where}) async {
    final db = await openDatabase();
    await db.update(table, data, where: where);
  }

  @override
  Future<void> delete(String table, {String? where}) async {
    final db = await openDatabase();
    await db.delete(table, where: where);
  }

  @override
  Future<int> count(String table, {String where = ''}) async {
    final db = await openDatabase();
    return await db.transaction((txn) async {
      return sql.Sqflite.firstIntValue(await txn.rawQuery(
              'SELECT COUNT(*) FROM $table${where.isNotEmpty ? ' $where' : ''}'))
          as Future<int>;
    });
  }

  Future<void> _createTables(sql.Database db, int version) async {
    await db.execute(
      'CREATE TABLE RecipeCreate(recipe_id TEXT PRIAMRY KEY, name TEXT, creation_date TEXT, edit_date TEXT, prep_time_minutes INTEGER, '
      'alcoholic BOOLEAN, instruction TEXT, description INTEGER, season_id TEXT, drink_type_id TEXT, user_id TEXT);',
    );
    await db.execute(
      'CREATE TABLE Ingredient(ingredient_id TEXT PRIAMRY KEY, name TEXT, creation_date TEXT, edit_date TEXT, prep_time_minutes INTEGER, '
      'alcoholic BOOLEAN, instruction TEXT, description INTEGER, season_id TEXT, drink_type_id TEXT, user_id TEXT);',
    );
  }

  Future<void> _upgradeTables(
      sql.Database db, int oldVersion, int newVersion) async {
    //  if (oldVersion < 2) {
    //     try {
    //       await db.execute('ALTER TABLE StandingOrder ADD AccountToID TEXT');
    //       await db.execute('ALTER TABLE Transfer ADD StandingOrderID TEXT');
    //       await db.execute('ALTER TABLE Transfer ADD IsStandingOrder BOOLEAN');
    //       // await db.execute('ALTER TABLE StandingOrder ADD FOREIGN KEY(AccountToID) REFERENCES Account(ID)');
    //     } catch (ex) {
    //       FileHelper()
    //           .writeAppLog(AppLog(ex.toString(), 'Upgrade Tables Version 2'));

    //     print('DBHelper $ex');
    //     }
    //   }
  }
}
