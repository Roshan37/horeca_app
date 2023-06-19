import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:horeca_project/presentation/category_screen.dart';
import 'package:horeca_project/presentation/home.dart';
import 'package:horeca_project/scaffold_with_bottom_bar.dart';

import 'main.dart';

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
          print(state.location);
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
              return const NoTransitionPage(
                child: Scaffold(
                  body: Center(child: Text("Main")),
                ),
              );
            },
            routes: [
              GoRoute(
                path: '${CategoryScreen.routeName}',
                builder: (BuildContext context, GoRouterState state) {
                  return CategoryScreen();
                }
              ),
            ],
          ),
          // GoRoute(
          //   path: '/',
          //   builder: (BuildContext context, GoRouterState state) {
          //     return const MainScreen();
          //   }),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/search',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: Scaffold(
                  body: Center(child: Text("Поиск")),
                ),
              );
            }
          ),GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/cart',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: Scaffold(
                  body: Center(child: Text("Корзина")),
                ),
              );
            }
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/account',
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: Scaffold(
                  body: Center(child: Text("Аккаунт")),
                ),
              );
            }
          ),
        ],
    )
  ]);
}