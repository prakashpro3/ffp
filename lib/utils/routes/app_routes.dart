import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fpp/view/drawer_screen.dart';
import 'package:fpp/view/error_screen.dart';
import 'package:fpp/view/home_page.dart';
import 'package:fpp/view/home_screen.dart';
import 'package:fpp/view/login_view.dart';
import 'package:fpp/view/signup_view.dart';
import 'package:go_router/go_router.dart';

import '../../model/user_model.dart';
import '../../view/contact_us_screen.dart';
import '../../view/tab_bar_screen.dart';
import '../../view/splash_view.dart';
import '../../view_model/user_view_model.dart';

class AppRouter {
  // all the route paths. So that we can access them easily across the app
  static const root = '/';
  static const splash = '/splash';
  static const login = '/login';
  static const signup = '/signup';
  static const home = '/home';
  static const contactUs = '/contactUs';
  static const drawerScreen = '/drawerScreen';
  static const drawerWithMultiScreen = '/drawerWithMultiScreen';
  static const listView = '/listView';

  // static const contactUsScreenWithParams = '/contactUs/:name';
  /// get route name with parameters, here [name] is optional because we need [:name] to define path on [_contactUsScreenRouteBuilder]
  static contactUsScreenWithParams([String? name]) => '$contactUs/${name ?? ':name'}';

  /// private static methods that are accessible only in this class and not from outside
  static Widget _splashScreenRouteBuilder(
          BuildContext context, GoRouterState state) =>
      const SplashView();

  static Widget _loginScreenRouteBuilder(
      BuildContext context, GoRouterState state) =>
      const LoginView();

  static Widget _signupScreenRouteBuilder(
      BuildContext context, GoRouterState state) =>
      const SignUpView();

  static Widget _homeScreenRouteBuilder(
      BuildContext context, GoRouterState state) =>
      HomeScreen(userData: state.extra as String?);

  static Widget _contactUsScreenRouteBuilder(
      BuildContext context, GoRouterState state) =>
      ContactUsScreen(name: state.params["name"]!);

  static Widget errorWidget(BuildContext context, GoRouterState state) =>
      const ErrorScreen(error: "Error Screen");

  static Widget _drawerScreenRouteBuilder(BuildContext context, GoRouterState state) =>
      const DrawerScreen();

  static Widget _drawerWithMultiScreenRouteBuilder(BuildContext context, GoRouterState state) =>
      HomePage();

  static listViewScreen([CurrentTab? type]) => '$listView/${type?.name ?? ':type'}';
  // listView with different type of screen to build accoring to [CurrentTab]
  static Widget _listVieScreenRouteBuilder(BuildContext context, GoRouterState state) =>
      TabBarScreen(initTab: state.params['type']! == CurrentTab.error.name ? CurrentTab.error : CurrentTab.contactus);

  /// use this in [MaterialApp.router]
  static final GoRouter _router = GoRouter(
    initialLocation: root,
    routes: <GoRoute>[
      GoRoute(path: root, builder: _splashScreenRouteBuilder),
      GoRoute(path: login, builder: _loginScreenRouteBuilder),
      GoRoute(path: signup, builder: _signupScreenRouteBuilder),
      GoRoute(path: home, builder: _homeScreenRouteBuilder),
      GoRoute(path: contactUsScreenWithParams(), builder: _contactUsScreenRouteBuilder),
      GoRoute(path: listViewScreen(), builder: _listVieScreenRouteBuilder),
      GoRoute(path: drawerScreen, builder: _drawerScreenRouteBuilder),
      GoRoute(path: drawerWithMultiScreen, builder: _drawerWithMultiScreenRouteBuilder),
    ],
    errorBuilder: errorWidget,
  );

  static GoRouter get router => _router;
}
