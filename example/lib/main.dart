import 'package:flutter/material.dart';
import 'package:scaffold_factory_example/sample/sample_app_bar.dart';
import 'package:scaffold_factory_example/sample/sample_bottom_navigation_bar.dart';
import 'package:scaffold_factory_example/sample/sample_catalog.dart';
import 'package:scaffold_factory_example/sample/sample_floating_action_button.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scaffold Factory Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      routes: routes,
    );
  }
}

final routes = {
  '/': (BuildContext context) => new SampleCatalog(),
  '/appBar': (BuildContext context) => new SampleAppBar(),
  '/floatingActionButton': (BuildContext context) =>
      new SampleFloatingActionButton(),
  '/bottomNavigationBar': (BuildContext context) =>
      new SampleBottomNavigationBar(),
};
