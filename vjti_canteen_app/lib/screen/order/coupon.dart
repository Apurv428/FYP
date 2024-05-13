import 'package:flutter/material.dart';
import 'package:food_order_app/provider/cart_provider.dart';
import 'package:food_order_app/screen/home_page.dart';
import 'package:food_order_app/screen/order/order.dart';
import 'package:food_order_app/screen/widgets/navigation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Coupon extends StatefulWidget {
  final String orderID; // Add orderID parameter
  final String price;
  final List<String> title;
  final List<String> quantity;
  final String email;

  const Coupon(
    this.title,
    this.price,
    this.quantity,
    this.orderID,
    this.email,
  ); // Include orderID in the constructor

  @override
  State<Coupon> createState() => _CouponState();
}

class _CouponState extends State<Coupon> {
  String time = "";

  @override
  void initState() {
    super.initState();
    _getCurrentTime();
  }

  void _getCurrentTime() {
    setState(() {
      time = DateFormat('hh:mm:ss a').format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'CANTEEN HUB COUPON',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      drawer: Navigation(widget.email),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Coupon Details',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Order ID: ${widget.orderID}", // Display order ID
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              Flexible(
                fit: FlexFit.loose,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.title.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Title: ${widget.title[index]}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Quantity: ${widget.quantity[index]}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Payment: Rs ${widget.price}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Time of Order: $time",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  CartProvider cartProvider =
                      Provider.of<CartProvider>(context, listen: false);
                  cartProvider.clearCart();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderPage(widget.email)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  side: const BorderSide(color: Color(0xFFFAB317), width: 5),
                  minimumSize: const Size(200, 60),
                ),
                child: const Text(
                  "Go to Orders",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Clear the cart before navigating back to the HomePage
                  CartProvider cartProvider =
                      Provider.of<CartProvider>(context, listen: false);
                  cartProvider.clearCart();

                  // Navigate back to the HomePage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage(widget.email)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  side: const BorderSide(color: Color(0xFFFAB317), width: 5),
                  minimumSize: const Size(200, 60),
                ),
                child: const Text(
                  "Got the Food",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
