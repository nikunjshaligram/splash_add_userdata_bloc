import 'package:path/path.dart';
import 'package:splash_add_userdata_bloc/model/user.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;
  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('users.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE users ( 
  _id INTEGER PRIMARY KEY AUTOINCREMENT, 
  firstname TEXT NOT NULL,
  lastname TEXT NOT NULL,
  mobilenumber TEXT NOT NULL,
  gender TEXT NOT NULL,
  role TEXT NOT NULL
  )
''');
  }

  Future<User> create(User user) async {
    final db = await instance.database;
    final id = await db.insert(userTable, user.toJson());
    return user.copy(id: id);
  }

  Future<User> readUser({required int id}) async {
    final db = await instance.database;

    final maps = await db.query(
      userTable,
      columns: UserFields.values,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return User.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<User>> readAllUsers() async {
    final db = await instance.database;
    const orderBy = '${UserFields.id} ASC';
    final result = await db.query(userTable, orderBy: orderBy);

    return result.map((json) => User.fromJson(json)).toList();
  }

  Future<int> update({required User user}) async {
    final db = await instance.database;

    return db.update(
      userTable,
      user.toJson(),
      where: '${UserFields.id} = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> delete({required int id}) async {
    final db = await instance.database;

    return await db.delete(
      userTable,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
