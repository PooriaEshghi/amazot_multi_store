import 'dart:typed_data';

import 'package:amazot_multi_store/controllers/vendor_register_controller.dart';
// import 'package:amazot_multi_store/utils/show_snackBar.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

class VendorRegisterScreen extends StatefulWidget {
  @override
  State<VendorRegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<VendorRegisterScreen> {
  final VendorController _vendorController = VendorController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String businessName;
  late String email;
  late String phoneNumber;
  late String countryValue;
  late String cityValue;
  late String stateValue;
  String? _taxStatus;
  late String taxNumber;
  Uint8List? _image;
  List<String> _taxOptions = ['YES', 'NO'];
  // bool _isLoading = false;

  selectGalleryImage() async {
    Uint8List img =
        await _vendorController.pickProfileImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  selectCameraImage() async {
    Uint8List img =
        await _vendorController.pickProfileImage(ImageSource.camera);
    setState(() {
      _image = img;
    });
  }

  _saveVendorDetail() async {
    EasyLoading.show(status: 'PLEASE WAIT');
    if (_formKey.currentState!.validate()) {
      await _vendorController
          .registerVendor(businessName, email, phoneNumber, countryValue,
              cityValue, stateValue, _taxStatus!, taxNumber, _image!)
          .whenComplete(() {
        EasyLoading.dismiss();
        setState(() {
          _formKey.currentState!.reset();
          _image = null;
        });
      });
      print('done');
    } else {
      print('bad');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 200,
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                return FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.yellow.shade900, Colors.yellow]),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: _image != null
                                ? Image.memory(_image!)
                                : IconButton(
                                    onPressed: () {
                                      selectGalleryImage();
                                    },
                                    icon: Icon(CupertinoIcons.photo)),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (value) {
                        businessName = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Business Name must not be empty';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Business Name',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Email Address must not be empty';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Phone Number must not be empty';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                      ),
                    ),
                    SelectState(
                      onCountryChanged: (value) {
                        setState(() {
                          countryValue = value;
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          stateValue = value;
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          cityValue = value;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tax Registered?  ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          Flexible(
                            child: Container(
                              width: 100,
                              child: DropdownButtonFormField(
                                  hint: Text('Select'),
                                  items: _taxOptions
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                        value: value, child: Text(value));
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _taxStatus = value;
                                    });
                                  }),
                            ),
                          )
                        ],
                      ),
                    ),
                    if (_taxStatus == 'YES')
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          onChanged: (value) {
                            taxNumber = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Tax Number must not be empty';
                            } else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(labelText: 'Tax Number'),
                        ),
                      ),
                    InkWell(
                      onTap: () {
                        _saveVendorDetail();
                      },
                      child: Container(
                        height: 30,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                          color: Colors.yellow.shade900,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: Center(
                            child: Text(
                          'Save',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Center(
  //       child: SingleChildScrollView(
  //         child: Form(
  //           key: _formKey,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text(
  //                 'Register',
  //                 style: TextStyle(fontSize: 20),
  //               ),
  //               Stack(
  //                 children: [
  //                   _image != null
  //                       ? CircleAvatar(
  //                           radius: 64,
  //                           backgroundColor: Colors.yellow.shade900,
  //                           backgroundImage: MemoryImage(_image!),
  //                         )
  //                       : CircleAvatar(
  //                           radius: 64,
  //                           backgroundColor: Colors.yellow.shade900,
  //                           backgroundImage: NetworkImage(
  //                               'https://media.istockphoto.com/id/1463555369/it/foto/testa-umana-con-pezzi-di-cervello-fatti-di-carta-su-sfondo-blu-vista-dallalto-e-spazio-per-il.jpg?s=2048x2048&w=is&k=20&c=DZqPNph6s51TN4bhzMsiGNWvhHUfiMfS1HSPzgU92Ek='),
  //                         ),
  //                   Positioned(
  //                       right: 5,
  //                       top: 5,
  //                       child: IconButton(
  //                         onPressed: () {
  //                           selectGalleryImage();
  //                         },
  //                         icon: Icon(
  //                           CupertinoIcons.photo,
  //                           color: Colors.white,
  //                         ),
  //                       ))
  //                 ],
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(13.0),
  //                 child: TextFormField(
  //                   validator: (value) {
  //                     if (value!.isEmpty) {
  //                       return 'Email must not be empty';
  //                     }
  //                   },
  //                   onChanged: (value) {
  //                     email = value;
  //                   },
  //                   decoration: InputDecoration(labelText: 'Enter Email'),
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(13.0),
  //                 child: TextFormField(
  //                   validator: (value) {
  //                     if (value!.isEmpty) {
  //                       return 'Full Name must not be empty';
  //                     }
  //                   },
  //                   onChanged: (value) {
  //                     fullName = value;
  //                   },
  //                   decoration: InputDecoration(labelText: 'Enter Full Name'),
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(13.0),
  //                 child: TextFormField(
  //                   validator: (value) {
  //                     if (value!.isEmpty) {
  //                       return 'Phone Number must not be empty';
  //                     }
  //                   },
  //                   onChanged: (value) {
  //                     phoneNumber = value;
  //                   },
  //                   decoration:
  //                       InputDecoration(labelText: 'Enter Phone Number'),
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(13.0),
  //                 child: TextFormField(
  //                   obscureText: true,
  //                   validator: (value) {
  //                     if (value!.isEmpty) {
  //                       return 'Password must not be empty';
  //                     }
  //                   },
  //                   onChanged: (value) {
  //                     password = value;
  //                   },
  //                   decoration: InputDecoration(labelText: 'Enter Password'),
  //                 ),
  //               ),
  //               GestureDetector(
  //                 onTap: () {
  //                   _signUpUser();
  //                 },
  //                 child: Container(
  //                   width: MediaQuery.of(context).size.width - 40,
  //                   height: 50,
  //                   decoration: BoxDecoration(
  //                       color: Colors.yellow.shade900,
  //                       borderRadius: BorderRadius.circular(10)),
  //                   child: Center(
  //                     child: _isLoading
  //                         ? CircularProgressIndicator(color: Colors.white)
  //                         : Text(
  //                             'Register',
  //                             style: TextStyle(
  //                                 color: Colors.white,
  //                                 fontSize: 19,
  //                                 fontWeight: FontWeight.bold,
  //                                 letterSpacing: 4),
  //                           ),
  //                   ),
  //                 ),
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Text('Already Have An Account?'),
  //                   TextButton(
  //                       onPressed: () {
  //                         Navigator.push(
  //                           context,
  //                           MaterialPageRoute(builder: (context) {
  //                             return LoginScreen();
  //                           }),
  //                         );
  //                       },
  //                       child: Text('Login'))
  //                 ],
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
