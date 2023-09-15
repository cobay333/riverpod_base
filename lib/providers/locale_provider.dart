import 'dart:io';

import 'package:base_riverpod/constants/Constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, String>((ref) {
  final pref = GetIt.I.get<SharedPreferences>();
  String initialLocale = pref.getString(Constants.preLanguage)?? Platform.localeName.split("_")[0];

  return LocaleNotifier(
    pref,
    initialLocale: initialLocale,
  );
});

class LocaleNotifier extends StateNotifier<String> {
  LocaleNotifier(
      this.pref, {
        required String initialLocale,
      }) : super(initialLocale);

  final SharedPreferences pref;

  /// Get current locale
  String get language => state;

  /// Change locale in state and store it in the local storage
  void setLocale(String localeCode) {
    pref.setString(Constants.preLanguage, localeCode);
    state = localeCode;
  }
}