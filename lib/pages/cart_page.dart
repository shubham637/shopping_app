import 'package:flutter/material.dart';
import 'package:shopping_app/custom_widget/custom_cart_product.dart';
import '../utils.dart';

class CartPage extends StatefulWidget {
  final List<CartItem> cart;
  CartPage({required this.cart});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double get totalPrice =>
      widget.cart.fold(0, (sum, item) => sum + item.price * item.quantity);

  incrementQuantity(int index) {
    setState(() {
      widget.cart[index].quantity += 1;
    });
  }

  decrementQuantity(int index) {
    setState(() {
      if (widget.cart[index].quantity > 1) {
        widget.cart[index].quantity -= 1;
      } else {
        widget.cart.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      appBar: AppBar(
        backgroundColor: Colors.red.shade50,
        title: Text("Cart"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            setState(() {});
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: widget.cart.isEmpty
          ? Center(child: Text('Your cart is empty!'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cart.length,
                    itemBuilder: (context, index) {
                      final item = widget.cart[index];
                      return CartProduct(
                        image: item.image.toString(),
                        title: item.title,
                        brand: item.brand,
                        quantity: item.quantity,
                        price: item.price.toStringAsFixed(2),
                        discount: item.discount,
                        discPercentage: item.discPercentage,
                        onDecrement: () => decrementQuantity(index),
                        onIncrement: () => incrementQuantity(index),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Total: ₹${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
    );
  }
}
