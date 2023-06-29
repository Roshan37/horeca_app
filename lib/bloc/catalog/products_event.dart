part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class GetProducts extends ProductsEvent{}

class FilterProducts extends ProductsEvent{
  final List<Product> productsList;
  final String newSelectedTag;
  final  Set<String> tags;

  const FilterProducts(this.productsList, this.newSelectedTag, this.tags);

  @override
  List<Object> get props => [productsList, newSelectedTag];
}