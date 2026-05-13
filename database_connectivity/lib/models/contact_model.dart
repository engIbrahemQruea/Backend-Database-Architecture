class ContactModel {
  final int? id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String address;
  final String? dateOfBirth;
  final int countryId;
  final String? imagePath;

  ContactModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.address,
    required this.countryId,
    this.dateOfBirth,
    this.imagePath,
    s,
  });

  factory ContactModel.toMap(ContactModel contact) {
    return ContactModel(
      id: contact.id,
      firstName: contact.firstName,
      lastName: contact.lastName,
      email: contact.email,
      phone: contact.phone,
      address: contact.address,
      dateOfBirth: contact.dateOfBirth,
      countryId: contact.countryId,
      imagePath: contact.imagePath,
    );
  }

  // Mapper لتحويل البيانات القادمة من قاعدة البيانات (Map) إلى كائن (Object)
  // يشبه عملية القراءة من الـ Reader في ADO.NET
  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['ContactID'] as int,
      firstName: map['FirstName'] as String,
      lastName: map['LastName'] as String,
      email: map['Email'] as String,
      phone: map['Phone'] as String,
      address: map['Address'] as String,
      dateOfBirth: map['DateOfBirth'] as String?,
      countryId: map['CountryID'] as int,
      imagePath: map['ImagePath'] as String?,
    );
  }
}
