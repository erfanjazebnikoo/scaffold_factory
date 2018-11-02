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

  static bool appBarSwitch;
  static bool appBarTitleSwitch;
  static bool appBarLeadingSwitch;

  @override
  void initState() {
    super.initState();
    _initScaffoldFactory();
  }

  @override
  Widget build(BuildContext context) {
    _scaffoldFactory.textTheme = Theme.of(context).textTheme;
    appBarSwitch =
        _scaffoldFactory.appBarVisibility == ScaffoldVisibility.visible;

    return _scaffoldFactory.build(context, _buildBody(context));
  }

  void _initScaffoldFactory() {
    _scaffoldFactory = ScaffoldFactory(_scaffoldKey, _sampleColorPalette);
    _scaffoldFactory.buttonsBehavior = this;

    _scaffoldFactory.init(
      backgroundType: BackgroundType.normal,
      appBarVisibility: ScaffoldVisibility.visible,
      appBar: _buildAppBar(),
      floatingActionButtonVisibility: ScaffoldVisibility.invisible,
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: <Widget>[
          ListTile(
              title: Text(
            'App Bar Configuration',
            style: _scaffoldFactory.textTheme.subhead.copyWith(
              color: _scaffoldFactory.colorPalette.accentColor,
            ),
          )),
          ////////////////////////////////////////////////// App Bar visibility
          SwitchListTile(
            value: appBarSwitch,
            onChanged: (bool value) {
              setState(() {
                _scaffoldFactory.appBarVisibility = value
                    ? ScaffoldVisibility.visible
                    : ScaffoldVisibility.invisible;
                appBarSwitch = value;
              });
            },
            activeColor: _scaffoldFactory.colorPalette.accentColor,
            title: Text('App Bar'),
            subtitle: Text('Change app bar visibility'),
          ),
          //////////////////////////////////////////// App Bar title visibility
          SwitchListTile(
            value: appBarTitleSwitch,
            onChanged: (bool value) {
              setState(() {
                _scaffoldFactory.appBar = _buildAppBar(
                    titleVisibility: value
                        ? ScaffoldVisibility.visible
                        : ScaffoldVisibility.invisible);
                appBarTitleSwitch = value;
              });
            },
            activeColor: _scaffoldFactory.colorPalette.accentColor,
            title: Text('Title'),
            subtitle: Text('Change title visibility'),
          ),
          //////////////////////////////////////////// App Bar title visibility
          SwitchListTile(
            value: appBarLeadingSwitch,
            onChanged: (bool value) {
              setState(() {
                _scaffoldFactory.appBar = _buildAppBar(
                    leadingVisibility: value
                        ? ScaffoldVisibility.visible
                        : ScaffoldVisibility.invisible);
                appBarLeadingSwitch = value;
              });
            },
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
      ScaffoldVisibility leadingVisibility = ScaffoldVisibility.visible}) {
    appBarTitleSwitch = titleVisibility == ScaffoldVisibility.visible;
    appBarLeadingSwitch = leadingVisibility == ScaffoldVisibility.visible;

    return _scaffoldFactory.buildAppBar(
      titleVisibility: titleVisibility,
      leadingVisibility: leadingVisibility,
      titleWidget: const Text('App Bar Configuration'),
      leadingWidget: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => this.onBackButtonPressed(),
      ),
      backgroundColor: _sampleColorPalette.primaryColor,
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
