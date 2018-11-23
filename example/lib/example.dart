import 'package:flutter/material.dart';
import 'package:scaffold_factory/scaffold_factory.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scaffold Factory Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: ExampleScaffoldFactory(),
    );
  }
}

class ExampleScaffoldFactory extends StatefulWidget {
  @override
  _ExampleScaffoldFactoryState createState() => _ExampleScaffoldFactoryState();
}

class _ExampleScaffoldFactoryState extends State<ExampleScaffoldFactory>
    implements ScaffoldFactoryBehaviors {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScaffoldFactory _scaffoldFactory;
  MaterialPalette _sampleColorPalette = MaterialPalette(
    primaryColor: Colors.teal,
    accentColor: Colors.pinkAccent,
  );

  @override
  void initState() {
    super.initState();
    _initScaffoldFactory();
  }

  @override
  Widget build(BuildContext context) {
    _scaffoldFactory.textTheme = Theme.of(context).textTheme;

    return _scaffoldFactory.build(_buildBody(context));
  }

  void _initScaffoldFactory() {
    _scaffoldFactory = ScaffoldFactory(
      scaffoldKey: _scaffoldKey,
      materialPalette: _sampleColorPalette,
    );
    _scaffoldFactory.scaffoldFactoryBehavior = this;

    _scaffoldFactory.init(
      backgroundType: BackgroundType.normal,
      appBarVisibility: true,
      floatingActionButtonVisibility: true,
      drawerVisibility: false,
      nestedAppBarVisibility: false,
      bottomNavigationBarVisibility: false,
      appBar: _scaffoldFactory.buildAppBar(
        titleVisibility: true,
        leadingVisibility: false,
        tabBarVisibility: false,
        titleWidget: Text('Scaffol Factory Example'),
        backgroundColor: _scaffoldFactory.colorPalette.primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _scaffoldFactory.buildFloatingActionButton(
        fabBody: Icon(
          Icons.link,
          color: Colors.white,
        ),
        tooltip: "Scaffold Factory Repository",
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: MaterialButton(
        onPressed: () {
          _scaffoldFactory.showSnackBar(
            messageType: SnackBarMessageType.info,
            iconVisibility: false,
            duration: Duration(seconds: 5),
            message:
                "You can visit a sample catalog of other interface implementation using scaffold factory with running main.dart file",
          );
        },
        child: Text(
          'Sample Button',
          style:
              _scaffoldFactory.textTheme.button.copyWith(color: Colors.white),
        ),
        color: _scaffoldFactory.colorPalette.accentColor,
      ),
    );
  }

  @override
  void onBackButtonPressed() {
    print("Scaffold Factory => onBackButtonPressed()");
    Navigator.of(_scaffoldKey.currentContext).pop();
  }

  @override
  void onFloatingActionButtonPressed() {
    print("Scaffold Factory => onFloatingActionButtonPressed()");
    _scaffoldFactory
        .launchURL("https://github.com/erfanjazebnikoo/scaffold_factory");
  }

  @override
  Future onEventBusMessageReceived(event) async {
    print("ScaffoldFactory: Event Received");
  }
}
