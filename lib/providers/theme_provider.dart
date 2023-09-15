import 'dart:io';

import 'package:base_riverpod/constants/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
enum ThemeStatus {
  system,
  light,
  dark;
  
  static ThemeStatus fromString({required String? theme}) {
    switch (theme) {
      case "dark":
        return ThemeStatus.dark;
      case "light":
        return ThemeStatus.light;
      default:
        return ThemeStatus.system;
    }
  }

  static String fromThemStatus({required ThemeStatus theme}) {
    switch (theme) {
      case ThemeStatus.dark:
        return "dark";
      case ThemeStatus.light:
        return "light";
      default:
        return "system";
    }
  }

  static ThemeMode toThemeMode({required ThemeStatus theme}) {
    switch (theme) {
      case ThemeStatus.dark:
        return ThemeMode.dark;
      case ThemeStatus.light:
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeStatus>((ref) {
  final pref = GetIt.I.get<SharedPreferences>();
  String? initialTheme = pref.getString(Constants.preTheme);
  
  return ThemeNotifier(
    pref,
    initialTheme: 
    ThemeStatus.fromString(theme: initialTheme),
  );
});

class ThemeNotifier extends StateNotifier<ThemeStatus> {
  ThemeNotifier(
      this.pref, {
        required ThemeStatus initialTheme,
      }) : super(initialTheme);

  final SharedPreferences pref;

  /// Get current locale
  ThemeStatus get theme => state;

  /// Change locale in state and store it in the local storage
  void setTheme(ThemeStatus theme) {
    pref.setString(Constants.preTheme, ThemeStatus.fromThemStatus(theme: theme));
    state = theme;
  }
}