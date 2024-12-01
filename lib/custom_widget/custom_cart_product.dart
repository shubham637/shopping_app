import 'package:flutter/material.dart';

class CartProduct extends StatelessWidget {
  final String image;
  final String title;
  final String brand;
  final String price;
  final String discount;
  final String discPercentage;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CartProduct({
    Key? key,
    required this.image,
    required this.title,
    required this.brand,
    required this.price,
    required this.discount,
    required this.discPercentage,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                image,
                height: 180,
                width: 140,
              ),
            ),
            Expanded(
              child: Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, top: 10, bottom: 2),
                          child: Text(
                            title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            brand,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 8, top: 10, bottom: 2),
                          child: Row(
                            children: [
                              Text(
                                discount,
                                style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                price,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            discPercentage + " OFF",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 11, vertical: 11),
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.remove,
                                ),
                                onPressed: onDecrement,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  quantity.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.pink),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: onIncrement,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
