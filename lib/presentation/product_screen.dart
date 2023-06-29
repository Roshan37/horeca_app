import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../bloc/cart/cart_bloc.dart';
import '../model/product.dart';

class ProductScreen extends StatelessWidget {
  final Product product;

  const ProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final Product product = ModalRoute.of(context)?.settings.arguments as Product;
    final Product product = this.product;
    final currency = NumberFormat("#,##0", "ru_RU");
    final pricePrint = currency.format(product.price);

    return AlertDialog(
      insetPadding: const EdgeInsets.all(20.0),
      contentPadding: const EdgeInsets.all(20.0),
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
              child: Stack(
                children: [
                  Image.network(
                    product.image,
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            color: Colors.white,
                          ),
                          child: IconButton(
                            onPressed: () => {},
                            icon: const Icon(Icons.favorite_border)
                          )
                        ),
                        const SizedBox(width: 10.0),
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            color: Colors.white,
                          ),
                          child: IconButton(
                            onPressed: () => {
                              context.pop()
                            },
                            icon: const Icon(Icons.close)
                          )
                        ),
                      ],
                    )
                  ),
                ]
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10.0),
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
                          '$pricePrint ₽ '
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
                  const SizedBox(height: 15),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        )
                      ),
                      fixedSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width, 50),
                      ),
                    ),
                    onPressed: () {
                      BlocProvider.of<CartBloc>(context).add(AddToCart(product));
                      context.pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 2),
                          content: Text('Блюдо добавлено в корзину'),
                        )
                      );
                    },
                    child: const Text('Добавить в корзину')
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}