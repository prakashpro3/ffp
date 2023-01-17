import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fpp/respository/app_setting_repository.dart';
import 'package:fpp/utils/routes/app_routes.dart';
import 'package:fpp/utils/routes/routes.dart';
import 'package:fpp/utils/routes/routes_name.dart';
import 'package:fpp/view/contact_us_screen.dart';
import 'package:fpp/view/error_screen.dart';
import 'package:fpp/view/home_screen.dart';
import 'package:fpp/view/tab_bar_screen.dart';
import 'package:fpp/view/splash_view.dart';
import 'package:fpp/view_model/app_setting_view_model.dart';
import 'package:fpp/view_model/auth_view_model.dart';
import 'package:fpp/view_model/drawer_view_model.dart';
import 'package:fpp/view_model/user_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() {
  /*WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);*/
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocal(BuildContext context, Locale locale){
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocal(locale);
  }
}

class _MyAppState extends State<MyApp> {

  Locale? _locale;

  setLocal(Locale locale){
    Utils.setLog("AppLanguage", "_MyAppState - code- "+locale.languageCode);
    setState(() {
      _locale = locale;
    });
  }
  final appSettingsRepository = AppSettingsRepository();
  @override
  void didChangeDependencies() {
    appSettingsRepository.getLocal().then((locale) => setLocal(locale));
    super.didChangeDependencies();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ChangeNotifierProvider(create: (_) => UserViewModel()),
      ChangeNotifierProvider(create: (_) => AppSettingsViewModel()),
      ChangeNotifierProvider(create: (_) => DrawerViewModel())
    ],
      child: MaterialApp.router(
        onGenerateTitle: (BuildContext context){
          return AppLocalizations.of(context)!.login;
        },
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: _locale,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: AppRouter.router,
        /*onGenerateRoute: Routes.generateRoute,
        initialRoute: RoutesName.splash,*/
      ),);
  }

  /*final GoRouter router = GoRouter(
      routes: [
        GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) =>
                const SplashView()),
        GoRoute(
            path: '/home',
            builder: (BuildContext context, GoRouterState state) =>
                HomeScreen(userData: state.extra as String)),
        GoRoute(
            path: '/contactUs/:name',
            builder: (BuildContext context, GoRouterState state) =>
                ContactUsScreen(name: state.params["name"]!)),
        GoRoute(
            path: '/listview',
            builder: (BuildContext context, GoRouterState state) =>
                const ListViewScreen())
      ],
      errorBuilder: (BuildContext context, GoRouterSate) => const ErrorScreen(),
      errorPageBuilder: (BuildContext context, GoRouterState state) =>
          const MaterialPage(child: ErrorScreen())
  );*/
}