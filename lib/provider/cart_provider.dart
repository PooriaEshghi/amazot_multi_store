import 'package:amazot_multi_store/models/cart_attributes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartAttribute> _cartItems = {};

  Map<String, CartAttribute> get getCartItem {
    return _cartItems;
  }

  double get totalPrice {
    var total = 0.0;

    _cartItems.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addProductToCart(
      String productName,
      String productId,
      String imageUrl,
      int quantity,
      int productQuantity,
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
              imageUrl: exitingCart.imageUrl,
              quantity: exitingCart.quantity + 1,
              productQuantity: exitingCart.productQuantity,
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
              imageUrl: imageUrl,
              quantity: quantity,
              productQuantity: productQuantity,
              price: price,
              vendorId: vendorId,
              productSize: productSize,
              scheduleDate: scheduleDate));
      notifyListeners();
    }
  }

  void increment(CartAttribute cartAttribute) {
    cartAttribute.increase();

    notifyListeners();
  }

  void decrement(CartAttribute cartAttribute) {
    cartAttribute.decrease();
    notifyListeners();
  }

  removeItem(productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  removeAllItems() {
    _cartItems.clear();
    notifyListeners();
  }
}
