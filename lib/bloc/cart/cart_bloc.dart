import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../model/product.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState([])) {

    on<AddToCart> ((event, emit) async {
      final currentCart = List<Product>.from(state.productsList);
      if(currentCart.contains(event.product)) {
        final index = currentCart.indexOf(event.product);
        currentCart[index].quantity++;
      } else {
        currentCart.add(event.product);
      }
      emit(CartState(currentCart));
    });

    on<RemoveFromCart> ((event, emit) async {
      final currentCart = List<Product>.from(state.productsList);
      if(currentCart.contains(event.product)) {
        final index = currentCart.indexOf(event.product);
        if(currentCart[index].quantity == 1) {
          currentCart.remove(event.product);
        } else {
          currentCart[index].quantity--;
        }
      } else {
        currentCart.remove(event.product);
      }
      emit(CartState(currentCart));
    });
  }
}
