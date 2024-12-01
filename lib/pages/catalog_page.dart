import 'package:flutter/material.dart';
import '../api/model/product_model.dart';
import '../api/product_service.dart';
import '../custom_widget/custom_catalogue.dart';
import '../utils.dart';
import 'cart_page.dart';

class CatalogePage extends StatefulWidget {
  const CatalogePage({Key? key}) : super(key: key);

  @override
  _CatalogePageState createState() => _CatalogePageState();
}

class _CatalogePageState extends State<CatalogePage> {
  final ProductService _service = ProductService();
  final List<Product> _products = [];
  final List<CartItem> _cart = [];
  int _page = 0;
  bool _isLoading = false;
  bool _isFetchingMore = false;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    if (_isLoading || _isFetchingMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final newProducts = await _service.fetchProducts(12, _page * 12);
      setState(() {
        _products.addAll(newProducts);
        _page++;
      });
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchMoreProducts() async {
    if (_isFetchingMore) return;

    setState(() {
      _isFetchingMore = true;
    });

    try {
      final newProducts = await _service.fetchProducts(12, _page * 12);
      setState(() {
        _products.addAll(newProducts);
        _page++;
      });
    } catch (e) {
      print('Error fetching more products: $e');
    } finally {
      setState(() {
        _isFetchingMore = false;
      });
    }
  }

  void _addToCart(Product product) {
    final existing = _cart.firstWhere(
      (item) => item.id == product.id,
      orElse: () => CartItem(product),
    );

    setState(() {
      if (!_cart.contains(existing)) {
        _cart.add(existing);
      } else {
        existing.quantity++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
        backgroundColor: Colors.red.shade50,
        title: const Text("Catalogue"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(cart: _cart),
                      ),
                    );
                  },
                ),
                if (_cart.isNotEmpty)
                  Positioned(
                    right: 5,
                    top: 5,
                    child: CircleAvatar(
                      minRadius: 10,
                      backgroundColor: Colors.pink,
                      child: Text(
                        _cart.length.toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: _isLoading && _products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                // Trigger fetch only once when reaching the bottom
                if (!_isFetchingMore &&
                    scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _fetchMoreProducts(); // Avoid direct call during build
                  });
                  return true;
                }
                return false;
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.60,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: _products.length + (_isFetchingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < _products.length) {
                      final product = _products[index];
                      return CatalogueProduct(
                        ontap: () {
                          _addToCart(product);
                        },
                        image: product.thumbnail ?? 'assets/placeholder.jpg',
                        title: product.title,
                        brand: product.brand,
                        price: '₹${product.price.toStringAsFixed(2)}',
                        discPercentage:
                            '${product.discountPercentage.toStringAsFixed(2)}%',
                        discount:
                            '${(product.price / (1 - product.discountPercentage / 100)).toStringAsFixed(2)}',
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
    );
  }
}
