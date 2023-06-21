import 'dart:typed_data';

import 'package:amazot_multi_store/controllers/vendor_auth_controller.dart';
import 'package:amazot_multi_store/utils/show_snackBar.dart';
import 'package:amazot_multi_store/views/buyers/auth/login_screen.dart';
import 'package:amazot_multi_store/views/vendor/views/auth/vendor_auth.dart';
import 'package:amazot_multi_store/views/vendor/views/auth/vendor_register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VendorSignUp extends StatefulWidget {
  @override
  State<VendorSignUp> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<VendorSignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthController _authController = AuthController();

  late String email;



  late String password;
  late String confirmPassword;


  bool _isLoading = false;

  _signUpVendor() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      await _authController
          .signUpVendors(email, password, confirmPassword)
          .whenComplete(() {
        setState(() {
          _formKey.currentState!.reset();
          _isLoading = false;
          
        });
      });
      return showSnack(context, 'Account has been created for you');
    } else {
      setState(() {
        _isLoading = false;
      });
      return showSnack(context, 'Fields must not be empty');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create Customer"s Account',
                  style: TextStyle(fontSize: 20),
                ),
               
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email must not be empty';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(labelText: 'Enter Email'),
                  ),
                ),
               
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password must not be empty';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: InputDecoration(labelText: 'Enter Password'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Phone Number must not be empty';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      confirmPassword = value;
                    },
                    decoration:
                        InputDecoration(labelText: 'Enter Phone Number'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _signUpVendor();
                     Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return VendorRegisterScreen();
                            }),
                          );
                  },
                  child: Container(
                    
                    width: MediaQuery.of(context).size.width - 40,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.yellow.shade900,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Register',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 4),
                            ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already Have An Account?'),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return LoginScreen();
                            }),
                          );
                        },
                        child: Text('Login'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
