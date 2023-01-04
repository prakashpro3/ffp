import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const String languageCodeKey = 'languageCodeKey';

//Language codes
  const String english = 'en';
  const String hindi = 'hi';


  AppLocalizations localise(BuildContext context){
    return AppLocalizations.of(context)!;
  }