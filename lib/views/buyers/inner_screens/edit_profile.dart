import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EditProfileScreen extends StatefulWidget {
  final dynamic userData;

  EditProfileScreen({super.key, required this.userData});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _fulNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();
  String? address;

  @override
  void initState() {
    setState(() {
      _fulNameController.text = widget.userData['fullName'];
      _emailController.text = widget.userData['email'];
      _phoneController.text = widget.userData['phoneNumber'];
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black, letterSpacing: 6, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.blue.shade500,
                    ),
                    Positioned(
                        right: 0,
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(CupertinoIcons.photo),
                        ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: _fulNameController,
                      decoration:
                          InputDecoration(labelText: 'Enter Full Name')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Enter Email')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(labelText: 'Enter Phone')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      onChanged: (value) {
                        address = value;
                      },
                      decoration: InputDecoration(labelText: 'Enter Address')),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () async {
            EasyLoading.show(status: 'UPDATING');
            await _firestore
                .collection('buyers')
                .doc('wVLN9C8HDbeDHl6kcSH21bdlGlv2')
                .update({
              'fullName': _fulNameController.text,
              'email': _emailController.text,
              'phoneNumber': _phoneController.text,
              'address': address,
            }).whenComplete(() {
              EasyLoading.dismiss();
              
            });
          },
          child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.blue.shade500,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text(
                'UPDATE',
                style: TextStyle(
                    color: Colors.white, fontSize: 18, letterSpacing: 6),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
