import 'package:amazot_multi_store/views/vendor/views/screens/earning_screen.dart';
import 'package:amazot_multi_store/views/vendor/views/screens/edit_product_screen.dart';
import 'package:amazot_multi_store/views/vendor/views/screens/upload_screen.dart';
import 'package:amazot_multi_store/views/vendor/views/screens/vendor_logout_screen.dart';
import 'package:amazot_multi_store/views/vendor/views/screens/vendor_order_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainVendorScreen extends StatefulWidget {
  const MainVendorScreen({super.key});

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  int _pageIndex = 0;
  List<Widget> _pages = [
    EarningScreen(),
    UploadScreen(),
    EditProductScreen(),
    VendorOrderScreen(),
    VendorLogoutScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _pageIndex,
          onTap: (value) {
            setState(() {
              _pageIndex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.blue.shade400,
          items: [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.money_dollar), label: 'EARNINGS'),
            BottomNavigationBarItem(icon: Icon(Icons.upload), label: 'UPLOAD'),
            BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'EDIT'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: 'ORDERS'),
            BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'LOGOUT'),
          ]),
      body: _pages[_pageIndex],
    );
  }
}
