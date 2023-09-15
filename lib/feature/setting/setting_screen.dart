import 'package:base_riverpod/generated/locale_keys.g.dart';
import 'package:base_riverpod/providers/locale_provider.dart';
import 'package:base_riverpod/providers/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../flavors/flavor_values.dart';

class SettingScreen extends HookConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final theme = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(FlavorValues.fromEnvironment().title),
      ),
      body: Column(
        children: [
          RadioListTile(title: Text(LocaleKeys.searchPageTitle).tr(),value: "en", groupValue: locale, onChanged: (value) {
            context.setLocale(Locale("en"));
            ref.read(localeProvider.notifier).setLocale("en");
          },),
          RadioListTile(title: Text(LocaleKeys.forecast).tr(), value: "vi", groupValue: locale, onChanged: (value) {
            // ref.read(localeProvider.notifier).setLocale("vi-VN");
            ref.read(localeProvider.notifier).setLocale("vi");
            context.setLocale(Locale("vi"));
          },),

          RadioListTile(title: Text("Theme System") ,value: ThemeStatus.system, groupValue: theme, onChanged: (value) {
            ref.read(themeProvider.notifier).setTheme(ThemeStatus.system);
          },),
          RadioListTile(title:  Text("Theme Dart"), value: ThemeStatus.dark, groupValue: theme, onChanged: (value) {
            // ref.read(localeProvider.notifier).setLocale("vi-VN");
            ref.read(themeProvider.notifier).setTheme(ThemeStatus.dark);

          },),
          RadioListTile(title:  Text("Theme Light"), value: ThemeStatus.light, groupValue: theme, onChanged: (value) {
            // ref.read(localeProvider.notifier).setLocale("vi-VN");
            ref.read(themeProvider.notifier).setTheme(ThemeStatus.light);

          },),
        ],
      ),
    );
  }

}