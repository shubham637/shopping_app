import 'package:flutter/material.dart';

class CatalogueProduct extends StatelessWidget {
  final String image;
  final String title;
  final String brand;
  final String price;
  final String discount;
  final String discPercentage;
  final VoidCallback ontap;

  const CatalogueProduct({
    Key? key,
    required this.image,
    required this.title,
    required this.brand,
    required this.price,
    required this.discount,
    required this.discPercentage,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            Image.network(
              image,
              height: 170,
              fit: BoxFit.cover,
            ),
            Positioned(
              right: 8,
              bottom: 8,
              child: InkWell(
                onTap: ontap,
                child: Container(
                  height: 25,
                  width: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "Add",
                    style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 10, bottom: 2),
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
            padding: const EdgeInsets.only(left: 8, top: 10, bottom: 2),
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
    );
  }
}
