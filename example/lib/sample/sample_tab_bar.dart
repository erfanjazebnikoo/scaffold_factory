import 'package:flutter/material.dart';
import 'package:scaffold_factory/scaffold_factory.dart';
import 'package:scaffold_factory_example/sample/sample_placeholder.dart';

class SampleTabBar extends StatefulWidget {
  @override
  _SampleTabBarState createState() => new _SampleTabBarState();
}

class _SampleTabBarState extends State<SampleTabBar>
    with TickerProviderStateMixin
    implements ScaffoldFactoryButtonsBehavior {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScaffoldFactory _scaffoldFactory;
  MaterialPalette _sampleColorPalette = MaterialPalette(
    primaryColor: Colors.green,
    accentColor: Colors.deepOrangeAccent,
  );
  TabController _tabController;
  static bool _appBarTitleSwitch;
  static bool _appBarLeadingSwitch;
  static bool _tabBarSwitch;
  static bool _centerTitleSwitch;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 10, initialIndex: 0);
    _initScaffoldFactory();
  }

  @override
  Widget build(BuildContext context) {
    _scaffoldFactory.textTheme = Theme.of(context).textTheme;

    return Theme(
      data: Theme.of(context).copyWith(
        indicatorColor: _scaffoldFactory.colorPalette.accentColor,
      ),
      child: DefaultTabController(
        length: 10,
        child: _scaffoldFactory.build(_buildTabBar(context)),
      ),
    );
//    return _scaffoldFactory.build(_buildBody(context));
  }

  void _initScaffoldFactory() {
    _scaffoldFactory = ScaffoldFactory(_scaffoldKey, _sampleColorPalette);
    _scaffoldFactory.buttonsBehavior = this;

    _scaffoldFactory.init(
      backgroundType: BackgroundType.normal,
      appBarVisibility: true,
      floatingActionButtonVisibility: false,
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
          ListTile(
            title: Text(
              'Top',
              style: _scaffoldFactory.textTheme.body2
                  .copyWith(color: _scaffoldFactory.colorPalette.accentColor),
            ),
          ),
          //////////////////////////////////////////// App Bar title visibility
          SwitchListTile(
            value:
                _scaffoldFactory.appBarVisibility ? _appBarTitleSwitch : false,
            onChanged: _scaffoldFactory.appBarVisibility
                ? (bool value) {
                    setState(() {
                      _scaffoldFactory.appBar =
                          _buildAppBar(titleVisibility: value);
                      _appBarTitleSwitch = value;
                    });
                  }
                : null,
            activeColor: _scaffoldFactory.colorPalette.accentColor,
            title: Text('Title'),
            subtitle: Text('Change title visibility'),
          ),
          ////////////////////////////////////////// App Bar leading visibility
          SwitchListTile(
            value: _scaffoldFactory.appBarVisibility
                ? _appBarLeadingSwitch
                : false,
            onChanged: _scaffoldFactory.appBarVisibility
                ? (bool value) {
                    setState(() {
                      _scaffoldFactory.appBar =
                          _buildAppBar(leadingVisibility: value);
                      _appBarLeadingSwitch = value;
                    });
                  }
                : null,
            activeColor: _scaffoldFactory.colorPalette.accentColor,
            title: Text('Leading'),
            subtitle: Text('Change leading widget visibility'),
          ),
          //////////////////////////////////////////// Center title visibility
          SwitchListTile(
            value: _scaffoldFactory.appBarVisibility && _appBarTitleSwitch
                ? _centerTitleSwitch
                : false,
            onChanged: _scaffoldFactory.appBarVisibility && _appBarTitleSwitch
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
          ListTile(
            title: Text(
              'Bottom',
              style: _scaffoldFactory.textTheme.body2
                  .copyWith(color: _scaffoldFactory.colorPalette.accentColor),
            ),
          ),
          //////////////////////////////////////////// Tab Bar visibility
          SwitchListTile(
            value: _scaffoldFactory.appBarVisibility ? _tabBarSwitch : false,
            onChanged: _scaffoldFactory.appBarVisibility
                ? (bool value) {
                    setState(() {
                      _scaffoldFactory.appBar =
                          _buildAppBar(tabBarVisibility: value);
                      _tabBarSwitch = value;
                    });
                  }
                : null,
            activeColor: _scaffoldFactory.colorPalette.accentColor,
            title: Text('Tab Bar'),
            subtitle: Text('Change tab bar visibility'),
          ),
        ],
      ),
    );
  }

  TabBarView _buildTabBar(BuildContext context) {
    return TabBarView(
      children: [
        _buildBody(context),
        SamplePlaceholder(Colors.lightBlue, "Page 2 Screen"),
        SamplePlaceholder(Colors.orange, "Page 3 Screen"),
        SamplePlaceholder(Colors.green, "Page 4 Screen"),
        SamplePlaceholder(Colors.red, "Page 5 Screen"),
        SamplePlaceholder(Colors.yellow, "Page 6 Screen"),
        SamplePlaceholder(Colors.blue, "Page 7 Screen"),
        SamplePlaceholder(Colors.pink, "Page 8 Screen"),
        SamplePlaceholder(Colors.lime, "Page 9 Screen"),
      ],
      controller: _tabController,
    );
  }

  AppBar _buildAppBar(
      {bool titleVisibility = true,
      bool leadingVisibility = true,
      bool tabBarVisibility = true,
      bool centerTitle = false}) {
    _appBarTitleSwitch = titleVisibility;
    _centerTitleSwitch = centerTitle;
    _appBarLeadingSwitch = leadingVisibility;
    _tabBarSwitch = tabBarVisibility;

    return _scaffoldFactory.buildAppBar(
        titleVisibility: titleVisibility,
        leadingVisibility: leadingVisibility,
        tabBarVisibility: tabBarVisibility,
        titleWidget: const Text('App Bar Configuration'),
        leadingWidget: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => this.onBackButtonPressed(),
        ),
        backgroundColor: _sampleColorPalette.primaryColor,
        centerTitle: centerTitle,
        tabWidgetList: [
          Tab(child: Text("Configuration")),
          Tab(child: Text("Page 2")),
          Tab(child: Text("Page 3")),
          Tab(child: Text("Page 4")),
          Tab(child: Text("Page 5")),
          Tab(child: Text("Page 6")),
          Tab(child: Text("Page 7")),
          Tab(child: Text("Page 8")),
          Tab(child: Text("Page 9")),
        ],
        scrollableTab: true,
        tabController: this._tabController);
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
