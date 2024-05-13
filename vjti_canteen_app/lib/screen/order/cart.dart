import 'package:flutter/material.dart';
import 'package:food_order_app/models/CartItem.dart';
import 'package:food_order_app/screen/home_page.dart';
import 'package:food_order_app/screen/order/payment.dart';
import 'package:food_order_app/screen/widgets/navigation.dart';
import 'package:provider/provider.dart';
import 'package:food_order_app/provider/cart_provider.dart';

class CartPage extends StatelessWidget {
  final String email;

  const CartPage(this.email);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'CANTEEN HUB CART',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      drawer: Navigation(email),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          double totalAmount = 0;
          for (var cartItem in cartProvider.cartItems) {
            totalAmount +=
                cartItem.quantity * double.parse(cartItem.item.price);
          }
          return cartProvider.cartItems.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/cart_empty.png',
                        width: 500,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Your cart is empty.',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 31, 22, 2),
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => HomePage(email),
                          ));
                        },
                        child: Text('Start Ordering!'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFAB317),
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartProvider.cartItems.length,
                        itemBuilder: (context, index) {
                          var cartItem = cartProvider.cartItems[index];
                          return Column(
                            children: [
                              const SizedBox(
                                height:
                                    10, // Adjust the height of the SizedBox as needed
                              ),
                              Card(
                                margin: const EdgeInsets.all(8),
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFAB317),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(8),
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Material(
                                        elevation: 4,
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black, width: 2),
                                          ),
                                          child: SizedBox(
                                            width: 80,
                                            child: Image.network(
                                              cartItem.item.image,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      cartItem.item.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '₹${cartItem.item.price}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            cartProvider.addToCart(cartItem);
                                            _showSnackBar(
                                                context, 'Item added to cart',
                                                isAddAction: true);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            padding: const EdgeInsets.all(4),
                                            child: const Icon(
                                              Icons.add,
                                              size: 24,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: Text(
                                            cartItem.quantity.toString(),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        InkWell(
                                          onTap: () {
                                            if (cartItem.quantity == 1) {
                                              cartProvider
                                                  .removeFromCart(cartItem);
                                              _showSnackBar(context,
                                                  'Item removed from cart',
                                                  isAddAction: false);
                                            } else {
                                              cartProvider
                                                  .decreaseQuantity(cartItem);
                                              _showSnackBar(context,
                                                  'Item quantity decreased',
                                                  isAddAction: false);
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            padding: const EdgeInsets.all(4),
                                            child: const Icon(
                                              Icons.remove,
                                              size: 24,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 15),
                                        InkWell(
                                          onTap: () {
                                            _showDeleteConfirmationDialog(
                                                context, cartItem);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 3),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: const Color(0xFFFAB317),
                                            ),
                                            padding: const EdgeInsets.all(4),
                                            child: const Icon(
                                              Icons.delete,
                                              size: 24,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Total Amount: ₹${totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold), // Adjust font size
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (cartProvider.cartItems.isNotEmpty) {
                            List<String> foodTitles = [];
                            List<int> foodQuantities = [];

                            for (var cartItem in cartProvider.cartItems) {
                              foodTitles.add(cartItem.item.title);
                              foodQuantities.add(cartItem.quantity);
                            }
                            List<String> foodQuantitiesNew = foodQuantities
                                .map((quantity) => quantity.toString())
                                .toList();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Payment(
                                    foodQuantitiesNew,
                                    totalAmount.toStringAsFixed(2),
                                    foodTitles,
                                    email),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor:
                              const Color(0xFFFAB317), // foreground color
                        ),
                        child: const Text('Checkout'),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, CartItem cartItem) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Item"),
          content: const Text(
              "Are you sure you want to delete this item from your cart?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                    color: Color(0xFFFAB317), fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () {
                cartProvider.removeFromCart(cartItem);
                Navigator.of(context).pop();
              },
              child: const Text(
                "Delete",
                style: TextStyle(
                    color: Color(0xFFFAB317), fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message,
      {bool isAddAction = true}) {
    Color snackBarColor = isAddAction ? Colors.green : Colors.red;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 1),
        backgroundColor: snackBarColor,
      ),
    );
  }
}
