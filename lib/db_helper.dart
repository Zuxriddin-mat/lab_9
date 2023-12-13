import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as pth;
import 'dart:async';

class DBHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = pth.join(databasesPath, 'user.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE user (id INTEGER PRIMARY KEY, username TEXT, password TEXT, phone TEXT, email TEXT, address TEXT)');
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;
    return await dbClient.insert('user', user.toMap());
  }

  // Updated read method to return a `User` object
  Future<User?> getUserData() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = pth.join(databasesPath, 'user.db');

    // Open the database
    Database database = await openDatabase(path, version: 1);

    // Get the records for the table named user
    List<Map<String, dynamic>> data =
        await database.rawQuery('SELECT * FROM user');

    if (data.isNotEmpty) {
      return User.fromMap(data[0]); // Return the first user object
    } else {
      return null; // Return null if no user found
    }
  }
}

class User {
  int? id;
  String username;
  String password;
  String phone;
  String email;
  String address;

  User(this.id, this.username, this.password, this.phone, this.email,
      this.address);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'username': username,
      'password': password,
      'phone': phone,
      'email': email,
      'address': address
    };
    return map;
  }

  // New factory constructor to create User from Map
  factory User.fromMap(Map<String, dynamic> map) => User(
        map['id'],
        map['username'],
        map['password'],
        map['phone'],
        map['email'],
        map['address'],
      );
}
