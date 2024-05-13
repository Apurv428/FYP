import 'package:flutter/material.dart';
import 'package:food_order_app/models/CartItem.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(CartItem item) {
    bool found = false;
    for (var cartItem in _cartItems) {
      if (cartItem.item.title == item.item.title) {
        cartItem.quantity++;
        found = true;
        break;
      }
    }
    if (!found) {
      _cartItems.add(item);
    }
    notifyListeners();
  }

  void decreaseQuantity(CartItem item) {
    for (var cartItem in _cartItems) {
      if (cartItem.item.title == item.item.title) {
        if (cartItem.quantity > 1) {
          cartItem.quantity--;
          break;
        }
      }
    }
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _cartItems.remove(item);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  int getCartItemQuantity(CartItem item) {
    for (var cartItem in _cartItems) {
      if (cartItem.item.title == item.item.title) {
        return cartItem.quantity;
      }
    }
    return 0; // Return 0 if item is not found in the cart
  }
}
