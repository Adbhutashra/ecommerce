import 'package:ecommerceapp/Network/getServerData.dart';
import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List<Product> items = [];


  void addItem(Product product) {
    items.add(product);
    notifyListeners();
  }

void removeItem(int index) {
    if (index >= 0 && index < items.length) {
      items.removeAt(index);
      notifyListeners();
    }
  }
}
