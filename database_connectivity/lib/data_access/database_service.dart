import 'package:database_connectivity/data_access/contact_db.dart';
import 'package:sqflite/sqflite.dart';

class ContactDatabaseService {
  /// 1- Connection String
  static const _dbName = "ContactsDB.db";

  static Database? _database;

  Future<Database> get getDatabase async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<String> get fullPath async {
    String path = await getDatabasesPath() + _dbName;
    return path;
  }

  Future<Database> _initDatabase() async {
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

  Future<void> create(Database db, int version) async {
    return ContactDB().createTable(db);
  }

  Future<void> deleteMyDatabase() async {
    final dbPath = await getDatabasesPath() + _dbName;

    await deleteDatabase(dbPath);

    print('Database Deleted');
  }

  Future<void> printAllContacts() async {
    try {
      /// 2- connection.Open
      final db = await getDatabase;

      /// 3- Execute Query And Fetch Data == (SqlCommand & ExecuteReader)
      final List<Map<String, dynamic>> results = await db.rawQuery(
        "SELECT * FROM Contacts order by ContactID ",
      );
      if (results.isEmpty) {
        print("No contacts found.");
        return;
      }
      for (var row in results) {
        print('Contact ID: ${row['ContactID']}');
        print('First Name: ${row['FirstName']}');
        print('Last Name: ${row['LastName']}');
        print('Email: ${row['Email']}');
        print('Phone: ${row['Phone']}');
        print('Address: ${row['Address']}');
        print('Country ID: ${row['CountryID']}');
        print('-----------------------------');
      }
    } catch (e) {
      print('Error fetching contacts: ${e.toString()}');
    }
  }

  Future<void> printAllContactsWithFirstName(String firstName) async {
    try {
      final db = await getDatabase;

      final List<Map<String, dynamic>> results = await db.query(
        'Contacts',
        where: 'LOWER(FirstName) = LOWER(?)',
        whereArgs: [firstName],
      );
      if (results.isEmpty) {
        print("No contacts found.");
        return;
      }
      for (var row in results) {
        print('Contact ID: ${row['ContactID']}');
        print('First Name: ${row['FirstName']}');
        print('Last Name: ${row['LastName']}');
        print('Email: ${row['Email']}');
        print('Phone: ${row['Phone']}');
        print('Address: ${row['Address']}');
        print('Country ID: ${row['CountryID']}');
        print('-----------------------------');
      }
    } catch (e) {
      print('Error fetching contacts: ${e.toString()}');
    }
  }

  Future<void> printAllContactsWithFirstNameAndCountry(
    String firstName,
    int countryId,
  ) async {
    try {
      final db = await getDatabase;

      final List<Map<String, dynamic>> results = await db.query(
        'Contacts',
        where: 'LOWER(FirstName) = LOWER(?) AND CountryID = ?',
        whereArgs: [firstName, countryId],
      );
      if (results.isEmpty) {
        print("No contacts found.");
        return;
      }
      for (var row in results) {
        print('Contact ID: ${row['ContactID']}');
        print('First Name: ${row['FirstName']}');
        print('Last Name: ${row['LastName']}');
        print('Email: ${row['Email']}');
        print('Phone: ${row['Phone']}');
        print('Address: ${row['Address']}');
        print('Country ID: ${row['CountryID']}');
        print('-----------------------------');
      }
    } catch (e) {
      print('Error fetching contacts: ${e.toString()}');
    }
  }

  Future<void> searchContactsByStartingLetter({
    required String searchLetter,
  }) async {
    try {
      final db = await getDatabase;

      // 1. الاستعلام يستخدم ? كـ Placeholder
      const String query = 'SELECT * FROM Contacts WHERE FirstName LIKE ?';

      final List<Map<String, dynamic>> results = await db.rawQuery(query, [
        '$searchLetter%',
      ]);

      if (results.isEmpty) {
        print("لا توجد أسماء تبدأ بحرف: $searchLetter");
        return;
      }

      for (var row in results) {
        print('Name: ${row['FirstName']} ${row['LastName']}');
      }
    } catch (e) {
      print('خطأ: ${e.toString()}');
    }
  }

  Future<void> searchContactsStartWith({required String searchLetter}) async {
    try {
      final db = await getDatabase;

      const String query = 'SELECT * FROM Contacts WHERE FirstName LIKE ?';

      final List<Map<String, dynamic>> results = await db.rawQuery(query, [
        '$searchLetter%',
      ]);
      if (results.isEmpty) {
        print("لا توجد أسماء تبدأ بحرف: $searchLetter");
        return;
      }
      for (var row in results) {
        print('Name: ${row['FirstName']} ${row['LastName']}');
      }
    } catch (e) {
      print('خطأ: ${e.toString()}');
    }
  }

  Future<void> searchContactsEndWith({required String searchLetter}) async {
    try {
      final db = await getDatabase;

      const String query = 'SELECT * FROM Contacts WHERE FirstName LIKE ?';

      final List<Map<String, dynamic>> results = await db.rawQuery(query, [
        '%$searchLetter',
      ]);
      if (results.isEmpty) {
        print("لا توجد أسماء تنتهي بحرف: $searchLetter");
        return;
      }
      for (var row in results) {
        print('Name: ${row['FirstName']} ${row['LastName']}');
      }
    } catch (e) {
      print('خطأ: ${e.toString()}');
    }
  }
}
