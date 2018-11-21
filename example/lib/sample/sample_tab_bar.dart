import 'package:flutter/material.dart';
import 'package:scaffold_factory/scaffold_factory.dart';

import 'sample_placeholder.dart';

class SampleTabBar extends StatefulWidget {
  @override
  _SampleTabBarState createState() => _SampleTabBarState();
}

class _SampleTabBarState extends State<SampleTabBar>
    with TickerProviderStateMixin
    implements ScaffoldFactoryBehaviors {
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
      drawerVisibility: false,
      nestedAppBarVisibility: false,
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
                      _appBarTitleSwitch = value;
                      _scaffoldFactory.appBar =
                          _buildAppBar(titleVisibility: value);
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
                      _appBarLeadingSwitch = value;
                      _scaffoldFactory.appBar =
                          _buildAppBar(leadingVisibility: value);
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
                      _centerTitleSwitch = value;
                      _scaffoldFactory.appBar =
                          _buildAppBar(centerTitle: value);
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
                      _tabBarSwitch = value;
                      _scaffoldFactory.appBar =
                          _buildAppBar(tabBarVisibility: value);
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
        SamplePlaceholder("Page 2 Screen", color: Colors.lightBlue),
        SamplePlaceholder("Page 3 Screen", color: Colors.orange),
        SamplePlaceholder("Page 4 Screen", color: Colors.green),
        SamplePlaceholder("Page 5 Screen", color: Colors.red),
        SamplePlaceholder("Page 6 Screen", color: Colors.yellow),
        SamplePlaceholder("Page 7 Screen", color: Colors.blue),
        SamplePlaceholder("Page 8 Screen", color: Colors.pink),
        SamplePlaceholder("Page 9 Screen", color: Colors.lime),
      ],
      controller: _tabController,
    );
  }

  AppBar _buildAppBar({
    bool titleVisibility,
    bool leadingVisibility,
    bool tabBarVisibility,
    bool centerTitle,
  }) {
    _appBarTitleSwitch = titleVisibility ?? true;
    _centerTitleSwitch = centerTitle ?? false;
    _appBarLeadingSwitch = leadingVisibility ?? true;
    _tabBarSwitch = tabBarVisibility ?? true;

    return _scaffoldFactory.buildAppBar(
        titleVisibility: _appBarTitleSwitch,
        leadingVisibility: _appBarLeadingSwitch,
        tabBarVisibility: _tabBarSwitch,
        titleWidget: const Text('App Bar Configuration'),
        leadingWidget: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => this.onBackButtonPressed(),
        ),
        backgroundColor: _sampleColorPalette.primaryColor,
        centerTitle: _centerTitleSwitch,
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

  @override
  Future onEventBusMessageReceived(event) async {
    print("ScaffoldFactory: Event Received");
  }
}
