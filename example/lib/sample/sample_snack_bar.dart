import 'package:flutter/material.dart';
import 'package:scaffold_factory/scaffold_factory.dart';

class SampleSnackBar extends StatefulWidget {
  @override
  _SampleSnackBarState createState() => _SampleSnackBarState();
}

class _SampleSnackBarState extends State<SampleSnackBar>
    implements ScaffoldFactoryBehaviors {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScaffoldFactory _scaffoldFactory;
  MaterialPalette _sampleColorPalette = MaterialPalette(
    primaryColor: Colors.pink,
    accentColor: Colors.tealAccent,
  );

//  static bool _appBarTitleSwitch;
//  static bool _appBarLeadingSwitch;
//  static bool _centerTitleSwitch;

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
      floatingActionButtonVisibility: false,
      appBar: _buildAppBar(),
      bottomNavigationBarVisibility: false,
      nestedAppBarVisibility: false,
      drawerVisibility: false,
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: <Widget>[
          //////////////////////////////////////////////////
          SwitchListTile(
            value: _scaffoldFactory.appBarVisibility,
            onChanged: (bool value) {
              setState(() {
                _scaffoldFactory.appBarVisibility = value;
              });
            },
            activeColor: _scaffoldFactory.colorPalette.accentColor,
            title: Text('App Bar'),
            subtitle: Text('Change app bar visibility'),
          ),
//          //////////////////////////////////////////// App Bar title visibility
//          SwitchListTile(
//            value:
//                _scaffoldFactory.appBarVisibility ? _appBarTitleSwitch : false,
//            onChanged: _scaffoldFactory.appBarVisibility
//                ? (bool value) {
//                    setState(() {
//                      _scaffoldFactory.appBar =
//                          _buildAppBar(titleVisibility: value);
//                      _appBarTitleSwitch = value;
//                    });
//                  }
//                : null,
//            activeColor: _scaffoldFactory.colorPalette.accentColor,
//            title: Text('Title'),
//            subtitle: Text('Change title visibility'),
//          ),
//          //////////////////////////////////////////// Center title visibility
//          SwitchListTile(
//            value: _scaffoldFactory.appBarVisibility && _appBarTitleSwitch
//                ? _centerTitleSwitch
//                : false,
//            onChanged: _scaffoldFactory.appBarVisibility && _appBarTitleSwitch
//                ? (bool value) {
//                    setState(() {
//                      _scaffoldFactory.appBar = _buildAppBar(
//                        centerTitle: value,
//                      );
//                      _centerTitleSwitch = value;
//                    });
//                  }
//                : null,
//            activeColor: _scaffoldFactory.colorPalette.accentColor,
//            title: Text('Center Title'),
//            subtitle: Text('Change title position to center'),
//          ),
//          ////////////////////////////////////////// App Bar leading visibility
//          SwitchListTile(
//            value: _scaffoldFactory.appBarVisibility
//                ? _appBarLeadingSwitch
//                : false,
//            onChanged: _scaffoldFactory.appBarVisibility
//                ? (bool value) {
//                    setState(() {
//                      _scaffoldFactory.appBar =
//                          _buildAppBar(leadingVisibility: value);
//                      _appBarLeadingSwitch = value;
//                    });
//                  }
//                : null,
//            activeColor: _scaffoldFactory.colorPalette.accentColor,
//            title: Text('Leading'),
//            subtitle: Text('Change leading widget visibility'),
//          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(
      {bool titleVisibility = true,
      bool leadingVisibility = true,
      bool centerTitle = false}) {
//    _appBarTitleSwitch = titleVisibility;
//    _centerTitleSwitch = centerTitle;
//    _appBarLeadingSwitch = leadingVisibility;

    return _scaffoldFactory.buildAppBar(
      titleVisibility: titleVisibility,
      leadingVisibility: leadingVisibility,
      tabBarVisibility: false,
      titleWidget: const Text('Snack Bar Configuration'),
      leadingWidget: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => this.onBackButtonPressed(),
      ),
      backgroundColor: _sampleColorPalette.primaryColor,
      centerTitle: centerTitle,
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
  }

  @override
  Future onEventBusMessageReceived(event) async {
    print("ScaffoldFactory: Event Received");
  }
}
