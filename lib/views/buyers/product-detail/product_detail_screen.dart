import 'package:amazot_multi_store/provider/cart_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

import '../../../utils/show_snackBar.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic productData;
  const ProductDetailScreen({super.key, required this.productData});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String formattedDate(date) {
    final outPutDateFormate = DateFormat('dd/MM/yyyy');
    final outPutDate = outPutDateFormate.format(date);
    return outPutDate;
  }

  // int _imageIndex = 0;
  String? _selectedSize;
  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          widget.productData['productName'],
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  child: PhotoView(
                      imageProvider: NetworkImage(widget.productData['imageUrl']
                          // [_imageIndex]
                          )),
                ),
                // Positioned(
                //     bottom: 0,
                //     child: Container(
                //       height: 50,
                //       width: MediaQuery.of(context).size.width,
                //       child: ListView.builder(
                //         scrollDirection: Axis.horizontal,
                //         itemCount: widget.productData['imageUrl'].length,
                //         itemBuilder: (context, index) {
                //           return InkWell(
                //             // onTap: () {
                //             //   setState(() {
                //             //     _imageIndex = index;
                //             //   });
                //             // },
                //             child: Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: Container(
                //                 decoration: BoxDecoration(
                //                     border: Border.all(
                //                         color: Colors.blue.shade400)),
                //                 height: 60,
                //                 width: 60,
                //                 child: Image.network(
                //                     widget.productData['imageUrl'][index]),
                //               ),
                //             ),
                //           );
                //         },
                //       ),
                //     ),
                //     )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Text(
                '\$ ' + widget.productData['productPrice'].toStringAsFixed(2),
                style: TextStyle(
                    fontSize: 22,
                    letterSpacing: 8,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Text(
                widget.productData['productName'],
                style: TextStyle(
                    fontSize: 22,
                    letterSpacing: 8,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ExpansionTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product Description',
                    style: TextStyle(color: Colors.blue.shade400),
                  ),
                  Text(
                    'View More',
                    style: TextStyle(color: Colors.blue.shade400),
                  ),
                ],
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.productData['description'],
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey.shade600,
                      letterSpacing: 3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'This Product Will be Shipping On',
                  style: TextStyle(
                      color: Colors.blue.shade400,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Text(
                  formattedDate(widget.productData['scheduleDate'].toDate()),
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            ExpansionTile(
              title: Text('Available Size'),
              children: [
                Container(
                  height: 50,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.productData['sizeList'].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                _selectedSize =
                                    widget.productData['sizeList'][index];
                              });
                              print(_selectedSize);
                            },
                            child: Text(
                              widget.productData['sizeList'][index],
                            ),
                          ),
                        );
                      }),
                )
              ],
            )
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            if (_selectedSize == null) {
              return showSnack(context, 'Please Select a Size');
            } else {
              _cartProvider.addProductToCart(
                  widget.productData['productName'],
                  widget.productData['productId'],
                  widget.productData['imageUrl'],
                  1,
                  widget.productData['quantity'],
                  widget.productData['productPrice'],
                  widget.productData['vendorId'],
                  _selectedSize!,
                  widget.productData['scheduleDate']);
              return showSnack(context, 'Item added to cart');
            }
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.blue.shade400,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Icon(
                    CupertinoIcons.cart,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'ADD TO CART',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 5),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
