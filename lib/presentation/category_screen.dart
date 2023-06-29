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
              } else if(state is ProductsFiltered) {
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
    final Set<String> tags = model.tags;
    final unfilteredList = model.productsList;
    final productsList = model is ProductsFiltered ? model.filteredList : model.productsList;
    final int selectedTagIndex = model.selectedTagIndex;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height*1.05,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10.0, 15.0, 0.0, 10.0),
              height: 37,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                clipBehavior: Clip.none,
                scrollDirection: Axis.horizontal,
                itemCount: tags.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.5,
                        backgroundColor: index == selectedTagIndex ? Colors.blue : const Color(0xFFEEEEEE),
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: (){
                        BlocProvider.of<ProductsBloc>(context).add(FilterProducts(unfilteredList, tags.elementAt(index), tags));
                      },
                      child: Text(
                        tags.elementAt(index),
                        style: TextStyle(color: index == selectedTagIndex ? Colors.white : Colors.black54),
                      )
                    ),
                  );
                }
              ),
            ),
            Expanded(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(10.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 210,
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                ),
                itemCount:  productsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return ProductScreen(product: productsList[index]);
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
                            productsList[index].image,
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
                            productsList[index].name,
                            style: const TextStyle(
                              fontSize: 16,
                            )
                        ),
                      ],
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildListProducts();
  }
}