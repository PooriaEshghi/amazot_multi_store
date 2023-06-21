import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class VendorController {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  _uploadVendorImageToStorage(Uint8List? image) async {
    Reference ref =
        _storage.ref().child('vendorsPic').child(_auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(image!);

    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  pickProfileImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('No Image Selected');
    }
  }

  Future<String> registerVendor(
      String businessName,
      String email,
      String phoneNumber,
      String countryValue,
      String cityValue,
      String stateValue,
      String taxRegistered,
      String taxNumber,
      Uint8List image) async {
    String res = 'some error occured';
    try {
      String storeImage = await _uploadVendorImageToStorage(image);
      await _firestore.collection('vendors').doc(_auth.currentUser!.uid).set({
        'businessName': businessName,
        'email': email,
        'phoneNumber': phoneNumber,
        'countryValue': countryValue,
        'cityValue': cityValue,
        'stateValue': stateValue,
        'taxRegistered': taxRegistered,
        'taxNumber': taxNumber,
        'storeImage': storeImage,
        'approved': false,
        'vendorId': _auth.currentUser!.uid
      });
      res = 'success';
      print(res);
    } catch (error) {
      res = error.toString();
      print(res);
    }
    return res;
  }
}
