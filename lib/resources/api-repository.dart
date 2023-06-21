import 'api-provider.dart';
import 'package:horeca_project/model/product.dart';
import 'package:horeca_project/model/category.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<List<Category>> fetchCategoriesList(){
    return _provider.fetchCategoriesList();
  }

  Future<List<Product>> fetchProductsList(){
    return _provider.fetchProductsList();
  }
}

class NetworkError extends Error {}