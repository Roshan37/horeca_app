part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Product> productsList;
  final Set<String> tags;
  final int selectedTagIndex;
  const ProductsLoaded(this.productsList, this.tags, this.selectedTagIndex);
}

class ProductsError extends ProductsState{
  final String? message;
  const ProductsError(this.message);
}