part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<Category> categoriesList;
  const CategoriesLoaded(this.categoriesList);
}

class CategoriesError extends CategoriesState{
  final String? message;
  const CategoriesError(this.message);
}