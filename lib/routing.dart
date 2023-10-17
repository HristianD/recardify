import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recardify/homepage.dart';
import 'package:recardify/create-idea.dart';
import 'package:recardify/navigation.dart';

class CustomNavigationHelper {
  static final CustomNavigationHelper _instance =
  CustomNavigationHelper._internal();

  static CustomNavigationHelper get instance => _instance;

  static late final GoRouter router;

  static final GlobalKey<NavigatorState> parentNavigatorKey =
  GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> homeTabNavigatorKey =
  GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> createIdeaTabNavigatorKey =
  GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> settingsTabNavigatorKey =
  GlobalKey<NavigatorState>();
  static final GlobalKey<NavigatorState> languageTabNavigatorKey =
  GlobalKey<NavigatorState>();

  BuildContext get context =>
      router.routerDelegate.navigatorKey.currentContext!;

  GoRouterDelegate get routerDelegate => router.routerDelegate;

  GoRouteInformationParser get routeInformationParser =>
      router.routeInformationParser;

  static const String homePath = '/home';
  static const String settingsPath = '/settings';
  static const String createPath = '/create';
  static const String languagePath = '/language';
  // viewPath?

  factory CustomNavigationHelper() {
    return _instance;
  }

  CustomNavigationHelper._internal() {
    final routes = [
      StatefulShellRoute.indexedStack(
        parentNavigatorKey: parentNavigatorKey,
        branches: [
          StatefulShellBranch(
            navigatorKey: homeTabNavigatorKey,
            routes: [
              GoRoute(
                path: homePath,
                pageBuilder: (context, GoRouterState state) {
                  return getPage(
                    child: const MyHomePage(),
                    state: state
                  );
                }
              )
            ]
          ),
          StatefulShellBranch(
            navigatorKey: createIdeaTabNavigatorKey,
            routes: [
              GoRoute(
                path: createPath,
                pageBuilder: (context, state) {
                  return getPage(
                    child: const CreateIdea(),
                    state: state
                  );
                }
              )
            ]
          ),
          // StatefulShellBranch(
          //   navigatorKey: settingsTabNavigatorKey,
          //   routes: [
          //     GoRoute(
          //       path: settingsPath,
          //       pageBuilder: (context, state) {
          //         return getPage(
          //           child: const SettingsPage(),
          //           state: state,
          //         );
          //       },
          //     ),
          //   ],
          // ),
        ],
        pageBuilder: (
            BuildContext context,
            GoRouterState state,
            StatefulNavigationShell navigationShell
            ) {
          return getPage(
            child: BottomNavigationPage(
              child: navigationShell
            ),
            state: state
          );
        }
      ),
      // GoRoute(
      //   parentNavigatorKey: parentNavigatorKey,
      //   path: signUpPath,
      //   pageBuilder: (context, state) {
      //     return getPage(
      //       child: const SignUpPage(),
      //       state: state,
      //     );
      //   },
      // ),
      // GoRoute(
      //   parentNavigatorKey: parentNavigatorKey,
      //   path: signInPath,
      //   pageBuilder: (context, state) {
      //     return getPage(
      //       child: const SignInPage(),
      //       state: state,
      //     );
      //   },
      // ),
      // GoRoute(
      //   path: detailPath,
      //   pageBuilder: (context, state) {
      //     return getPage(
      //       child: const DetailPage(),
      //       state: state,
      //     );
      //   },
      // ),
      // GoRoute(
      //   parentNavigatorKey: parentNavigatorKey,
      //   path: rootDetailPath,
      //   pageBuilder: (context, state) {
      //     return getPage(
      //       child: const DetailPage(),
      //       state: state,
      //     );
      //   },
      // ),
    ];

    router = GoRouter(
      navigatorKey: parentNavigatorKey,
      initialLocation: homePath,
      routes: routes
    );
  }

  static Page getPage({
    required Widget child,
    required GoRouterState state
  }) {
    return MaterialPage(
      key: state.pageKey,
      child: child
    );
  }
}