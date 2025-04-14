import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const String LanguageCode = 'languageCode';

//languages code
const String English = 'en';
const String Russian = 'ru';
const String Kyrgiz = 'ky';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LanguageCode, languageCode);
  return _locale(languageCode);
}


Future<Locale> getLocale() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? languageCode = prefs.getString(LanguageCode);

  if (languageCode == null) {
    return const Locale(Kyrgiz);
  }

  return Locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case English:
      return const Locale(English, "");
    case Russian:
      return const Locale(Russian, "");
    case Kyrgiz:
      return const Locale(Kyrgiz, "");
    default:
      return const Locale(English, "");
  }
}

AppLocalizations translation(BuildContext context) {
  return AppLocalizations.of(context)!;
}