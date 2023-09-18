import 'package:base_riverpod/feature/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../flavors/flavor_values.dart';
import 'home_controller.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homePageStateProvider.notifier).fetchData();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    HomeState data = ref.watch(homePageStateProvider);
    return Scaffold(
        appBar: AppBar(title: Text(FlavorValues.fromEnvironment().title)),
        body: data.status == PageStatus.loading
            ? const Center(child: CircularProgressIndicator())
            : data.status == PageStatus.failure
                ? const Center(child: Text("Error"))
                : data.status == PageStatus.success
                    ? Column(
          children: [
            RadioListTile(title: Text("ASC") ,value: FilterItem.asc, groupValue: data.filter, onChanged: (value) {
              ref.read(homePageStateProvider.notifier).sortByAsc();
            },),
            RadioListTile(title:  Text("DESC"), value: FilterItem.desc, groupValue: data.filter, onChanged: (value) {
              // ref.read(localeProvider.notifier).setLocale("vi-VN");
              ref.read(homePageStateProvider.notifier).sortByDesc();
            },),
            Expanded(child: ListView.builder(itemBuilder: (context, index) {
              return ListTile(title: Text(data.movies[index].title), );
            },itemCount: data.movies.length, itemExtent: 50,)),
            const SizedBox(height: 10,)
          ],
        )
                    : Container());
  }
}
