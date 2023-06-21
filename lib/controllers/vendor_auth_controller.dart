import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AuthController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  _uploadProfileImageToStorage(Uint8List image) async {
    Reference ref =
        _storage.ref().child('profilePics').child(_auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(image);

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

  Future<String> signUpVendors(String email,String password,String confirmPassword) async {
    String res = 'Some error occured';
    try {
      if (email.isNotEmpty &&
          confirmPassword.isNotEmpty &&
          password.isNotEmpty) {
        // Create User
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

          await _firestore.collection('vendors').doc(credential.user!.uid).set({
            'email': email,
            
            'vendorId': credential.user!.uid,
            
            
          });

        res = 'Success';
      } else {
        res = 'Please Fields must not be empty';
      }
    } catch (e) {}
    return res;
  }

  loginVendors(String email, String password) async {
    String res = 'something went wrong';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Fields must not be empty';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
