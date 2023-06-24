import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:horeca_project/resources/api-repository.dart';
import '../model/product.dart';
part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {

  ProductsBloc() : super(ProductsInitial()) {
    final ApiRepository apiRepository = ApiRepository();

    on<GetProducts> ((event, emit) async {
      try{
        emit(ProductsLoading());
        final productsList = await apiRepository.fetchProductsList();
        emit(ProductsLoaded(productsList));
      } on NetworkError {
        emit(const ProductsError("Failed to fetch data"));
      }
    });
  }
}