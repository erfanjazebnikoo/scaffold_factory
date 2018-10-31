import 'package:flutter/material.dart';
import 'package:scaffold_factory/scaffold_factory.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp>
    implements ScaffoldFactoryButtonsBehavior {
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
    return new MaterialApp(
      theme: ThemeData.light(),
      home: _scaffoldFactory.build(
        context,
        new Center(
          child: new Text('Test scaffold factory'),
        ),
      ),
    );
  }

  void _initScaffoldFactory() {
    _scaffoldFactory = ScaffoldFactory(_scaffoldKey, _sampleColorPalette);
    _scaffoldFactory.buttonsBehavior = this;

    _scaffoldFactory.init(
      backgroundType: BackgroundType.normal,
      appBarVisibility: ScaffoldVisibility.visible,
      floatingActionButtonVisibility: ScaffoldVisibility.visible,
      floatingActionButtonBody: _scaffoldFactory.buildFloatingActionButton(
        fabBody: Icon(
          Icons.settings,
          size: 25.0,
          color: Colors.white,
        ),
      ),
      appBar: _scaffoldFactory.buildAppBar(
        titleVisibility: ScaffoldVisibility.visible,
        leadingVisibility: ScaffoldVisibility.invisible,
        titleWidget: const Text('Scaffold Factory example app'),
        leadingWidget: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => this.onBackButtonPressed(),
        ),
        backgroundColor: _sampleColorPalette.primaryColor,
      ),
    );
  }

  @override
  void onBackButtonPressed() => Navigator.of(_scaffoldKey.currentContext).pop();

  @override
  void onFloatingActionButtonPressed() {
    // TODO: implement onFloatingActionButtonPressed
  }
}
