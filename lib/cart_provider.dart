import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  // Store product names
  final List<String> _products = [];

  // Provide read-only access to products
  List<String> get products => List.unmodifiable(_products);

  // Calculate total number of products
  int get cartCount => _products.length;

  // Add a product
  void addProduct(String productName) {
    _products.add(productName);
    notifyListeners();
  }

  // Remove a product
  void removeProduct(String productName) {
    _products.remove(productName);
    notifyListeners();
  }

  // Clear the cart
  void clearCart() {
    if (_products.isEmpty) return;

    _products.clear();
    notifyListeners();
  }
}
