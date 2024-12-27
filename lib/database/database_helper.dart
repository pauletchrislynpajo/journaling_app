// First, let's set up our database helper (lib/database/database_helper.dart)
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'journal_database_new.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  Future<void> _createDb(Database db, int version) async {
    // Users table
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT UNIQUE,
        password TEXT
      )
    ''');

    // Entries table
    await db.execute('''
      CREATE TABLE entries(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER,
        type TEXT,
        content TEXT,
        title TEXT,
        dateCreated TEXT,
        FOREIGN KEY (userId) REFERENCES users (id)
      )
    ''');
  }

  // User operations
  Future<int> insertUser(Map<String, dynamic> user) async {
    Database db = await database;
    return await db.insert('users', user);
  }

  Future<Map<String, dynamic>?> getUser(
      String username, String password) async {
    Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    return results.isNotEmpty ? results.first : null;
  }

  // Entry operations
  Future<int> insertEntry(Map<String, dynamic> entry) async {
    Database db = await database;
    return await db.insert('entries', entry);
  }

  Future<List<Map<String, dynamic>>> getEntriesByType(
      int userId, String type) async {
    Database db = await database;
    return await db.query(
      'entries',
      where: 'userId = ? AND type = ?',
      whereArgs: [userId, type],
      orderBy: 'dateCreated DESC',
    );
  }

  Future<List<Map<String, dynamic>>> getAllEntries(int userId) async {
    Database db = await database;
    return await db.query(
      'entries',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'dateCreated DESC',
    );
  }

  Future<Map<String, dynamic>?> getEntry(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'entries',
      where: 'id = ?',
      whereArgs: [id],
    );
    return results.isNotEmpty ? results.first : null;
  }
}
