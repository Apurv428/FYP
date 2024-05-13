import 'package:flutter/material.dart';
import 'package:food_order_app/screen/auth/login_page.dart';
import 'package:food_order_app/screen/order/cart.dart';
import 'package:food_order_app/screen/home_page.dart';
import 'package:food_order_app/screen/auth/profile.dart';
import 'package:food_order_app/screen/order/order.dart';

class Navigation extends StatelessWidget {
  final String email;

  Navigation(this.email);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: Center(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const UserAccountsDrawerHeader(
                accountName: Text(
                  'CANTEEN HUB',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: null,
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.restaurant_menu,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFFAB317),
                ),
              ),
              const SizedBox(height: 20),
              buildListTile(
                icon: Icons.home,
                title: 'Home',
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage(email)),
                  );
                },
              ),
              buildListTile(
                icon: Icons.shopping_cart,
                title: 'Cart',
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage(email)),
                  );
                },
              ),
              buildListTile(
                icon: Icons.shopping_basket,
                title: 'Order',
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => OrderPage(email)),
                  );
                },
              ),
              buildListTile(
                icon: Icons.person,
                title: 'Profile',
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Profile(email)),
                  );
                },
              ),
              buildListTile(
                icon: Icons.logout,
                title: 'Logout',
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListTile({
    required IconData icon,
    required String title,
    required Function onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.orange,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.orange,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap as void Function(),
    );
  }
}
