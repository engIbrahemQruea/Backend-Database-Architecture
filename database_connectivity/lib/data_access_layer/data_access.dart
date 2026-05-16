import 'package:database_connectivity/data_access/contact_db.dart';
import 'package:sqflite/sqflite.dart';

class DataAccessModel {
  /// 1- Connection String
  static const _dbName = "ContactsDB.db";

  static Database? _database;

  static Future<Database> get getDatabase async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<String> get fullPath async {
    String path = await getDatabasesPath() + _dbName;
    return path;
  }

  static Future<Database> _initDatabase() async {
    String path = await fullPath;
    return await openDatabase(
      path,
      version: 1,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: create,
      // singleInstance: true,
    );
  }

  static Future<void> create(Database db, int version) async =>
      ContactDB().createTable(db);

  static Future<void> deleteMyDatabase() async {
    final dbPath = await getDatabasesPath() + _dbName;

    await deleteDatabase(dbPath);

    print('Database Deleted');
  }

  static Future<Map<String, dynamic>?> getInfoByID({required int id}) async {
    try {
      final db = await getDatabase;
      List<Map<String, dynamic>> result = await db.query(
        'Contacts',
        where: 'ContactID = ?',
        whereArgs: [id],
        limit: 1,
      );
      if (result.isNotEmpty) {
        return result.first;
      }
    } catch (e) {
      print('Error fetching contact by ID: $e');
    }
    return null;
  }

  static Future<int> addNewContact(Map<String, dynamic> contactData) async {
    try {
      final db = await getDatabase;
      return await db.insert('Contacts', contactData);
    } catch (e) {
      print('Error adding new contact: $e');
      return -1; // Return -1 to indicate failure
    }
  }

  static Future<int> updateContact(
    int id,
    Map<String, dynamic> contactData,
  ) async {
    try {
      final db = await getDatabase;

      return await db.update(
        'Contacts',
        contactData,
        where: 'ContactID = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error updating contact: $e');
      return 0;
    }
  }

  static Future<int> deleteContact(int id) async {
    try {
      final db = await getDatabase;
      return await db.delete(
        'Contacts',
        where: 'ContactID = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error deleting contact: $e');
      return 0;
    }
  }

  static Future<List<Map<String, dynamic>>> getAllContacts() async {
    try {
      final db = await getDatabase;
      return await db.query('Contacts');
    } catch (e) {
      print('Error fetching all contacts: $e');
      return [];
    }
  }
}
