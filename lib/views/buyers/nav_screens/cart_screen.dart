import 'package:amazot_multi_store/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Cart Screen'),
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: _cartProvider.getCartItem.length,
          itemBuilder: (context, index) {
            final cartData = _cartProvider.getCartItem.values.toList()[index];
            return Card(
              child: SizedBox(
                height: 170,
                child: Row(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Icon(Icons.production_quantity_limits),
                    ),
                    Column(
                      children: [
                        Text(
                          cartData.productName,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 5),
                        ),
                        Text(
                          cartData.productSize,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 5),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
// Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Your Shoping Cart is empty',
//                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                     height: 40,
//                     width: MediaQuery.of(context).size.width - 40,
//                     decoration: BoxDecoration(
//                         color: Colors.yellow.shade900,
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Center(
//                         child: Text(
//                       'CONTINUE SHOPPING',
//                       style: TextStyle(fontSize: 19, color: Colors.white),
//                     )))
//               ],
//             ),
//           ),