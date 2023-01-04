import 'package:flutter/material.dart';
import 'package:fpp/respository/app_setting_repository.dart';
import 'package:fpp/utils/routes/routes.dart';
import 'package:fpp/utils/routes/routes_name.dart';
import 'package:fpp/view_model/app_setting_view_model.dart';
import 'package:fpp/view_model/auth_view_model.dart';
import 'package:fpp/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() {
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
      ChangeNotifierProvider(create: (_) => AppSettingsViewModel())
    ],
      child: MaterialApp(
        onGenerateRoute: Routes.generateRoute,
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
        initialRoute: RoutesName.splash,
      ),);
  }
}