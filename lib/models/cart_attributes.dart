import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class CartAttribute with ChangeNotifier {
  final String productName;
  final String productId;
  final int quantity;
  final double price;
  final String vendorId;
  final String productSize;
  final Timestamp scheduleDate;
  CartAttribute(
      {required this.productName,
      required this.productId,
      required this.quantity,
      required this.price,
      required this.vendorId,
      required this.productSize,
      required this.scheduleDate});
}
