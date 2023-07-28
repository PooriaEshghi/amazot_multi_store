import 'package:amazot_multi_store/views/buyers/nav_screens/widgets/profile_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('vendors');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return
            Scaffold(
              appBar: AppBar(
                elevation: 2,
                backgroundColor: Colors.yellow.shade900,
                title: Text(
                  'Profile',
                  style: TextStyle(letterSpacing: 4),
                ),
                centerTitle: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.shield_moon),
                  )
                ],
              ),
              body: Column(
                children: [
                  SizedBox(height: 20,),
                  Center(
                    child: CircleAvatar(
                      radius: 64,
                      backgroundColor: Colors.yellow.shade900,
                      backgroundImage: NetworkImage(data['profileImage']),
                    ),
                  ),
                  Text(data['fullName'],
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                    ),),
                  Text(data['email'],
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(
                      thickness: 2,
                      color: Colors.grey,
                    ),
                  ),
                  IconAndText(Icons.settings,'Setting'),
                  IconAndText(Icons.phone, 'Phone'),
                  IconAndText(Icons.shop, 'Cart')
                ],
              ),
            );
        }

        return CircularProgressIndicator();
      },
    );



  }
}
