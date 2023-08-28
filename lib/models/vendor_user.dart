import 'dart:core';

class VendorUserModel {
  final bool? approved;
  final String? businessName;
  final String? email;
  final String? phoneNumber;
  final String? countryValue;
  final String? cityValue;
  final String? stateValue;
  final String? taxRegistered;
  final String? taxNumber;
  final String? storeImage;
  final String? vendorId;

  VendorUserModel(
      {required this.approved,
      required this.vendorId,
      required this.businessName,
      required this.email,
      required this.cityValue,
      required this.countryValue,
      required this.phoneNumber,
      required this.stateValue,
      required this.storeImage,
      required this.taxNumber,
      required this.taxRegistered});

  VendorUserModel.formJson(Map<String, Object?> json)
      : this(
          approved: json['approved']! as bool,
          businessName: json['businessName']! as String,
          vendorId: json['vendorId']! as String,
          email: json['email']! as String,
          phoneNumber: json['phoneNumber']! as String,
          countryValue: json['countryValue']! as String,
          cityValue: json['cityValue']! as String,
          stateValue: json['stateValue']! as String,
          taxRegistered: json['taxRegistered']! as String,
          taxNumber: json['taxNumber']! as String,
          storeImage: json['storeImage']! as String,
        );
  Map<String, Object?> toJson() {
    return {
      'approved': approved,
      'businessName': businessName,
      'email': email,
      'phoneNumber': phoneNumber,
      'countryValue': countryValue,
      'cityValue': cityValue,
      'stateValue': stateValue,
      'taxRegistered': taxRegistered,
      'taxNumber': taxNumber,
      'storeImage': storeImage
    };
  }
}
