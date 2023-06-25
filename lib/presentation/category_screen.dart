import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:horeca_project/presentation/product_screen.dart';
import '../bloc/catalog/products_bloc.dart';

class CategoryScreen extends StatelessWidget {
  final String? categoryName;
  const CategoryScreen({super.key, required this.categoryName});

  Widget _buildListProducts() {
    return BlocProvider<ProductsBloc>(
      create: (context) => ProductsBloc()..add(GetProducts()),
      child: BlocListener<ProductsBloc, ProductsState>(
        listener: (context, state) {
          if(state is ProductsError) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                )
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
          title: Text(categoryName!),
          ),
          body: (BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state){
              if(state is ProductsInitial) {
                return _buildLoading();
              } else if(state is ProductsLoading) {
                return _buildLoading();
              } else if(state is ProductsLoaded) {
                return _buildCard(context, state);
              } else if(state is ProductsError) {
                return Container();
              } else {
                return Container();
              }
            },
          )),
        )
      ),
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  Widget _buildCard(BuildContext context, model){
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 210,
        crossAxisCount: 3,
        crossAxisSpacing: 10,
      ),
      itemCount: model.productsList.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ProductScreen(product: model.productsList[index]);
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
                  model.productsList[index].image,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return SizedBox(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                  fit: BoxFit.contain,
                  height: 140,
                  alignment: Alignment.center,
                ),
              ),
              Text(
                  //textAlign: TextAlign.start,
                  model.productsList[index].name,
                  style: const TextStyle(
                    fontSize: 16,
                  )
              ),
            ],
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildListProducts();
  }
}