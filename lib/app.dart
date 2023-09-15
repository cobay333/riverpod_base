import 'package:base_riverpod/generated/codegen_loader.g.dart';
import 'package:base_riverpod/providers/locale_provider.dart';
import 'package:base_riverpod/providers/theme_provider.dart';
import 'package:base_riverpod/route/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

void startApp() async {
  await initialiseApp();
  runApp(EasyLocalization(
      supportedLocales: const [Locale("en"), Locale("vi")],
      path: "assets/translations",
      fallbackLocale: const Locale("en"),
      useOnlyLangCode: true,
      assetLoader: const CodegenLoader(),
      child: const ProviderScope( child : MyApp(),
    )),
  );
}

@visibleForTesting
Future initialiseApp({bool test = false}) async {
  WidgetsFlutterBinding.ensureInitialized();
  EasyLocalization.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  GetIt.I.registerSingleton<SharedPreferences>(prefs);
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
            ThemeStatus theme = ref.watch(themeProvider);
            String locale = ref.watch(localeProvider);
            final goRouter = ref.watch(goRouterProvider);
            return MaterialApp.router(
              onGenerateTitle: (_) => 'appName'.tr(),
              debugShowCheckedModeBanner: false,
              routerConfig: goRouter,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: locale.toLocale(),
              theme: ThemeData.light(useMaterial3: true),
              darkTheme: ThemeData.dark(useMaterial3: true),
              themeMode: ThemeStatus.toThemeMode(theme: theme),
            );
  }
}
