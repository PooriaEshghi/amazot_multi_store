import 'package:amazot_multi_store/provider/cart_provider.dart';
import 'package:amazot_multi_store/views/buyers/inner_screens/checkout_screen.dart';
import 'package:flutter/cupertino.dart';
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
        title: Text(
          'Cart Screen',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 4),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _cartProvider.removeAllItems();
              },
              icon: Icon(
                CupertinoIcons.delete,
                color: Colors.white,
              ))
        ],
      ),
      body: _cartProvider.getCartItem.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: _cartProvider.getCartItem.length,
              itemBuilder: (context, index) {
                final cartData =
                    _cartProvider.getCartItem.values.toList()[index];
                return Card(
                  child: SizedBox(
                    height: 180,
                    child: Row(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.network(cartData.imageUrl),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                cartData.productName,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 5),
                              ),
                              Text(
                                "\$" + " " + cartData.price.toStringAsFixed(2),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 5,
                                    color: Colors.blue.shade400),
                              ),
                              OutlinedButton(
                                onPressed: null,
                                child: Text(cartData.productSize),
                              ),
                              Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 38,
                                        width: 140,
                                        decoration: BoxDecoration(
                                            color: Colors.blue.shade400,
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconButton(
                                              onPressed: cartData.quantity == 1
                                                  ? null
                                                  : () {
                                                      _cartProvider
                                                          .decrement(cartData);
                                                    },
                                              icon: Icon(
                                                CupertinoIcons.minus,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              cartData.quantity.toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                            IconButton(
                                              onPressed: cartData
                                                          .productQuantity ==
                                                      cartData.quantity
                                                  ? null
                                                  : () {
                                                      _cartProvider
                                                          .increment(cartData);
                                                    },
                                              icon: Icon(
                                                CupertinoIcons.plus,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            _cartProvider
                                                .removeItem(cartData.productId);
                                          },
                                          icon: Icon(
                                              CupertinoIcons.cart_badge_minus))
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              })
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Shoping Cart is empty',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                          color: Colors.blue.shade400,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                          child: Text(
                        'CONTINUE SHOPPING',
                        style: TextStyle(fontSize: 19, color: Colors.white),
                      )))
                ],
              ),
            ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: _cartProvider.totalPrice == 0.00
              ? null
              : () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CheckoutScreen();
                  }));
                },
          child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: _cartProvider.totalPrice == 0.00
                    ? Colors.grey
                    : Colors.blue.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: Text(
                "\$ " +
                    _cartProvider.totalPrice.toStringAsFixed(2) +
                    " " +
                    'CHECKOUT',
                style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 8,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ))),
        ),
      ),
    );
  }
}
