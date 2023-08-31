import 'package:amazot_multi_store/provider/cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../main_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    CollectionReference users = FirebaseFirestore.instance.collection('buyers');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc('wVLN9C8HDbeDHl6kcSH21bdlGlv2').get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              elevation: 2,
              backgroundColor: Colors.blue.shade500,
              title: Text(
                'Checkout',
                style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 6,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: ListView.builder(
                shrinkWrap: true,
                itemCount: _cartProvider.getCartItem.length,
                itemBuilder: (context, index) {
                  final cartData =
                      _cartProvider.getCartItem.values.toList()[index];
                  return Card(
                    child: SizedBox(
                      height: 180,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(cartData.imageUrl),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  cartData.productName,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 5),
                                ),
                                Text(
                                  "\$" +
                                      " " +
                                      cartData.price.toStringAsFixed(2),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 5,
                                      color: Colors.blue.shade400),
                                ),
                                OutlinedButton(
                                  onPressed: null,
                                  child: Text(cartData.productSize),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
            bottomSheet: data['address'] == ''
                ? TextButton(
                    onPressed: () {}, child: Text('Enter Billing aAdress'))
                : Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: InkWell(
                      onTap: () {
                        EasyLoading.show(status: 'Placing Order');
                        // We want to be able to place order, in future
                        _cartProvider.getCartItem.forEach((key, item) {
                          final orderId = Uuid().v4();
                          _firestore.collection('orders').doc(orderId).set({
                            'orderId': orderId,
                            'vendor': item.vendorId,
                            'email': data['email'],
                            'phone': data['phone'],
                            'address': data['address'],
                            'buyerId': data['buyerId'],
                            'fullName': data['fullName'],
                            'buyerPhoto': data['profilrPhoto'],
                            'productName': item.productName,
                            'productPrice': item.price,
                            'productId': item.price,
                            'productImage': item.imageUrl,
                            'quantity': item.productQuantity,
                            'productSize': item.productSize,
                            'scheduleDate': item.scheduleDate,
                            'orderDate': DateTime.now()
                          }).whenComplete(() {
                            _cartProvider.getCartItem.clear();
                          });
                          EasyLoading.dismiss();

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return MainScreen();
                            }),
                          );
                        });
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade500,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            'PLACE ORDER',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
          );
        }

        return Center(
          child: CircularProgressIndicator(
            color: Colors.blue.shade500,
          ),
        );
      },
    );
  }
}
