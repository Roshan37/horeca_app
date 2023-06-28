import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:horeca_project/resources/api-repository.dart';
import '../../model/product.dart';
part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {

  ProductsBloc() : super(ProductsInitial()) {
    final ApiRepository apiRepository = ApiRepository();
    int selectedTagIndex = 0;
    on<GetProducts> ((event, emit) async {
      try{
        emit(ProductsLoading());
        final productsList = await apiRepository.fetchProductsList();
        Set<String> tags = {};
        for (var product in productsList) {
          tags.addAll(product.tags);
        }
        emit(ProductsLoaded(productsList, tags, selectedTagIndex));
      } on NetworkError {
        emit(const ProductsError("Failed to fetch data"));
      }
    });
  }
}