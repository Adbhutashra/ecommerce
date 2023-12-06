import 'dart:convert';
import 'package:ecommerceapp/Network/urls.dart';
import 'package:http/http.dart' as http;

Future<List<Product>> fetchProducts() async {
  final apiUrl = BASE_URL_END_POINT + GET_ALL_PRODUCTS;

  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<Product> products =
          data.map((json) => Product.fromJson(json)).toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  } catch (error) {
    throw Exception('Failed to connect to the server');
  }
}

class Product {
  final String name;
  final double price;

  Product({required this.name, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] ?? '',
      price:
          json['price'] != null ? double.parse(json['price'].toString()) : 0.0,
    );
  }
}
