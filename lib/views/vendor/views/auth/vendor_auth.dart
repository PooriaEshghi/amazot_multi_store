import 'package:amazot_multi_store/controllers/vendor_auth_controller.dart';
import 'package:amazot_multi_store/utils/show_snackBar.dart';
import 'package:amazot_multi_store/views/buyers/main_screen.dart';
import 'package:amazot_multi_store/views/vendor/views/auth/vendor_register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../../../../controllers/google_auth_controller.dart';

class VendorAuthScreen extends StatefulWidget {
  @override
  State<VendorAuthScreen> createState() => _VendorAuthScreenState();
}

class _VendorAuthScreenState extends State<VendorAuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  final AuthService _authService = AuthService();

  late String email;

  late String password;

  bool _isLoading = false;

  _loginUsers() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      await _authController.loginVendors(email, password);

      return Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return MainScreen();
      }));
    } else {
      setState(() {
        _isLoading = false;
      });
      return showSnack(context, 'The fields must not e empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              'Login Vendor\'s Account',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the email';
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  labelText: 'Enter Email Address',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the password';
                  } else {
                    return null;
                  }
                },
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: InputDecoration(
                  labelText: 'Enter Password',
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                _loginUsers();
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.yellow.shade900,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: _isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          'Login',
                          style:
                              TextStyle(letterSpacing: 4, color: Colors.white),
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SignInButton(
              Buttons.Google,
              onPressed: () async {
                UserCredential? userCredential =
                    await _authService.signInWithGoogle('vendor');
                if (userCredential != null) {
                  // User logged in successfully, handle navigation or other logic
                  return Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return VendorRegisterScreen();
                  }));
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Need An Account?'),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return VendorRegisterScreen();
                      }),
                    );
                  },
                  child: Text('Register'),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
