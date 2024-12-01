import 'package:flutter/material.dart';
import 'pages/cart_page.dart';
import 'pages/catalog_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catalogue',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CatalogePage(),
    );
  }
}
