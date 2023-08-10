import 'package:amazot_multi_store/models/cart_attributes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartAttribute> _cartItems = {};

  Map<String, CartAttribute> get getCartItem {
    return _cartItems;
  }

  void addProductToCart(
      String productName,
      String productId,
      int quantity,
      double price,
      String vendorId,
      String productSize,
      Timestamp scheduleDate) {
    if (_cartItems.containsKey(productId)) {
      _cartItems.update(
          productId,
          (exitingCart) => CartAttribute(
              productName: exitingCart.productName,
              productId: exitingCart.productId,
              quantity: exitingCart.quantity + 1,
              price: exitingCart.price,
              vendorId: exitingCart.vendorId,
              productSize: exitingCart.productSize,
              scheduleDate: exitingCart.scheduleDate));
      notifyListeners();
    } else {
      _cartItems.putIfAbsent(
          productId,
          () => CartAttribute(
              productName: productName,
              productId: productId,
              quantity: quantity,
              price: price,
              vendorId: vendorId,
              productSize: productSize,
              scheduleDate: scheduleDate));
      notifyListeners();
    }
  }
}
