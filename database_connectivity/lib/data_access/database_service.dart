import 'package:database_connectivity/data_access/contact_db.dart';
import 'package:database_connectivity/models/contact_model.dart';
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

  Future<String?> getFirstName({required int contactId}) async {
    try {
      final db = await getDatabase;

      final result = await db.query(
        'Contacts',
        columns: ['FirstName'],
        where: 'ContactID = ?',
        whereArgs: [contactId],
        limit: 1,
      );

      if (result.isEmpty) return null;

      return result.first['FirstName'] as String?;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<ContactModel?> findContactById({required int contactId}) async {
    try {
      final db = await getDatabase;

      final results = await db.query(
        'Contacts',
        where: 'ContactID = ?',
        whereArgs: [contactId],
        limit: 1,
      );

      if (results.isEmpty) return null;

      return ContactModel.fromMap(results.first);
    } catch (e) {
      print('Database Error: $e');
      return null;
    }
  }

  Future<bool> addNewContact(ContactModel contact) async {
    try {
      final db = await getDatabase;
      final results = ContactModel.toMap(contact);

      int id = await db.insert('Contacts', {
        'ContactID': results.id,
        'FirstName': results.firstName,
        'LastName': results.lastName,
        'Email': results.email,
        'Phone': results.phone,
        'Address': results.address,
        'DateOfBirth': results.dateOfBirth,
        'CountryID': results.countryId,
        'ImagePath': results.imagePath,
      });

      if (id > 0) {
        print("✅ Record inserted successfully.");
      } else {
        print("⚠️ Record insertion failed.");
        return false;
      }
    } catch (e) {
      print("❌ Error: ${e.toString()}");
      return false;
    }
    return true;
  }

  Future<int?> addNewContactAndGetID(ContactModel contact) async {
    try {
      final db = await getDatabase;
      final results = ContactModel.toMap(contact);

      int id = await db.insert('Contacts', {
        'FirstName': results.firstName,
        'LastName': results.lastName,
        'Email': results.email,
        'Phone': results.phone,
        'Address': results.address,
        'DateOfBirth': results.dateOfBirth,
        'CountryID': results.countryId,
        'ImagePath': results.imagePath,
      });

      if (id > 0) {
        print("✅ Record inserted successfully with ID: $id");
        return id;
      } else {
        print("⚠️ Record insertion failed.");
        return null;
      }
    } catch (e) {
      print("❌ Error: ${e.toString()}");
      return null;
    }
  }

  Future<bool> updateContact(ContactModel updateInfo, int id) async {
    try {
      final db = await getDatabase;
      final results = ContactModel.toMap(updateInfo);

      int count = await db.update(
        'Contacts',
        {
          'FirstName': results.firstName,
          'LastName': results.lastName,
          'Email': results.email,
          'Phone': results.phone,
          'Address': results.address,
          'DateOfBirth': results.dateOfBirth,
          'CountryID': results.countryId,
          'ImagePath': results.imagePath,
        },
        where: 'ContactID = ?',
        whereArgs: [id],
      );

      if (count > 0) {
        print("✅ Record updated successfully.");
        return true;
      } else {
        print("⚠️ Record update failed. No matching record found.");
        return false;
      }
    } catch (e) {
      print("❌ Error: ${e.toString()}");
      return false;
    }
  }
}
