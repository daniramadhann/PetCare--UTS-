// ignore_for_file: non_constant_identifier_names        
import 'package:utscrud/owner.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
        
class AppDatabase {
    static final AppDatabase _instance = AppDatabase._internal();
    static Database? _database;
        
    //inisialisasi beberapa variabel yang dibutuhkan
    final String tableName = 'theTable';
    final String colId = 'id';
    final String colOwnername = 'ownerName';
    final String colPhonenum = 'phoneNum';
    final String colPetname = 'petName';
    final String colAddress = 'address';
    final String colServices = 'services';
        
    AppDatabase._internal();
    factory AppDatabase() => _instance;
        
    //checking the database
    Future<Database?> get _db  async {
        if (_database != null) {
            return _database;
        }
        _database = await _initDb();
        return _database;
    }
        
    Future<Database?> _initDb() async {
        String databasePath = await getDatabasesPath();
        String path = join(databasePath, 'owner.db');
        
        return await openDatabase(path, version: 1, onCreate: _onCreate);
    }
        
    //mmaking the table and field
    Future<void> _onCreate(Database db, int version) async {
        var sql = "CREATE TABLE $tableName($colId INTEGER PRIMARY KEY, "
            "$colOwnername TEXT,"
            "$colPhonenum TEXT,"
            "$colPetname TEXT,"
            "$colAddress TEXT,"
            "$colServices TEXT)";
             await db.execute(sql);
    }
        
    //adding data to database
    Future<int?> insertOwner(Ownerdata owner) async {
        var dbClient = await _db;
        return await dbClient!.insert(tableName, owner.toMap());
    }
        
    //read the database/ query
    Future<List?> getOwner() async {
        var dbClient = await _db;
        var result = await dbClient!.query(tableName, columns: [
            colId,
            colOwnername,
            colAddress,
            colPhonenum,
            colPetname,
            colServices
        ]);
        
        return result.toList();
    }
        
    //updating the database
    Future<int?> updateOwner(Ownerdata owner) async {
        var dbClient = await _db;
        return await dbClient!.update(tableName, owner.toMap(), where: '$colId = ?', whereArgs: [owner.id]);
    }
        
    //delete data from database
    Future<int?> delOwner(int id) async {
        var dbClient = await _db;
        return await dbClient!.delete(tableName, where: '$colId = ?', whereArgs: [id]);
    }
}