import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:horeca_project/resources/api-repository.dart';
import '../model/category.dart';
import '../model/product.dart';
part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {

  CatalogBloc() : super(CatalogInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetCatalog> ((event, emit) async {
      try{
        emit(CatalogLoading());
        final categoriesList = await _apiRepository.fetchCategoriesList();
        final productsList = await _apiRepository.fetchProductsList();
        emit(CatalogLoaded(categoriesList, productsList));
      } on NetworkError {
        emit(const CatalogError("Failed to fetch data"));
      }
    });
  }
}
