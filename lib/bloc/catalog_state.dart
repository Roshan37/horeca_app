part of 'catalog_bloc.dart';

abstract class CatalogState extends Equatable {
  const CatalogState();
  List<Object> get props => [];
}

class CatalogInitial extends CatalogState {}

class CatalogLoading extends CatalogState {}

class CatalogLoaded extends CatalogState {
  final List<Category> categoriesList;
  final List<Product> productsList;
  const CatalogLoaded(this.categoriesList, this.productsList);
}

class CatalogError extends CatalogState{
  final String? message;
  const CatalogError(this.message);
}