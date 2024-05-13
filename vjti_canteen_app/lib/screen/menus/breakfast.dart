import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_order_app/screen/order/cart.dart';
import 'package:food_order_app/screen/menus/single_menu.dart';
import 'package:food_order_app/screen/widgets/navigation.dart';
import 'package:food_order_app/models/Item.dart';

class Breakfast extends StatefulWidget {
  final String email;

  Breakfast(this.email);
  @override
  _BreakfastState createState() => _BreakfastState();
}

class _BreakfastState extends State<Breakfast> {
  late TextEditingController _searchController;
  late List<Item> _breakfastList = [];
  late List<Item> _filteredBreakfastList = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'CANTEEN HUB',
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
                  MaterialPageRoute(
                      builder: (context) => CartPage(widget.email)),
                );
              },
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFFF6F7F7),
      drawer: Navigation(widget.email),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.black, // Adjust border color as needed
                  width: 1.0,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search food items',
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _filteredBreakfastList = _breakfastList
                              .where((item) => item.title
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('Food').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  _breakfastList = snapshot.data!.docs
                      .where(
                          (document) => document["foodcategory"] == "Breakfast")
                      .map((document) => Item(
                            image: document["foodimage"],
                            title: document["foodtitle"],
                            price: document["foodprice"],
                            category: document["foodcategory"],
                          ))
                      .toList();

                  // Initialize filtered list with all items
                  if (_filteredBreakfastList.isEmpty) {
                    _filteredBreakfastList = _breakfastList;
                  }

                  return GridView.builder(
                    itemCount: _filteredBreakfastList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemBuilder: (context, index) {
                      return SingleMenu(
                        item: _filteredBreakfastList[index],
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
