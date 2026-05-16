import 'package:database_connectivity/business_logic_layer/business_logic_model.dart';
import 'package:database_connectivity/business_logic_layer/country_model.dart';

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

  static void testDeleteContact({required int contactID}) async {
    if (await BusinessLogicModel.isContactExists(contactID)) {
      if (await BusinessLogicModel.deleteContact(contactID)) {
        print("✅ Contact Deleted Successfully.");
      } else {
        print("❌ Failed to Delete Contact.");
      }
    } else {
      print("❌ Contact With ID $contactID does not exist.");
    }
  }

  static void testGetAllContacts() async {
    List<BusinessLogicModel> contacts =
        await BusinessLogicModel.getAllContacts();

    if (contacts.isEmpty) {
      print('No contacts found.');
      return;
    }

    print('Total Contacts: ${contacts.length}\n');
    for (var contact in contacts) {
      print(
        '${contact.contactID} ${contact.firstName} ${contact.lastName} - ${contact.email}',
      );
    }
  }

  static void testIsContactExists({required int contactID}) async {
    if (await BusinessLogicModel.isContactExists(contactID)) {
      print('Contact with ID $contactID exists.');
    } else {
      print('Contact with ID $contactID does not exist.');
    }
  }

  /// This function is used to practice on Countries Table

  static void testFindCountryByID({required int countryID}) async {
    final country = await CountryModel.find(countryID: countryID);
    if (country != null) {
      print('Country Found: ${country.countryName}\n');
      for (var row in country.toMap().entries) {
        print('${row.key}: ${row.value}');
      }
    } else {
      print('Country not found');
    }
  }

  static void testAddNewCountry() async {
    CountryModel newCountry = CountryModel()
      ..countryName = 'Yemen'
      ..code = 'Yen'
      ..phoneCode = '+967';

    if (await newCountry.save()) {
      print("✅ Country Added Successfully with ID: ${newCountry.countryID}");
      print("Current Mode: ${newCountry.mode}"); // سيتحول إلى Update
    } else {
      print("❌ Failed to Add Country.");
    }
  }

  static void testUpdateCountry({required int countryID}) async {
    final country = await CountryModel.find(countryID: countryID);
    if (country != null) {
      print('Country Found: ${country.countryName}\n');

      country.countryName = 'Updated Country Name';
      country.code = 'Upd';
      country.phoneCode = '+999';

      if (await country.save()) {
        print("✅ Country Updated Successfully.");
        print("Current Mode: ${country.mode}"); // سيظل Update
      } else {
        print("❌ Failed to Update Country.");
      }
    } else {
      print('Country not found');
    }
  }

  static void testDeleteCountry({required int countryID}) async {
    // Implement delete functionality for CountryModel if needed
    if (await CountryModel.isCountryExists(countryID)) {
      if (await CountryModel.deleteCountry(countryID)) {
        print("✅ Country Deleted Successfully.");
      } else {
        print("❌ Failed to Delete Country.");
      }
    } else {
      print("❌ Country With ID $countryID does not exist.");
    }
  }

  static void testGetAllCountries() async {
    List<CountryModel> countries = await CountryModel.getAllCountries();

    if (countries.isEmpty) {
      print('No countries found.');
      return;
    }

    print('Total Countries: ${countries.length}\n');
    for (var country in countries) {
      print(
        '${country.countryID} ${country.countryName} - ${country.code} (${country.phoneCode})',
      );
    }
  }

  static void testIsCountryExists({required int countryID}) async {
    if (await CountryModel.isCountryExists(countryID)) {
      print('Country with ID $countryID exists.');
    } else {
      print('Country with ID $countryID does not exist.');
    }
  }
}
