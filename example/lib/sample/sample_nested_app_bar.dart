import 'package:flutter/material.dart';
import 'package:scaffold_factory/scaffold_factory.dart';
import 'package:scaffold_factory_example/sample/sample_placeholder.dart';

class SampleNestedAppBar extends StatefulWidget {
  @override
  _SampleNestedAppBarState createState() => new _SampleNestedAppBarState();
}

class _SampleNestedAppBarState extends State<SampleNestedAppBar>
    with TickerProviderStateMixin
    implements ScaffoldFactoryButtonsBehavior {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScaffoldFactory _scaffoldFactory;
  MaterialPalette _sampleColorPalette = MaterialPalette(
    primaryColor: Colors.orange,
    accentColor: Colors.deepOrangeAccent,
  );

  TabController _tabController;
  static bool _appBarTitleSwitch;
  static bool _appBarLeadingSwitch;
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

    return DefaultTabController(
      length: 10,
      child: _scaffoldFactory.build(_buildTabBar(context)),
    );
  }

  void _initScaffoldFactory() {
    _scaffoldFactory = ScaffoldFactory(_scaffoldKey, _sampleColorPalette);
    _scaffoldFactory.buttonsBehavior = this;

    _scaffoldFactory.init(
      backgroundType: BackgroundType.normal,
      appBarVisibility: true,
      nestedAppBarVisibility: true,
      floatingActionButtonVisibility: false,
      nestedAppBar: _buildNestedAppBar(),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: <Widget>[
          ////////////////////////////////////////////////// App Bar visibility
//          SwitchListTile(
//            value: _scaffoldFactory.appBarVisibility,
//            onChanged: (bool value) {
//              setState(() {
//                _scaffoldFactory.appBarVisibility = value;
//              });
//            },
//            activeColor: _scaffoldFactory.colorPalette.accentColor,
//            title: Text('App Bar'),
//            subtitle: Text('Change app bar visibility'),
//          ),
//          //////////////////////////////////////////// App Bar title visibility
//          SwitchListTile(
//            value:
//                _scaffoldFactory.appBarVisibility ? _appBarTitleSwitch : false,
//            onChanged: _scaffoldFactory.appBarVisibility
//                ? (bool value) {
//                    setState(() {
//                      _scaffoldFactory.appBar =
//                          _buildNestedAppBar(titleVisibility: value);
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
//                      _scaffoldFactory.appBar = _buildNestedAppBar(
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
//          //////////////////////////////////////////// App Bar title visibility
//          SwitchListTile(
//            value: _scaffoldFactory.appBarVisibility
//                ? _appBarLeadingSwitch
//                : false,
//            onChanged: _scaffoldFactory.appBarVisibility
//                ? (bool value) {
//                    setState(() {
//                      _scaffoldFactory.appBar =
//                          _buildNestedAppBar(leadingVisibility: value);
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

  NestedScrollView _buildNestedAppBar({
    bool titleVisibility = true,
    bool leadingVisibility = true,
    bool tabBarVisibility = false,
    bool floating = false,
    bool centerTitle = false,
    bool scrollableTab = false,
  }) {
    _appBarTitleSwitch = titleVisibility;
    _centerTitleSwitch = centerTitle;
    _appBarLeadingSwitch = leadingVisibility;

    return _scaffoldFactory.buildNestedScrollView(
      titleVisibility: titleVisibility,
      leadingVisibility: leadingVisibility,
      tabBarVisibility: tabBarVisibility,
      titleWidget: const Text('Nested App Bar Configuration'),
      leadingWidget: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => this.onBackButtonPressed(),
      ),
      backgroundColor: _sampleColorPalette.primaryColor,
      centerTitle: centerTitle,
      floating: floating,
      scrollableTab: scrollableTab,
      tabController: _tabController,
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
    );

//    return _scaffoldFactory.buildAppBar(
//      titleVisibility: titleVisibility,
//      leadingVisibility: leadingVisibility,
//      titleWidget: const Text('App Bar Configuration'),
//      leadingWidget: IconButton(
//        icon: Icon(Icons.arrow_back),
//        onPressed: () => this.onBackButtonPressed(),
//      ),
//      backgroundColor: _sampleColorPalette.primaryColor,
//      centerTitle: centerTitle,
//    );
  }

  Widget _buildTabBar(BuildContext context) {
    return TabBarView(
      children: [
        _buildBody(context),
        SamplePlaceholder(Colors.lightBlue, "Page 2 Screen"),
        SamplePlaceholder(Colors.orange, "Page 3 Screen"),
        SamplePlaceholder(Colors.green, "Page 4 Screen"),
        SamplePlaceholder(Colors.yellow, "Page 5 Screen"),
        SamplePlaceholder(Colors.red, "Page 6 Screen"),
        SamplePlaceholder(Colors.blue, "Page 7 Screen"),
        SamplePlaceholder(Colors.pink, "Page 8 Screen"),
        SamplePlaceholder(Colors.lime, "Page 9 Screen"),
      ],
      controller: _tabController,
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
