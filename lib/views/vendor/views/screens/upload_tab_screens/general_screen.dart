import 'package:amazot_multi_store/provider/product_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GeneralScreen extends StatefulWidget {
  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<String> _categoryList = [];
  _getCategories() {
    return _firestore
        .collection('categories')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          _categoryList.add(doc['categoryName']);
        });
      });
    });
  }

  @override
  void initState() {
    _getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter Product Name',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter Product Price',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Enter Product Quantity',
                ),
              ),
              SizedBox(
                height: 30,
              ),
              DropdownButtonFormField(
                hint: Text('Select Category'),
                items: _categoryList.map<DropdownMenuItem<String>>((elm) {
                  return DropdownMenuItem(value: elm, child: Text(elm));
                }).toList(),
                onChanged: (value) {},
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                maxLines: 10,
                decoration: InputDecoration(
                    labelText: 'Enter Product Description',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              Row(children: [
                TextButton(
                    onPressed: () {
                      showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(5000));
                    },
                    child: Text('Schedule'))
              ])
            ],
          ),
        ),
      ),
    );
  }
}
