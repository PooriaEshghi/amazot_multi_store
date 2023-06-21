import 'package:amazot_multi_store/views/vendor/views/screens/upload_tab_screens/attribute_tab_screen.dart';
import 'package:amazot_multi_store/views/vendor/views/screens/upload_tab_screens/general_tscreen.dart';
import 'package:amazot_multi_store/views/vendor/views/screens/upload_tab_screens/images_tab_screen.dart';
import 'package:amazot_multi_store/views/vendor/views/screens/upload_tab_screens/shiping_screen.dart';
import 'package:flutter/material.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
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
            )
          ]),
        ),
        body: TabBarView(children: [
          GeneralScreen(),
          ShippingScreen(),
          AttributeTabScreen(),
          ImagesTabScreen(),
        ]),
      ),
    );
  }
}
