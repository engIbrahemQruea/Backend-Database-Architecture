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
      'contactID': contactID,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'address': address,
      'dateOfBirth': dateOfBirth,
      'countryId': countryId,
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
}
