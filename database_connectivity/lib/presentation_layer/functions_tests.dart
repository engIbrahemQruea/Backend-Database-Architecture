import 'package:database_connectivity/business_logic_layer/business_logic_model.dart';

class FunctionsTests {
  static void testFindByID({required int contactID}) async {
    final contact = await BusinessLogicModel.find(contactID: contactID);
    if (contact != null) {
      print('Contact Found: ${contact.firstName} ${contact.lastName}\n');
      for (var row in contact.toMap().entries) {
        print('${row.key}: ${row.value}');
      }
    } else {
      print('Contact not found');
    }
  }

  static void testAddNewContact() async {
    BusinessLogicModel newContact = BusinessLogicModel()
      ..firstName = 'Foad'
      ..lastName = 'Jameel'
      ..email = 'Foad.Jameel@example.com'
      ..phone = '1234567890'
      ..address = '123 Main St'
      ..dateOfBirth = ' 1990-01-01'
      ..countryId = 2
      ..imagePath = '';

    if (await newContact.save()) {
      print("✅ Contact Added Successfully with ID: ${newContact.contactID}");
      print("Current Mode: ${newContact.mode}"); // سيتحول إلى Update
    } else {
      print("❌ Failed to Add Contact.");
    }
  }

  static void testUpdateContact({required int contactID}) async {
    final contact = await BusinessLogicModel.find(contactID: contactID);
    if (contact != null) {
      print('Contact Found: ${contact.firstName} ${contact.lastName}\n');

      contact.firstName = 'Moeen';
      contact.phone = '0987654321';
      contact.address = '456 Another St';

      if (await contact.save()) {
        print("✅ Contact Updated Successfully.");
        print("Current Mode: ${contact.mode}"); // سيظل Update
      } else {
        print("❌ Failed to Update Contact.");
      }
    } else {
      print('Contact not found');
    }
  }
}
