import 'package:flutter/material.dart';
import 'package:scaffold_factory/scaffold_factory.dart';

class SampleAppBar extends StatefulWidget {
  @override
  _SampleAppBarState createState() => new _SampleAppBarState();
}

class _SampleAppBarState extends State<SampleAppBar>
    implements ScaffoldFactoryButtonsBehavior {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScaffoldFactory _scaffoldFactory;
  MaterialPalette _sampleColorPalette = MaterialPalette(
    primaryColor: Colors.orange,
    accentColor: Colors.deepOrangeAccent,
  );

  static bool _appBarSwitch;
  static bool _appBarTitleSwitch;
  static bool _appBarLeadingSwitch;
  static bool _centerTitleSwitch;

  @override
  void initState() {
    super.initState();
    _initScaffoldFactory();
  }

  @override
  Widget build(BuildContext context) {
    _scaffoldFactory.textTheme = Theme.of(context).textTheme;
    _appBarSwitch =
        _scaffoldFactory.appBarVisibility == ScaffoldVisibility.visible;

    return _scaffoldFactory.build(_buildBody(context));
  }

  void _initScaffoldFactory() {
    _scaffoldFactory = ScaffoldFactory(_scaffoldKey, _sampleColorPalette);
    _scaffoldFactory.buttonsBehavior = this;

    _scaffoldFactory.init(
      backgroundType: BackgroundType.normal,
      appBarVisibility: ScaffoldVisibility.visible,
      floatingActionButtonVisibility: ScaffoldVisibility.invisible,
      appBar: _buildAppBar(),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: <Widget>[
          ////////////////////////////////////////////////// App Bar visibility
          SwitchListTile(
            value: _appBarSwitch,
            onChanged: (bool value) {
              setState(() {
                _scaffoldFactory.appBarVisibility = value
                    ? ScaffoldVisibility.visible
                    : ScaffoldVisibility.invisible;
                _appBarSwitch = value;
              });
            },
            activeColor: _scaffoldFactory.colorPalette.accentColor,
            title: Text('App Bar'),
            subtitle: Text('Change app bar visibility'),
          ),
          //////////////////////////////////////////// App Bar title visibility
          SwitchListTile(
            value: _appBarSwitch ? _appBarTitleSwitch : false,
            onChanged: _appBarSwitch
                ? (bool value) {
                    setState(() {
                      _scaffoldFactory.appBar = _buildAppBar(
                          titleVisibility: value
                              ? ScaffoldVisibility.visible
                              : ScaffoldVisibility.invisible);
                      _appBarTitleSwitch = value;
                    });
                  }
                : null,
            activeColor: _scaffoldFactory.colorPalette.accentColor,
            title: Text('Title'),
            subtitle: Text('Change title visibility'),
          ),
          //////////////////////////////////////////// Center title visibility
          SwitchListTile(
            value: _appBarSwitch && _appBarTitleSwitch
                ? _centerTitleSwitch
                : false,
            onChanged: _appBarSwitch && _appBarTitleSwitch
                ? (bool value) {
                    setState(() {
                      _scaffoldFactory.appBar = _buildAppBar(
                        centerTitle: value,
                      );
                      _centerTitleSwitch = value;
                    });
                  }
                : null,
            activeColor: _scaffoldFactory.colorPalette.accentColor,
            title: Text('Center Title'),
            subtitle: Text('Change title position to center'),
          ),
          //////////////////////////////////////////// App Bar title visibility
          SwitchListTile(
            value: _appBarSwitch ? _appBarLeadingSwitch : false,
            onChanged: _appBarSwitch
                ? (bool value) {
                    setState(() {
                      _scaffoldFactory.appBar = _buildAppBar(
                          leadingVisibility: value
                              ? ScaffoldVisibility.visible
                              : ScaffoldVisibility.invisible);
                      _appBarLeadingSwitch = value;
                    });
                  }
                : null,
            activeColor: _scaffoldFactory.colorPalette.accentColor,
            title: Text('Leading'),
            subtitle: Text('Change leading widget visibility'),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(
      {ScaffoldVisibility titleVisibility = ScaffoldVisibility.visible,
      ScaffoldVisibility leadingVisibility = ScaffoldVisibility.visible,
      bool centerTitle = false}) {
    _appBarTitleSwitch = titleVisibility == ScaffoldVisibility.visible;
    _centerTitleSwitch = centerTitle;
    _appBarLeadingSwitch = leadingVisibility == ScaffoldVisibility.visible;

    return _scaffoldFactory.buildAppBar(
      titleVisibility: titleVisibility,
      leadingVisibility: leadingVisibility,
      titleWidget: const Text('App Bar Configuration'),
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
}
