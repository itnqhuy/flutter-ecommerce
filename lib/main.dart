import 'package:ecommerce/features/shop/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'E-Commerce App',
      home: HomeScreen(), // Gọi màn hình Home
    );
  }
}
