import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:horeca_project/presentation/cart.dart';
import 'package:horeca_project/presentation/category_screen.dart';
import 'package:horeca_project/presentation/home.dart';
import 'package:horeca_project/scaffold_with_bottom_bar.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final GoRouter appRouter = GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    routes: [
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
                  appBar: AppBar(
                    title: const Text('Главная'),
                  ),
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
                  return CategoryScreen(categoryName: categoryName,);
                }
              ),
            ],
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/search',
            name: 'search',
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text('Поиск'),
                  ),
                  body: const Center(child: Text("Поиск")),
                ),
              );
            }
          ),GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/cart',
            name: 'cart',
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text('Корзина'),
                  ),
                  body: const CartScreen(),
                ),
              );
            }
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/account',
            name: 'account',
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text('Аккаунт'),
                  ),
                  body: const Center(child: Text("Аккаунт")),
                ),
              );
            }
          ),
        ],
    )
  ]);
}