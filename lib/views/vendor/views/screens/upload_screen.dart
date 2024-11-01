import 'package:amazot_multi_store/provider/product_provider.dart';
import 'package:amazot_multi_store/views/vendor/views/screens/main_vendor_screen.dart';
import 'package:amazot_multi_store/views/vendor/views/screens/upload_tab_screens/attribute_tab_screen.dart';
import 'package:amazot_multi_store/views/vendor/views/screens/upload_tab_screens/general_screen.dart';
import 'package:amazot_multi_store/views/vendor/views/screens/upload_tab_screens/images_tab_screen.dart';
import 'package:amazot_multi_store/views/vendor/views/screens/upload_tab_screens/shiping_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class UploadScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Form(
        key: _formKey,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue.shade900,
            elevation: 0,
            bottom: TabBar(tabs: [
              Tab(
                child: Text('General'),
              ),
              Tab(
                child: Text('Shipping'),
              ),
              Tab(
                child: Text('attributes'),
              ),
              Tab(
                child: Text('Images'),
              ),
            ]),
          ),
          body: TabBarView(children: [
            GeneralScreen(),
            ShippingScreen(),
            AttributeTabScreen(),
            ImagesTabScreen(),
          ]),
          bottomSheet: Padding(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                print(_productProvider.productData['imageUrlList']);
                EasyLoading.show(status: 'Please Wait');
                if (_formKey.currentState!.validate()) {
                  final productId = Uuid().v4();
                  await _firestore.collection('products').doc(productId).set({
                    'productId': productId,
                    'productName': _productProvider.productData['productName'],
                    'productPrice':
                        _productProvider.productData['productPrice'],
                    'quantity': _productProvider.productData['quantity'],
                    'category': _productProvider.productData['category'],
                    'description': _productProvider.productData['description'],
                    'imageUrl': _productProvider.productData['imageUrlList'],
                    'scheduleDate':
                        _productProvider.productData['scheduleDate'],
                    'shippingCharge':
                        _productProvider.productData['shippingCharge'],
                    'chargeShipping':
                        _productProvider.productData['chargeShipping'],
                    'brandName': _productProvider.productData['brandName'],
                    'sizeList': _productProvider.productData['sizeList'],
                    'vendorId': FirebaseAuth.instance.currentUser!.uid,
                    'approved': false
                  }).whenComplete(() {
                    _productProvider.clearData();
                    _formKey.currentState!.reset();
                    EasyLoading.dismiss();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MainVendorScreen();
                    }));
                  });
                }
              },
              child: Text('Save'),
            ),
          ),
        ),
      ),
    );
  }
}
