import 'package:flutter/material.dart';
import 'package:scaffold_factory/scaffold_factory.dart';

import 'sample_placeholder.dart';

class SampleNestedAppBar extends StatefulWidget {
  @override
  _SampleNestedAppBarState createState() => _SampleNestedAppBarState();
}

class _SampleNestedAppBarState extends State<SampleNestedAppBar>
    with TickerProviderStateMixin
    implements ScaffoldFactoryBehaviors {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScaffoldFactory _scaffoldFactory;
  MaterialPalette _sampleColorPalette = MaterialPalette(
    primaryColor: Colors.blue,
    accentColor: Colors.lightBlueAccent,
  );

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 10, initialIndex: 0);
    _initScaffoldFactory();
  }

  @override
  Widget build(BuildContext context) {
    _scaffoldFactory.textTheme = Theme.of(context).textTheme;

    _scaffoldFactory.nestedAppBar = _scaffoldFactory.buildNestedScrollView(
      titleVisibility: true,
      leadingVisibility: true,
      tabBarVisibility: true,
      titleWidget: const Text('Nested App Bar Configuration'),
      leadingWidget: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => this.onBackButtonPressed(),
      ),
      backgroundColor: _sampleColorPalette.primaryColor,
      centerTitle: true,
      floating: true,
      scrollableTab: true,
      tabController: _tabController,
      tabWidgetList: [
        Tab(child: Text("Page 1")),
        Tab(child: Text("Page 2")),
        Tab(child: Text("Page 3")),
        Tab(child: Text("Page 4")),
        Tab(child: Text("Page 5")),
        Tab(child: Text("Page 6")),
        Tab(child: Text("Page 7")),
        Tab(child: Text("Page 8")),
        Tab(child: Text("Page 9")),
      ],
      bodyWidget: _buildTabBar(context),
    );

    return DefaultTabController(
      length: 10,
      child: _scaffoldFactory.build(null),
    );
  }

  void _initScaffoldFactory() {
    _scaffoldFactory = ScaffoldFactory(
      scaffoldKey: _scaffoldKey,
      materialPalette: _sampleColorPalette,
    );
    _scaffoldFactory.scaffoldFactoryBehavior = this;

    _scaffoldFactory.init(
      backgroundType: BackgroundType.normal,
      appBarVisibility: false,
      nestedAppBarVisibility: true,
      floatingActionButtonVisibility: false,
      drawerVisibility: false,
      bottomNavigationBarVisibility: false,
    );
  }

  Widget _buildTabBar(BuildContext context) {
    final colors = [
      Colors.purpleAccent,
      Colors.purple,
      Colors.deepPurple,
      Colors.deepPurpleAccent,
    ];
    return TabBarView(
      children: [
        CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                List.generate(
                  4,
                  (int index) => Container(
                        height: 500.0,
                        child: SamplePlaceholder(
                          "Slide $index Screen",
                          color: colors[index],
                        ),
                      ),
                ),
              ),
            ),
          ],
        ),
        SamplePlaceholder("Page 2 Screen", color: Colors.orange),
        SamplePlaceholder("Page 3 Screen", color: Colors.lightBlue),
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
