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
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              width: double.infinity,
              child: Image.network('https://fastly.picsum.photos/id/538/200/200.jpg?hmac=oJRLJPsN8ZdWjPpKGEU-oqAZMBKa4JsTnuUSqgRbyP4', fit: BoxFit.cover),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(product.name, style: TextStyle(fontSize: 22)),
                  SizedBox(height: 10),
                  Text(product.description, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 20),
                  Text('Цена: ${product.price.toString()} руб.'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}