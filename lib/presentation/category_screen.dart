import 'package:flutter/material.dart';
import 'package:horeca_project/model/product.dart';
import 'package:horeca_project/presentation/product_screen.dart';
import '../model/category.dart';

class CategoryScreen extends StatelessWidget {
  late List<Product> productList;
  late String? categoryName;

  CategoryScreen({super.key, required this.productList, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName!),
      ),
      body: GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 210,
          crossAxisCount: 3,
          crossAxisSpacing: 10,
        ),
        itemCount: productList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ProductScreen(product: productList[index]);
                },
              );
            },
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Color(0xFFEEEEEE),
                  ),
                  child: Image.network(
                    productList[index].image,
                    fit: BoxFit.contain,
                    height: 140,
                    alignment: Alignment.center,
                  ),
                ),
                Text(
                  textAlign: TextAlign.start,
                  productList[index].name,
                  style: const TextStyle(
                    fontSize: 16,
                  )
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}