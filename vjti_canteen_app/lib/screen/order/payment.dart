import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_order_app/screen/order/coupon.dart';

class Payment extends StatelessWidget {
  final String price;
  final List<String> title;
  final List<String> quantity;
  final String email;

  Payment(this.quantity, this.price, this.title, this.email);

  Future<String> create() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("Order").get();
    int orderCount = querySnapshot.size;

    int orderID = orderCount + 1;

    await FirebaseFirestore.instance
        .collection("Order")
        .doc(orderID.toString())
        .set({
      "orderID": orderID,
      "title": title,
      "quantity": quantity,
      "price": price,
      "status": false,
      "email": email,
      "timestamp": DateTime.now(),
    });

    return orderID.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'CANTEEN HUB PAYMENT',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Are you sure to initialize Bank Transfer of",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 10),
                Text(
                  "Rs $price",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                String orderID = await create();
                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Coupon(title, price, quantity, orderID, email),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                side: const BorderSide(width: 2, color: Colors.black),
                minimumSize: const Size(200, 50),
              ),
              child:
                  const Text("Confirm", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
