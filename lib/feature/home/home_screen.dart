import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../flavors/flavor_values.dart';
import '../../generated/locale_keys.g.dart';
import 'home_controller.dart';
class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final moviesList = ref.watch(fetchMoviesProvider);
        return Scaffold(
      appBar: AppBar(title: Text(FlavorValues.fromEnvironment().title)),

              body: Center(child: Text(LocaleKeys.homePageTitle).tr())

    );
  }
}