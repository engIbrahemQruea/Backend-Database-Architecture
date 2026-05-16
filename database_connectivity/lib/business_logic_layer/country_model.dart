import 'package:database_connectivity/data_access_layer/data_access.dart';

enum EnModeCountry { addNew, update }

class CountryModel {
  int? countryID;
  String countryName;
  String? code;
  String? phoneCode;
  EnModeCountry mode;

  CountryModel()
    : countryName = '',
      code = '',
      phoneCode = '',
      mode = EnModeCountry.addNew;

  CountryModel._internal(
    this.countryID,
    this.countryName,
    this.code,
    this.phoneCode,
  ) : mode = EnModeCountry.update;

  factory CountryModel.fromMap(Map<String, dynamic?> map) {
    return CountryModel._internal(
      map['CountryID'] as int?,
      map['CountryName'] as String,
      map['Code'] as String?,
      map['PhoneCode'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'CountryID': countryID,
      'CountryName': countryName,
      'Code': code,
      'PhoneCode': phoneCode,
    };
  }

  Map<String, dynamic> toUpdateMap() {
    return {
      'CountryID': countryID,
      'CountryName': countryName,
      'Code': code,
      'PhoneCode': phoneCode,
    };
  }

  static Future<CountryModel?> find({required int countryID}) async {
    final data = await DataAccessModel.getCountryByID(id: countryID);
    if (data != null) {
      return CountryModel.fromMap(data);
    }
    return null;
  }

  Future<bool> _addNewCountry() async {
    countryID = await DataAccessModel.addNewCountry(toMap());
    return countryID! >= 0;
  }

  Future<bool> _updateCountry() async {
    int rowsAffected = await DataAccessModel.updateCountry(countryID!, toMap());

    return rowsAffected > 0;
  }

  Future<bool> save() async {
    switch (mode) {
      case EnModeCountry.addNew:
        if (await _addNewCountry()) {
          mode = EnModeCountry.update; // Switch to update mode after adding
          return true;
        } else {
          return false;
        }
      case EnModeCountry.update:
        return await _updateCountry();
    }
  }

  static Future<bool> deleteCountry(int countryID) async {
    int rowsAffected = await DataAccessModel.deleteCountry(countryID);
    return rowsAffected > 0;
  }

static  Future<List<CountryModel>> getAllCountries() async {
    final dataList = await DataAccessModel.getAllCountries();
    return dataList.map((data) => CountryModel.fromMap(data)).toList();
  }

  static Future<bool> isCountryExists(int countryID) async {
    return await DataAccessModel.isCountryExists(countryID);
  }
}
