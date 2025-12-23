import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
final List<Map<String, dynamic>> _cart = [];
List<Map<String, dynamic>> get cart => _cart;


bool isInCart(String productId) {
  return _cart.any((item) => item['id'] == productId);
}

void addProduct(Map<String, dynamic> product) {
  if (isInCart(product['id'])) return;

  _cart.add(product);
  notifyListeners();
}

void removeProduct (Map<String, dynamic> product) {
  _cart.remove(product);
  notifyListeners();
}
}