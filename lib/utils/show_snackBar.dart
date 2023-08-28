import 'package:flutter/material.dart';

showSnack(context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.blue.shade400, content: Text(title)));
}
