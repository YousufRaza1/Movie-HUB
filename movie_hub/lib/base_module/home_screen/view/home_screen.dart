import 'package:flutter/material.dart';
import '../../../network/api_manager.dart';
import '../../../network/api_end_point.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('hello'),
      ),
    );
  }
}

// Define your Product model
class Product {
  final int id;
  final String title;
  final double price;

  Product({required this.id, required this.title, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
    );
  }
}

class HomeViewController {
  void fetchProducts() async {
    final endpoint = APIEndpoint(
      path: '/products',
      method: HTTPMethod.GET,
    );

    final result = await APIManager.instance.request<List<Product>>(
      endpoint,
          (data) {
        return (data as List)
            .map((item) => Product.fromJson(item))
            .toList();
      },
    );

    if (result.data != null) {
      // Success
      print('Products: ${result.data}');
    } else {
      // Error
      print('Error: ${result.error?.message}');
    }
  }
}