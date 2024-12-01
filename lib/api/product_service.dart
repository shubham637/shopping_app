import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model/product_model.dart';

class ProductService {
  static const String _baseUrl = 'https://dummyjson.com/products';

  Future<List<Product>> fetchProducts(int limit, int skip) async {
    final response =
        await http.get(Uri.parse('$_baseUrl?limit=$limit&skip=$skip'));

    if (response.statusCode == 200) {
      final List products = json.decode(response.body)['products'];
      return products.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
