import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:horeca_project/presentation/home.dart';
import 'package:horeca_project/presentation/category_screen.dart';
import 'package:horeca_project/presentation/product_screen.dart';

import 'app_router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => MainScreen(),
      //   CategoryScreen.routeName: (context) => CategoryScreen(),
      //   '/search': (context) => SearchPage(),
      // },
      routerConfig: AppRouter.appRouter,
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Search Page'),
    );
  }
}