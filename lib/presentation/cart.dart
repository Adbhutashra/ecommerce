import 'package:ecommerceapp/presentation/productDetails.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
 final  List<CartItem> items;

  const CartScreen({super.key, required this.items});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Placeholder data, replace with actual cart data

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
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.items[index].product.name),
                    subtitle: Text('Quantity: ${widget.items[index].quantity}'),
                    trailing: Text('\$${widget.items[index].totalPrice()}'),
                    onTap: () {
                      // Implement remove item functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Removed from Cart: ${widget.items[index].product.name}'),
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
    for (var item in widget.items) {
      total += item.totalPrice();
    }
    return total;
  }
}