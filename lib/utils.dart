import 'api/model/product_model.dart';

class CartItem {
  final int id;
  final String title;
  final String brand;
  final double price;
  final String? image;
  final String discount;
  final String discPercentage;
  int quantity;

  CartItem(Product product)
      : id = product.id,
        title = product.title,
        brand = product.brand,
        image = product.thumbnail,
        price = product.price,
        discount =
            '${(product.price / (1 - product.discountPercentage / 100)).toStringAsFixed(2)}',
        discPercentage = product.discountPercentage.toStringAsFixed(2),
        quantity = 1;
}
