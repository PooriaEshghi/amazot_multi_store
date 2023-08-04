import 'package:amazot_multi_store/provider/product_provider.dart';
import 'package:amazot_multi_store/views/vendor/views/screens/upload_tab_screens/attribute_tab_screen.dart';
import 'package:amazot_multi_store/views/vendor/views/screens/upload_tab_screens/general_screen.dart';
import 'package:amazot_multi_store/views/vendor/views/screens/upload_tab_screens/images_tab_screen.dart';
import 'package:amazot_multi_store/views/vendor/views/screens/upload_tab_screens/shiping_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print(_productProvider.productData['productName']);
                  print(_productProvider.productData['productPrice']);
                  print(_productProvider.productData['quantity']);
                  print(_productProvider.productData['category']);
                  print(_productProvider.productData['description']);
                  print(_productProvider.productData['imageUrlList']);
                  print(_productProvider.productData['shippingCharge']);
                  print(_productProvider.productData['chargeShipping']);
                  print(_productProvider.productData['brandName']);
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
