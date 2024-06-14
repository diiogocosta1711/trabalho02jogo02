import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBService {
  static final DBService instance = DBService._init();

  static Database? _database;

  DBService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('ipv4_game.db');
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
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT NOT NULL,
  password TEXT NOT NULL
)
''');

    await db.execute('''
CREATE TABLE scores (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  userId INTEGER,
  score INTEGER,
  FOREIGN KEY (userId) REFERENCES users (id)
)
''');
  }

  Future<int> insertUser(String username, String password) async {
    final db = await instance.database;
    final data = {'username': username, 'password': password};
    return await db.insert('users', data);
  }

  Future<int> insertScore(int userId, int score) async {
    final db = await instance.database;
    final data = {'userId': userId, 'score': score};
    return await db.insert('scores', data);
  }

  Future<Map<String, dynamic>?> getUser(
      String username, String password) async {
    final db = await instance.database;
    final result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getTopScores() async {
    final db = await instance.database;
    return await db.query(
      'scores',
      orderBy: 'score DESC',
      limit: 5,
    );
  }
}
