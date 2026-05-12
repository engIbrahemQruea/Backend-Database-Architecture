import 'package:database_connectivity/data_access/database_service.dart';
import 'package:sqflite/sqflite.dart';

class ContactDB {
  final String tableName = "Contacts";

  Future<void> createTable(Database db) async {
    // =========================
    // Countries Table
    // =========================

    await db.execute('''
          CREATE TABLE Countries (
            CountryID INTEGER PRIMARY KEY AUTOINCREMENT,

            CountryName TEXT,

            Code TEXT,

            PhoneCode TEXT
          )
        ''');

    // =========================
    // Contacts Table
    // =========================

    await db.execute('''
          CREATE TABLE Contacts (
            ContactID INTEGER PRIMARY KEY AUTOINCREMENT,

            FirstName TEXT NOT NULL,

            LastName TEXT NOT NULL,

            Email TEXT NOT NULL,

            Phone TEXT NOT NULL,

            Address TEXT NOT NULL,

            DateOfBirth TEXT NOT NULL,

            CountryID INTEGER NOT NULL,

            ImagePath TEXT,

            FOREIGN KEY (CountryID)
              REFERENCES Countries (CountryID)
              ON DELETE CASCADE
              ON UPDATE CASCADE
          )
        ''');

    /////////////////////

    final countries = [
      {
        'CountryID': 1,
        'CountryName': 'United States',
        'Code': null,
        'PhoneCode': null,
      },
      {
        'CountryID': 2,
        'CountryName': 'United Kingdom',
        'Code': null,
        'PhoneCode': null,
      },
      {
        'CountryID': 3,
        'CountryName': 'Canada',
        'Code': null,
        'PhoneCode': null,
      },
      {
        'CountryID': 4,
        'CountryName': 'Australia',
        'Code': null,
        'PhoneCode': null,
      },
      {
        'CountryID': 5,
        'CountryName': 'Germany',
        'Code': null,
        'PhoneCode': null,
      },
    ];
    final batchCountry = db.batch();
    for (final country in countries) {
      batchCountry.insert(
        'Countries',
        country,
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
    await batchCountry.commit(noResult: true);

    ///////////////////////
    final contacts = [
      {
        'ContactID': 1,
        'FirstName': 'John',
        'LastName': 'Doe',
        'Email': 'johndoe@example.com',
        'Phone': '123456789',
        'Address': '123 Main St',
        'DateOfBirth': '1990-01-01T00:00:00.000',
        'CountryID': 1,
        'ImagePath': null,
      },
      {
        'ContactID': 2,
        'FirstName': 'Jane',
        'LastName': 'Smith',
        'Email': 'janesmith@example.com',
        'Phone': '987654321',
        'Address': '456 Elm St',
        'DateOfBirth': '1992-05-10T00:00:00.000',
        'CountryID': 2,
        'ImagePath': null,
      },
      {
        'ContactID': 3,
        'FirstName': 'Michael',
        'LastName': 'Johnson',
        'Email': 'michaeljohnson@example.com',
        'Phone': '555555555',
        'Address': '789 Oak St',
        'DateOfBirth': '1988-03-15T00:00:00.000',
        'CountryID': 3,
        'ImagePath': null,
      },
      {
        'ContactID': 4,
        'FirstName': 'Emily',
        'LastName': 'Williams',
        'Email': 'emilywilliams@example.com',
        'Phone': '111222333',
        'Address': '321 Pine St',
        'DateOfBirth': '1995-07-20T00:00:00.000',
        'CountryID': 4,
        'ImagePath': null,
      },
      {
        'ContactID': 5,
        'FirstName': 'David',
        'LastName': 'Brown',
        'Email': 'davidbrown@example.com',
        'Phone': '999888777',
        'Address': '654 Cedar St',
        'DateOfBirth': '1991-11-25T00:00:00.000',
        'CountryID': 5,
        'ImagePath': null,
      },
      {
        'ContactID': 6,
        'FirstName': 'Jane',
        'LastName': 'Brown',
        'Email': 'J@j.com',
        'Phone': '83883838',
        'Address': '123Add',
        'DateOfBirth': '1993-09-12T00:00:00.000',
        'CountryID': 1,
        'ImagePath': null,
      },
      {
        'ContactID': 7,
        'FirstName': 'Jane',
        'LastName': 'Doe',
        'Email': 'JJ@JJ.com',
        'Phone': '1123413',
        'Address': '1234',
        'DateOfBirth': '1989-02-28T00:00:00.000',
        'CountryID': 1,
        'ImagePath': null,
      },
    ];

    final batch = db.batch();

    for (final contact in contacts) {
      batch.insert(
        'Contacts',
        contact,
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }

    await batch.commit(noResult: true);
  }

  Future<int> create({required String title}) async {
    final db = await ContactDatabaseService().getDatabase;
    return await db.rawInsert(
      '''INSERT INTO $tableName (FirstName, LastName, Email, Phone, Address, CountryID) 
      VALUES (?, ?, ?, ?, ?, ?)''',
      [title, title, title, title, title, 1],
    );
  }
}
