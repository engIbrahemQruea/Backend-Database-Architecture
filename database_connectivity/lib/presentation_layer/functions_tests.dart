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
}
