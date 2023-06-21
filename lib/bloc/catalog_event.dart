part of 'catalog_bloc.dart';

abstract class CatalogEvent extends Equatable {
  const CatalogEvent();

  List<Object> get props => [];
}

class GetCatalog extends CatalogEvent{}