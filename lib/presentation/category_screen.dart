import 'package:flutter/material.dart';
import 'package:horeca_project/presentation/product_screen.dart';
import '../model/category.dart';

class CategoryScreen extends StatelessWidget {
  late Category category;

  CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: ListView.builder(
        itemCount: category.products.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ProductScreen(product: category.products[index]);
                },
              );
              // Navigator.pushNamed(context, ProductScreen.routeName,
              //     arguments: category.products[index]);
            },
            child: Card(
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.network('https://fastly.picsum.photos/id/357/200/200.jpg?hmac=hHhE00vBpBPSjAiUhwzFKQi9PsCWu7sblLKC2rT6Fn8',
                        fit: BoxFit.cover),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(category.products[index].name,
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 5),
                          Text(category.products[index].description),
                          const SizedBox(height: 5),
                          Text(category.products[index].tags.join(', ')),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}