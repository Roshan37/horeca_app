import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:horeca_project/bloc/catalog/categories_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  Widget _buildListCategories() {
    return Container(
      margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
      child: BlocProvider(
        create: (context) => CategoriesBloc()..add(GetCategories()),
        child: BlocListener<CategoriesBloc, CategoriesState>(
          listener: (context, state) {
            if(state is CategoriesError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                )
              );
            }
          },
          child: BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, state){
              if(state is CategoriesInitial) {
                return _buildLoading();
              } else if(state is CategoriesLoading) {
                return _buildLoading();
              } else if(state is CategoriesLoaded) {
                return _buildCard(context, state);
              } else if(state is CategoriesError) {
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
      physics: const NeverScrollableScrollPhysics(),
      itemCount: model.categoriesList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            context.goNamed(
              'category',
              pathParameters: {'id': model.categoriesList[index].id.toString()},
              queryParameters: {'categoryName': model.categoriesList[index].name},
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            height: MediaQuery.of(context).size.height/4-47,
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