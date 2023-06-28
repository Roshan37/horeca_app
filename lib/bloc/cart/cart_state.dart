part of 'cart_bloc.dart';

class CartState extends Equatable {
  final List<Product> productsList;

  const CartState(this.productsList);

  @override
  List<Object?> get props => [productsList, identityHashCode(this)];
}