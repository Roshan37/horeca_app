import 'package:horeca_project/model/product.dart';

class Category {
  String name;
  String image;
  List<Product> products;

  Category({required this.name, required this.image, required this.products});
}