import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fpp/respository/app_setting_repository.dart';

import '../utils/utils.dart';

class AppSettingsViewModel with ChangeNotifier {
  final appSettingsRepository = AppSettingsRepository();

  Future<Locale> setAppLanguage(String languageCode) async {
    Locale locale = await appSettingsRepository.setLocal(languageCode);
    return locale;
  }

  Future<Locale> getAppLanguage() async{
    Utils.setLog("AppLanguage", "getAppLanguage called");
    Locale appLanguage = await appSettingsRepository.getLocal();
    Utils.setLog("AppLanguage", "getAppLanguage End - appLanguage- ${appLanguage.languageCode}");
    return appLanguage;
  }
}
