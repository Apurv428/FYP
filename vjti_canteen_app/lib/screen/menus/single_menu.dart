import 'package:flutter/material.dart';
import 'package:food_order_app/models/CartItem.dart';
import 'package:food_order_app/models/Item.dart';
import 'package:food_order_app/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class SingleMenu extends StatelessWidget {
  final Item item;

  SingleMenu({required this.item});

  @override
  Widget build(BuildContext context) {
    void addItemToCart(BuildContext context, Item item) {
      CartProvider cartProvider =
          Provider.of<CartProvider>(context, listen: false);
      cartProvider.addToCart(CartItem(item: item));

      // Show a styled toast
      final snackBar = SnackBar(
        content: Text('${item.title} added to cart'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green, // Set background color
        behavior: SnackBarBehavior.floating, // Set behavior
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Set border radius
        ),
      );

      // Show the styled toast
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: FadeInImage.assetNetwork(
              placeholder: "images/placeholder.png",
              image: item.image,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item.title,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins-Medium',
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'Rs. ${item.price}',
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins-SemiBold',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Consumer<CartProvider>(
            builder: (context, cartProvider, _) {
              int itemQuantity =
                  cartProvider.getCartItemQuantity(CartItem(item: item));
              return Container(
                color: const Color(0xFFFAB317),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () =>
                          cartProvider.addToCart(CartItem(item: item)),
                      icon: const Icon(
                        Icons.add,
                        size: 22,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      itemQuantity.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () =>
                          cartProvider.decreaseQuantity(CartItem(item: item)),
                      icon: const Icon(
                        Icons.remove,
                        size: 22,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
