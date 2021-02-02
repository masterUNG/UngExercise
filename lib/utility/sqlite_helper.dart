import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ungexercies/models/sqlite_model.dart';

class SQLiteHelper {
  final String namedatabase = 'ungexercise.db';
  final String nametable = 'ordertable';
  final String idcolumn = 'id';
  final String codecolumn = 'code';
  final String namecolumn = 'name';
  final String barcodecolumn = 'barcodes';
  final String pricecolumn = 'prices';
  final String unticodecolumn = 'unitcodes';
  final String amountcolumn = 'amounts';
  final String subtotalcolumn = 'subtotals';
  final int databaseversion = 1;

  SQLiteHelper() {
    initDatabase();
  }

  Future<Null> initDatabase() async {
    await openDatabase(join(await getDatabasesPath(), namedatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $nametable ($idcolumn INTEGER PRIMARY KEY, $codecolumn TEXT, $namecolumn TEXT, $barcodecolumn TEXT, $pricecolumn TEXT, $unticodecolumn TEXT, $amountcolumn TEXT, $subtotalcolumn TEXT)'),
        version: databaseversion);
  }

  Future<Database> connectedDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), namedatabase));
  }

  Future<Null> insertValueToSQLite(Map<String, dynamic> map) async {
    Database database = await connectedDatabase();
    try {
      database.insert(
        nametable,
        map,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('insert SQList Success');
    } catch (e) {
      print('e insert SQLite ==> ${e.toString()}');
    }
  }

  Future<List<SQLiteModel>> readSQLite() async {
    try {
      print('readSQLite Work');
      Database database = await connectedDatabase();
      List<SQLiteModel> sqliteModels = List();
      List<Map<String, dynamic>> maps = await database.query(nametable);
      for (var item in maps) {
        SQLiteModel model = SQLiteModel.fromMap(item);
        sqliteModels.add(model);
      }
      return sqliteModels;
    } catch (e) {
      print('e readSQLit ==>> ${e.toString()}');
      return null;
    }
  }

  Future<Null> deleteAllData() async {
    Database database = await connectedDatabase();
    try {
      await database.delete(nametable);
    } catch (e) {}
  }

  Future<Null> deleteDataById(int id) async {
    Database database = await connectedDatabase();
    try {
      await database.delete(nametable, where: '$idcolumn = $id');
    } catch (e) {}
  }
}
