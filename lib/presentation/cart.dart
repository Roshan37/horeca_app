import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cart/cart_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      builder: (context, state) {
        if (state.productsList.isEmpty) {
          return const Center(child: Text('Корзина пуста'));
        } else {
          return ListView.builder(
            itemCount: state.productsList.length,
            itemBuilder: (context, index) {
              final product = state.productsList[index];
              return ListTile(
                title: Text(product.name),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    BlocProvider.of<CartBloc>(context)
                        .add(RemoveFromCart(product));
                  },
                ),
              );
            },
          );
        }
      },
        listener: (context, state){}
    );
  }
}
