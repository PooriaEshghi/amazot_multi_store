import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential?> signInWithGoogle(String author) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      if (author == 'user') {
        await _firestore.collection('buyers').doc(googleAuth.idToken).set({
          'accessToken': googleAuth.accessToken,
          'idToken': googleAuth.idToken,
          'email': googleUser.email,
          'fullName': googleUser.displayName,
          'phoneNumber': '0000000000',
          'buyerId': googleUser.id,
          'address': ''
        });
      } else {
        await _firestore.collection('vendors').doc(googleAuth.idToken).set({
          'accessToken': googleAuth.accessToken,
          'idToken': googleAuth.idToken,
          'email': googleUser.email,
          'fullName': googleUser.displayName,
          'phoneNumber': '0000000000',
          'buyerId': googleUser.id,
          'address': ''
        });
      }
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
