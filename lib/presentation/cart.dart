import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  // Placeholder data, replace with actual cart data
  List cartItems = [
    // CartItem(product: Product(name: "Product 1", price: 20), quantity: 2),
    // CartItem(product: Product(name: "Product 2", price: 30), quantity: 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(cartItems[index].product.name),
                    subtitle: Text('Quantity: ${cartItems[index].quantity}'),
                    trailing: Text('\$${cartItems[index].totalPrice()}'),
                    onTap: () {
                      // Implement remove item functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Removed from Cart: ${cartItems[index].product.name}'),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 16),

            // Total Price Section
            Text(
              'Total Price: \$${calculateTotalPrice()}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  double calculateTotalPrice() {
    double total = 0;
    for (var item in cartItems) {
      total += item.totalPrice();
    }
    return total;
  }
}