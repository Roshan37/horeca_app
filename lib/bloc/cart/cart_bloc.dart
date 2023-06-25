import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../model/product.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState([])) {

    on<AddToCart> ((event, emit) async {
      final currentCart = List<Product>.from(state.productsList)..add(event.product);
      emit(CartState(currentCart));
    });

    on<RemoveFromCart> ((event, emit) async {
      final currentCart = List<Product>.from(state.productsList)..remove(event.product);
      emit(CartState(currentCart));
    });
  }
}
