import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_order_app/screen/order/cart.dart';
import 'package:food_order_app/screen/widgets/navigation.dart';

class OrderPage extends StatelessWidget {
  final String email;

  const OrderPage(this.email);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'CANTEEN HUB Orders',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              color: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage(email)),
                );
              },
            ),
          ],
        ),
      ),
      drawer: Navigation(email),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Order')
            .where('email', isEqualTo: email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No orders found for $email'));
          }

          return ListView(
            children: snapshot.data!.docs.reversed.map((doc) {
              return OrderTile(
                orderID: doc['orderID'],
                price: doc['price'],
                items: List<String>.from(doc['title']),
                status: doc['status'],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class OrderTile extends StatelessWidget {
  final int orderID;
  final String price;
  final List<String> items;
  final bool status;

  const OrderTile({
    required this.orderID,
    required this.price,
    required this.items,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order ID: $orderID',
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                Text(
                  'Price: $price',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Status: ${status ? 'Done' : 'Preparing'}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: status ? Colors.green : Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Items:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text('- $item'),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
