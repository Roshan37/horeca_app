import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:horeca_project/bloc/catalog_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  final CatalogBloc _catalogBloc = CatalogBloc();

  @override
  void initState(){
    _catalogBloc.add(GetCatalog());
    super.initState();
  }

  Widget _buildListCategories() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (context) => _catalogBloc,
        child: BlocListener<CatalogBloc, CatalogState>(
          listener: (context, state) {
            if(state is CatalogError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                )
              );
            }
          },
          child: BlocBuilder<CatalogBloc, CatalogState>(
            builder: (context, state){
              if(state is CatalogInitial) {
                return _buildLoading();
              } else if(state is CatalogLoading) {
                return _buildLoading();
              } else if(state is CatalogLoaded) {
                return _buildCard(context, state);
              } else if(state is CatalogError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      )
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  Widget _buildCard(BuildContext context, model){
    return ListView.builder(
      itemCount: model.categoriesList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            context.goNamed(
              'category',
              pathParameters: {'id': model.categoriesList[index].id.toString()},
              queryParameters: {'categoryName': model.categoriesList[index].name},
              extra: model.productsList
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 3.0),
            height: 150,
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: NetworkImage(model.categoriesList[index].image),
                fit: BoxFit.fill,
                alignment: Alignment.topCenter,
              ),
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 15.0, 70.0, 0.0),
                child: Text(
                  model.categoriesList[index].name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  )
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildListCategories();
  }
}