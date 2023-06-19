import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:horeca_project/presentation/category_screen.dart';

class ScaffoldWithNavBar extends StatefulWidget {
  String location;
  ScaffoldWithNavBar({super.key, required this.child, required this.location});

  final Widget child;

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  int _currentIndex = 0;

  static const List<MyCustomBottomNavBarItem> tabs = [
    MyCustomBottomNavBarItem(icon: Icon(Icons.home), label: 'Главная', initialLocation: '/'),
    MyCustomBottomNavBarItem(icon: Icon(Icons.search), label: 'Поиск', initialLocation: '/search'),
    MyCustomBottomNavBarItem(icon: Icon(Icons.shopping_cart), label: 'Корзина', initialLocation: '/cart'),
    MyCustomBottomNavBarItem(icon: Icon(Icons.account_circle), label: 'Аккаунт', initialLocation: '/account'),
  ];

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(fontFamily: 'Roboto');
    return Scaffold(
      body: SafeArea(child: widget.child),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: labelStyle,
        unselectedLabelStyle: labelStyle,
        selectedItemColor: const Color(0xFF434343),
        selectedFontSize: 12,
        unselectedItemColor: const Color(0xFF838383),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          _goOtherTab(context, index);
        },
        currentIndex: widget.location == '/'
          ? 0
          : widget.location == '/search'
          ? 1
          : widget.location == '/cart'
          ? 2
          : widget.location == '/account'
          ? 3
          : 0,
        items: tabs,
      ),
    );
  }

  void _goOtherTab(BuildContext context, int index) {
    if (index == _currentIndex) return;
    GoRouter router = GoRouter.of(context);
    String location = tabs[index].initialLocation;

    setState(() {
      _currentIndex = index;
    });
    router.go(location);
  }
}

class MyCustomBottomNavBarItem extends BottomNavigationBarItem {
  final String initialLocation;

  const MyCustomBottomNavBarItem(
      {required this.initialLocation,
        required Widget icon,
        String? label,
        Widget? activeIcon})
      : super(icon: icon, label: label);
}