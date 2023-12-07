import 'package:ecommerceapp/Controller/cartController.dart';
import 'package:ecommerceapp/Network/getServerData.dart';
import 'package:ecommerceapp/presentation/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  ProductDetailScreen({super.key, required this.product});
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  

  
  
  
  
  

  
  
  
  
  
  
  
  


  
  
  

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            
            
            
            
            
            
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
                

                context.read<CartModel>().addItem(widget.product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added to Cart: ${widget.product.name}'),
                  ),
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CartScreen(
                            items: context.read<CartModel>().items,
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