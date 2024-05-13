import 'package:flutter/material.dart';
import 'package:food_order_app/screen/menus/all.dart';
import 'package:food_order_app/screen/menus/beverages.dart';
import 'package:food_order_app/screen/menus/breakfast.dart';
import 'package:food_order_app/screen/order/cart.dart';
import 'package:food_order_app/screen/menus/confectionery.dart';
import 'package:food_order_app/screen/menus/lunch.dart';
import 'package:food_order_app/screen/widgets/navigation.dart';
import 'package:food_order_app/screen/menus/snacks.dart';

class HomePage extends StatelessWidget {
  final String email;

  const HomePage(this.email);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F7),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'CANTEEN HUB',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
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
      drawer: Navigation(email),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildItemBox(
                    context,
                    "All Items",
                    "images/all_menu.png",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllItems(email)),
                      );
                    },
                  ),
                  _buildItemBox(
                    context,
                    "Snacks",
                    "images/snacks.png",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Snacks(email)),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildItemBox(
                    context,
                    "Lunch",
                    "images/lunch.png",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Lunch(email)),
                      );
                    },
                  ),
                  _buildItemBox(
                    context,
                    "Breakfast",
                    "images/breakfast.png",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Breakfast(email)),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildItemBox(
                    context,
                    "Beverages",
                    "images/drinks.png",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Beverages(email)),
                      );
                    },
                  ),
                  _buildItemBox(
                    context,
                    "Confectionary",
                    "images/confectionary.png",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Confectionery(email)),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemBox(BuildContext context, String title, String imagePath,
      VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 239, 134, 99),
          borderRadius: BorderRadius.circular(15.0),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                  15.0), // Border radius for the container
              child: Container(
                width: 125,
                height: 125,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      15.0), // Border radius for the image
                ),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
