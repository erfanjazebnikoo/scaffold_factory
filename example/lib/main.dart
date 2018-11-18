import 'package:flutter/material.dart';

import 'sample/sample_app_bar.dart';
import 'sample/sample_bottom_app_bar.dart';
import 'sample/sample_bottom_navigation_bar.dart';
import 'sample/sample_catalog.dart';
import 'sample/sample_floating_action_button.dart';
import 'sample/sample_nested_app_bar.dart';
import 'sample/sample_snack_bar.dart';
import 'sample/sample_tab_bar.dart';

void main() => runApp(MyApp());

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
  '/': (BuildContext context) => SampleCatalog(),
  '/appBar': (BuildContext context) => SampleAppBar(),
  '/floatingActionButton': (BuildContext context) =>
      SampleFloatingActionButton(),
  '/bottomNavigationBar': (BuildContext context) => SampleBottomNavigationBar(),
  '/bottomAppBar': (BuildContext context) => SampleBottomAppBar(),
  '/nestedAppBar': (BuildContext context) => SampleNestedAppBar(),
  '/tabBar': (BuildContext context) => SampleTabBar(),
  '/snackBar': (BuildContext context) => SampleSnackBar(),
};
