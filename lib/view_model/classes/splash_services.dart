import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fpp/utils/routes/app_routes.dart';
import 'package:go_router/go_router.dart';

import '../../model/user_model.dart';
import '../../utils/routes/routes_name.dart';
import '../user_view_model.dart';

class SplashServices {


  Future<UserModel> getUserDate() => UserViewModel().getUser();


  void checkAuthentication(BuildContext context)async{

    getUserDate().then((value)async{

      print(value.token.toString());

      if(value.token.toString() == 'null' || value.token.toString() == ''){
        await Future.delayed(Duration(seconds: 3));
        //Navigator.pushNamed(context, RoutesName.login);
        GoRouter.of(context).go(AppRouter.login);
      }else {
        await  Future.delayed(Duration(seconds: 3));
        //Navigator.pushNamed(context, RoutesName.home);
        GoRouter.of(context).go('/home', extra: 'Pro');
      }

    }).onError((error, stackTrace){
      if(kDebugMode){
        print(error.toString());
      }
    });

  }



}