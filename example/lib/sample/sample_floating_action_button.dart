import 'package:flutter/material.dart';
import 'package:scaffold_factory/scaffold_factory.dart';

class SampleFloatingActionButton extends StatefulWidget {
  @override
  _SampleFloatingActionButtonState createState() =>
      _SampleFloatingActionButtonState();
}

class _SampleFloatingActionButtonState extends State<SampleFloatingActionButton>
    implements ScaffoldFactoryBehaviors {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScaffoldFactory _scaffoldFactory;
  MaterialPalette _sampleColorPalette = MaterialPalette(
    primaryColor: Colors.teal,
    accentColor: Colors.redAccent,
  );
  static bool _fabCenterSwitch;
  static bool _fabFloatingSwitch;

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
      appBar: _scaffoldFactory.buildAppBar(
        titleVisibility: true,
        leadingVisibility: true,
        tabBarVisibility: false,
        titleWidget: const Text('FAB Configuration'),
        leadingWidget: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => this.onBackButtonPressed(),
        ),
        backgroundColor: _sampleColorPalette.primaryColor,
      ),
      floatingActionButtonVisibility: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _scaffoldFactory.buildFloatingActionButton(
        fabBody: Icon(
          Icons.add,
          color: Colors.white,
        ),
        tooltip: "Scaffold Factory Repository",
      ),
      bottomNavigationBarVisibility: false,
      nestedAppBarVisibility: false,
      drawerVisibility: false,
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_scaffoldFactory.fabLocation ==
            FloatingActionButtonLocation.centerDocked ||
        _scaffoldFactory.fabLocation ==
            FloatingActionButtonLocation.centerFloat) {
      _fabCenterSwitch = true;
    } else {
      _fabCenterSwitch = false;
    }
    if (_scaffoldFactory.fabLocation == FloatingActionButtonLocation.endFloat ||
        _scaffoldFactory.fabLocation ==
            FloatingActionButtonLocation.centerFloat) {
      _fabFloatingSwitch = true;
    } else {
      _fabFloatingSwitch = false;
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: <Widget>[
          SwitchListTile(
            value: _scaffoldFactory.floatingActionButtonVisibility,
            onChanged: (bool value) {
              setState(() {
                _scaffoldFactory.floatingActionButtonVisibility = value;
                _scaffoldFactory.floatingActionButtonVisibility = value;
              });
            },
            activeColor: _scaffoldFactory.colorPalette.accentColor,
            title: Text('Floating Action Button'),
            subtitle: Text('Change floating action button visibility'),
          ),
          SwitchListTile(
            value: _scaffoldFactory.floatingActionButtonVisibility
                ? _fabCenterSwitch
                : false,
            onChanged: _scaffoldFactory.floatingActionButtonVisibility
                ? (bool value) {
                    setState(() {
                      _scaffoldFactory.fabLocation = value
                          ? _fabFloatingSwitch
                              ? FloatingActionButtonLocation.centerFloat
                              : FloatingActionButtonLocation.centerDocked
                          : _fabFloatingSwitch
                              ? FloatingActionButtonLocation.endFloat
                              : FloatingActionButtonLocation.endDocked;
                      _fabCenterSwitch = value;
                    });
                  }
                : null,
            activeColor: _scaffoldFactory.colorPalette.accentColor,
            title: Text('Center'),
            subtitle: Text('Switch between center and end location'),
          ),
          SwitchListTile(
            value: _scaffoldFactory.floatingActionButtonVisibility
                ? _fabFloatingSwitch
                : false,
            onChanged: _scaffoldFactory.floatingActionButtonVisibility
                ? (bool value) {
                    setState(() {
                      _scaffoldFactory.fabLocation = value
                          ? _fabCenterSwitch
                              ? FloatingActionButtonLocation.centerFloat
                              : FloatingActionButtonLocation.endFloat
                          : _fabCenterSwitch
                              ? FloatingActionButtonLocation.centerDocked
                              : FloatingActionButtonLocation.endDocked;
                      _fabFloatingSwitch = value;
                    });
                  }
                : null,
            activeColor: _scaffoldFactory.colorPalette.accentColor,
            title: Text('Floating'),
            subtitle: Text('Switch between floating and docked'),
          ),
        ],
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
    _scaffoldFactory.showSnackBar(
        messageType: SnackBarMessageType.none,
        iconVisibility: false,
        message: "Floating action button pressed");
  }

  @override
  Future onEventBusMessageReceived(event) async {
    print("ScaffoldFactory: Event Received");
  }
}
