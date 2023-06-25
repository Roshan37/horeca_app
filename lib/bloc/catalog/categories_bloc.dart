import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:horeca_project/resources/api-repository.dart';
import '../../model/category.dart';
part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {

  CategoriesBloc() : super(CategoriesInitial()) {
    final ApiRepository apiRepository = ApiRepository();

    on<GetCategories> ((event, emit) async {
      try{
        emit(CategoriesLoading());
        final categoriesList = await apiRepository.fetchCategoriesList();
        emit(CategoriesLoaded(categoriesList));
      } on NetworkError {
        emit(const CategoriesError("Failed to fetch data"));
      }
    });
  }
}
