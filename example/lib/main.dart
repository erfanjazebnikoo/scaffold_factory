import 'package:flutter/material.dart';
import 'package:scaffold_factory/scaffold_factory.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScaffoldFactory _scaffoldFactory;
  MaterialPalette _sampleColorPalette = MaterialPalette(
    primaryColor: Colors.orange,
    accentColor: Colors.deepOrange,
  );

  @override
  void initState() {
    super.initState();
    _initScaffoldFactory();
  }

  @override
  Widget build(BuildContext context) {
    _scaffoldFactory.textTheme = Theme.of(context).textTheme;

    return new MaterialApp(
      theme: ThemeData.light(),
      home: _scaffoldFactory.build(
        new Center(
          child: new Text('Test scaffold factory'),
        ),
      ),
    );

//    return new MaterialApp(
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: const Text('Scaffold Factory example app'),
//        ),
//        body: new Center(
//          child: new Text('Test scaffold factory'),
//        ),
//      ),
//    );
  }

  void _initScaffoldFactory() {
    _scaffoldFactory = ScaffoldFactory(
        _scaffoldKey, _sampleColorPalette, BackgroundType.normal);
  }
}
