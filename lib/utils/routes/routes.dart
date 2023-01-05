import 'package:flutter/material.dart';
import 'package:fpp/utils/routes/routes_name.dart';
import 'package:fpp/view/drawer_screen.dart';
import 'package:fpp/view/home_page.dart';

import '../../view/home_screen.dart';
import '../../view/login_view.dart';
import '../../view/signup_view.dart';
import '../../view/splash_view.dart';

class Routes {

  static Route<dynamic>  generateRoute(RouteSettings settings){

    switch(settings.name){
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context) => const SplashView());

      case RoutesName.home:
        //return MaterialPageRoute(builder: (BuildContext context) => const HomeScreen());

      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => const LoginView());
      case RoutesName.signUp:
        return MaterialPageRoute(builder: (BuildContext context) => const SignUpView());
      case RoutesName.drawerScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const DrawerScreen());
      case RoutesName.homePage:
        return MaterialPageRoute(builder: (BuildContext context) => HomePage());

      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });

    }
  }
}