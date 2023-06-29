import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:horeca_project/presentation/cart.dart';
import 'package:horeca_project/presentation/category_screen.dart';
import 'package:horeca_project/presentation/home.dart';
import 'package:horeca_project/scaffold_with_bottom_bar.dart';
import 'package:intl/intl.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

PreferredSizeWidget _buildAppBar() {
  final date = DateFormat('d MMMM, y', 'ru_RU').format(DateTime.now()).toString();
  return AppBar(
    shadowColor: Colors.transparent,
    backgroundColor: Colors.white,
    title: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            color: Colors.black,
          ),
          const SizedBox(width: 5.0,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Санкт-Петербург',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
              Text(
                date,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          const Spacer(),
          Image.asset('assets/user_pic.png', filterQuality: FilterQuality.high,),
        ]
    ),
  );
}

class AppRouter {
  static final GoRouter appRouter =
    GoRouter(initialLocation: '/', navigatorKey: _rootNavigatorKey, routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        pageBuilder: (context, state, child) {
          return NoTransitionPage(
            child: ScaffoldWithNavBar(
              location: state.location,
              child: child,
            )
          );
        },
        routes: [
          GoRoute(
            path: '/',
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: Scaffold(
                  appBar: _buildAppBar(),
                  body: const MainScreen(),
                ),
              );
            },
            routes: [
              GoRoute(
                  path: 'category/:id',
                  name: 'category',
                  parentNavigatorKey: _shellNavigatorKey,
                  builder: (BuildContext context, GoRouterState state) {
                    String? categoryName = state.queryParameters['categoryName'];
                    return CategoryScreen(
                      categoryName: categoryName,
                    );
                  }),
            ],
          ),
          GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: '/search',
              name: 'search',
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: Scaffold(
                    appBar: _buildAppBar(),
                    body: const Center(child: Text("Поиск")),
                  ),
                );
              }),
          GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: '/cart',
              name: 'cart',
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: Scaffold(
                    appBar: _buildAppBar(),
                    body: const CartScreen(),
                  ),
                );
              }),
          GoRoute(
              parentNavigatorKey: _shellNavigatorKey,
              path: '/account',
              name: 'account',
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: Scaffold(
                    appBar: _buildAppBar(),
                    body: const Center(child: Text("Аккаунт")),
                  ),
                );
              }),
        ],
      )
    ]
  );
}
