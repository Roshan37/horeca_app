import 'package:flutter/material.dart';
import '../model/product.dart';

class ProductScreen extends StatelessWidget {
  final Product product;

  const ProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final Product product = ModalRoute.of(context)?.settings.arguments as Product;
    final Product product = this.product;

    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(15.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Color(0xFFEEEEEE),
              ),
              child: Image.network(
                product.image,
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 22)
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                          '${product.price.toString()} ₽ '
                      ),
                      const Text('• ', style: TextStyle(color: Color(0xFFBDBDBD)),),
                      Text(
                          '${product.weight.toString()}г',
                          style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16)
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}