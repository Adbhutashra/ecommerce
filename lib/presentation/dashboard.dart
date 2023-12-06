import 'package:ecommerceapp/Network/getServerData.dart';
import 'package:ecommerceapp/presentation/cart.dart';
import 'package:ecommerceapp/presentation/productDetails.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Placeholder data, replace with actual API calls
  List<Product> products = [];
  List<String> banners = ["Banner 1", "Banner 2", "Banner 3"];

  int cartItems = 0;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      List<Product> fetchedProducts = await fetchProducts();
      setState(() {
        products = fetchedProducts;
      });
    } catch (error) {
      // Handle error
      print('Error loading products: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Banner Section
            Container(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: banners.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(8),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(banners[index]),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailScreen(product: products[index])),
                      );
                    },
                    child: ListTile(
                      title: Text(products[index].name),
                      subtitle: Text('${products[index].price} Rs'),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),

            // Cart Section
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CartScreen()),
                      );
                 
                },
                child: Text(
                  'Cart Items: $cartItems',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
