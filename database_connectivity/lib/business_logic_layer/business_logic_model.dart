import 'package:database_connectivity/data_access_layer/data_access.dart';

enum EnMode { addNew, update }

class BusinessLogicModel {
  EnMode mode;
  int? contactID;
  String firstName;
  String lastName;
  String email;
  String phone;
  String address;
  String? dateOfBirth;
  int countryId;
  String? imagePath;

  BusinessLogicModel()
    : contactID = -1,
      firstName = '',
      lastName = '',
      email = '',
      phone = '',
      address = '',
      dateOfBirth = '',
      countryId = -1,
      imagePath = null,
      mode = EnMode.addNew;

  BusinessLogicModel._internal(
    this.contactID,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.address,
    this.dateOfBirth,
    this.countryId,
    this.imagePath,
  ) : mode = EnMode.update;

  factory BusinessLogicModel.fromMap(Map<String, dynamic?> map) {
    return BusinessLogicModel._internal(
      map['ContactID'] as int?,
      map['FirstName'] as String,
      map['LastName'] as String,
      map['Email'] as String,
      map['Phone'] as String,
      map['Address'] as String,
      map['DateOfBirth'] as String,
      map['CountryID'] as int,
      map['imagePath'] as String?,
    );
  }

  // factory BusinessLogicModel.toMap(BusinessLogicModel model) {
  //   return BusinessLogicModel._internal(
  //     firstName: model.firstName,
  //     lastName: model.lastName,
  //     email: model.email,
  //     phone: model.phone,
  //     address: model.address,
  //     dateOfBirth: model.dateOfBirth,
  //     countryId: model.countryId,
  //     imagePath: model.imagePath,
  //   );
  // }
  Map<String, dynamic> toMap() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Email': email,
      'Phone': phone,
      'Address': address,
      'DateOfBirth': dateOfBirth,
      'CountryID': countryId,
      'imagePath': imagePath,
    };
  }

  Map<String, dynamic> toUpdateMap() {
    return {
      'ContactID': contactID,
      'FirstName': firstName,
      'LastName': lastName,
      'Email': email,
      'Phone': phone,
      'Address': address,
      'DateOfBirth': dateOfBirth,
      'CountryID': countryId,
      'imagePath': imagePath,
    };
  }

  static Future<BusinessLogicModel?> find({required int contactID}) async {
    final data = await DataAccessModel.getInfoByID(id: contactID);
    if (data != null) {
      return BusinessLogicModel.fromMap(data);
    }
    return null;
  }

  Future<bool> _addNewContact() async {
    contactID = await DataAccessModel.addNewContact(toMap());
    return contactID! >= 0;
  }

  Future<bool> save() async {
    switch (mode) {
      case EnMode.addNew:
        if (await _addNewContact()) {
          mode = EnMode.update;
          return true;
        } else {
          return false;
        }
      case EnMode.update:
        return await _updateContact();
    }
  }

  Future<bool> _updateContact() async {
    int rowsAffected = await DataAccessModel.updateContact(contactID!, toMap());

    return rowsAffected > 0;
  }

  static Future<bool> deleteContact(int contactID) async {
    int rowsAffected = await DataAccessModel.deleteContact(contactID);
    return rowsAffected > 0;
  }

  static Future<List<BusinessLogicModel>> getAllContacts() async {
    final dataList = await DataAccessModel.getAllContacts();
    return dataList.map((data) => BusinessLogicModel.fromMap(data)).toList();
  }
}
