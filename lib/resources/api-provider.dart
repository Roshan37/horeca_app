import 'package:dio/dio.dart';
import '../model/category.dart';
import '../model/product.dart';

class ApiProvider{
  final Dio _dio = Dio();
  final String _endpointCategories = 'https://run.mocky.io/v3/058729bd-1402-4578-88de-265481fd7d54';
  final String _endpointProducts = 'https://run.mocky.io/v3/aba7ecaa-0a70-453b-b62d-0e326c859b3b';

  Future<List<Category>> fetchCategoriesList() async{
    try{
      Response response = await _dio.get(_endpointCategories);
      return (response.data['сategories'] as List)
          .map((x) => Category.fromJson(x))
          .toList();
    } catch (error, stacktrace){
      print("Error occured: $error stackTrace: $stacktrace");
      return Category.withError("data not found / Connection issue");
    }
  }

  Future<List<Product>> fetchProductsList() async{
    try{
      Response response = await _dio.get(_endpointProducts);
      return (response.data['dishes'] as List)
          .map((x) => Product.fromJson(x))
          .toList();
    } catch (error, stacktrace){
      print("Error occured: $error stackTrace: $stacktrace");
      return Product.withError("data not found / Connection issue");
    }
  }
}