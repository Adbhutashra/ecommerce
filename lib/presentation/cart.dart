import 'package:ecommerceapp/Controller/cartController.dart';
import 'package:ecommerceapp/Network/getServerData.dart';
import 'package:ecommerceapp/presentation/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  final List<Product> items;

  const CartScreen({super.key, required this.items});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
          
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DashboardScreen()),
            );
          },
        ),
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
                  return Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.items[index].name),
                        ),
                        Text('\$${widget.items[index].price}'),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                 context
                                  .read<CartModel>()
                                  .removeItem(index);
                              
                              });
                             
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Removed from Cart: ${widget.items[index].name}'),
                                ),
                              );
                            },
                            icon: Icon(Icons.delete)),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),

            
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
      total += item.price;
    }
    return total;
  }
}


