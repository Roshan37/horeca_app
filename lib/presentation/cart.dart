import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cart/cart_bloc.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state.productsList.isEmpty) {
          return const Center(child: Text('Корзина пуста'));
        } else {
          late int sum = 0;
          for (var product in state.productsList) {
            sum += product.price * product.quantity;
          }
          final currency = NumberFormat("#,##0", "ru_RU");
          final sumPrint = currency.format(sum);
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  itemCount: state.productsList.length,
                  itemBuilder: (context, index) {
                    final product = state.productsList[index];
                    return Container(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 62,
                            width: 62,
                            margin: const EdgeInsets.only(right: 10.0),
                            padding: const EdgeInsets.fromLTRB(8.0, 6.0, 5.0, 3.0),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              color: Color(0xFFEEEEEE),
                            ),
                            child: Image.network(
                              product.image,
                              fit: BoxFit.contain,
                              height: 140,
                              alignment: Alignment.center,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LimitedBox(
                                child: Text(
                                  product.name,
                                  maxLines: 2,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${product.price.toString()} ₽ '
                                  ),
                                  const Text(
                                    '• ',
                                    style: TextStyle(
                                      color: Color(0xFFBDBDBD)
                                    ),
                                  ),
                                  Text(
                                    '${product.weight.toString()}г',
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            height: 30,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              color: Color(0xFFEEEEEE),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  splashColor: Colors.transparent,
                                  padding: const EdgeInsets.all(0.0),
                                  onPressed: () {
                                    BlocProvider.of<CartBloc>(context)
                                        .add(RemoveFromCart(product));
                                  },
                                  icon: const Icon(Icons.remove, size: 20,),
                                ),
                                Text(product.quantity.toString()),
                                IconButton(
                                  splashColor: Colors.transparent,
                                  padding: const EdgeInsets.all(0.0),
                                  onPressed: () {
                                    BlocProvider.of<CartBloc>(context)
                                        .add(AddToCart(product));
                                  },
                                  icon: const Icon(Icons.add, size: 20,),
                                ),
                              ],
                            ),
                          ),
                        ]
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
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
                  onPressed: () {},
                  child: Text('Оплатить $sumPrint ₽')
                ),
              )
            ],
          );
        }
      },
    );
  }
}
