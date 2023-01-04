import 'package:flutter/material.dart';
import 'package:fpp/res/constants.dart';
import 'package:fpp/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsRepository{
  Future<Locale> setLocal(String languageCode)async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(languageCodeKey, languageCode);
    return _locale(languageCode);
  }

  Future<Locale> getLocal()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    String languageCode = sp.getString(languageCodeKey) ?? english;
    return _locale(languageCode);
  }

  Locale _locale(String languageCode){
    switch(languageCode){
      case english:
        return Locale(english, 'US');
      case hindi:
        return Locale(hindi, 'IN');
      default:
        return Locale(english, 'US');
    }
  }
}