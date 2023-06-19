import 'package:flutter/material.dart';
import 'package:horeca_project/presentation/home.dart';
import 'package:horeca_project/presentation/category_screen.dart';
import 'package:horeca_project/presentation/product_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        CategoryScreen.routeName: (context) => CategoryScreen(),
        '/search': (context) => SearchPage(),
      },
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