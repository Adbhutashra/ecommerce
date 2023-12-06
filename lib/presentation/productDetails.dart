import 'package:ecommerceapp/Network/getServerData.dart';
import 'package:ecommerceapp/presentation/cart.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  ProductDetailScreen({super.key, required this.product});
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  List<CartItem> items = [];

  addToCart(Product product) {
    // Check if the product is already in the cart
    var existingItemIndex = items.indexWhere(
      (item) => item.product.name == product.name,
    );

    if (existingItemIndex != -1) {
      // If the product is already in the cart, increase the quantity
      items[existingItemIndex].quantity++;
    } else {
      // If the product is not in the cart, add a new cart item
      items.add(CartItem(product: product, quantity: 1));
    }
  }

  // void removeFromCart(Product product) {
  //   items.removeWhere((item) => item.product.name == product.name);
  // }

  // double calculateTotalPrice() {
  //   return items.fold(0, (total, item) => total + item.totalPrice());
  // }

  @override
  Widget build(BuildContext context) {
    // final Product product = ModalRoute.of(context).settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image.asset(
            //   'assets/product_image_placeholder.png', // Add your actual image asset path
            //   height: 150,
            //   width: 150,
            //   fit: BoxFit.cover,
            // ),
            SizedBox(height: 16),
            Text(
              widget.product.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              '${widget.product.price} Rs',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await addToCart(widget.product);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added to Cart: ${widget.product.name}'),
                  ),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CartScreen(
                            items: items,
                          )),
                );
              },
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});

  double totalPrice() {
    return product.price * quantity;
  }
}
