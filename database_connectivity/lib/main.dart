import 'dart:io';

import 'package:database_connectivity/data_access_layer/data_access.dart';
import 'package:database_connectivity/presentation_layer/presentation_layer.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  print('SQLite Ready');

  //await ContactDatabaseService().deleteMyDatabase();

  // await ContactDatabaseService().getDatabase;
  await DataAccessModel.getDatabase;
  print('Database Initialized');
  //runApp(const App());
  runApp(const PresentationLayer());
}

// Future<bool> deleteContactsWithInStatment(String countrysID) async {
//   try {
//     final db = await getDatabase;
//     final batch = db.batch();
//     batch.delete('Contacts', where: 'CountryID IN ($countrysID)');
//     await batch.commit();
//     print("✅ Records deleted successfully for CountryIDs: $countrysID");
//     return true;
//   } catch (e) {
//     print("❌ Error: ${e.toString()}");
//     return false;
//   }
// }

// Future<bool> deleteContactsWithInStatement(List<int> countryIds) async {
//   try {
//     final db = await getDatabase;

//     String placeholders = List.filled(countryIds.length, '?').join(', ');

//     int rowsAffected = await db.delete(
//       'Contacts',
//       where: 'CountryID IN ($placeholders)',
//       whereArgs: countryIds,
//     );

//     if (rowsAffected > 0) {
//       print("✅ Records deleted successfully. Rows affected: $rowsAffected");
//       return true;
//     } else {
//       print("⚠️ No records found to delete.");
//       return false;
//     }
//   } catch (e) {
//     print("❌ Error: ${e.toString()}");
//     return false;
//   }
// }
