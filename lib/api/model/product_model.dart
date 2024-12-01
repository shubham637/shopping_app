class Product {
  final int id;
  final String title;
  final String brand;
  String? thumbnail;
  final double price;
  final double discountPercentage;

  Product({
    required this.id,
    required this.title,
    required this.brand,
    this.thumbnail,
    required this.price,
    required this.discountPercentage,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      brand: json['brand'],
      thumbnail: json['thumbnail'],
      price: json['price'] - (json['price'] * json['discountPercentage'] / 100),
      discountPercentage: json['discountPercentage'],
    );
  }
}
