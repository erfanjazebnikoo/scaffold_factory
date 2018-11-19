import 'package:flutter/material.dart';
import 'package:scaffold_factory/scaffold_factory.dart';

import 'sample_placeholder.dart';

class SampleBottomAppBar extends StatefulWidget {
  @override
  _SampleBottomAppBarState createState() => _SampleBottomAppBarState();
}

class _SampleBottomAppBarState extends State<SampleBottomAppBar>
    implements ScaffoldFactoryBehaviors {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScaffoldFactory _scaffoldFactory;
  int _currentIndex = 0;
  MaterialPalette _sampleColorPalette = MaterialPalette(
    primaryColor: const Color(0xFFff8c94),
    accentColor: Colors.indigoAccent,
  );
  final _bodyChildren = [
    SamplePlaceholder("Home Screen"),
    SamplePlaceholder("Messages Screen"),
    SamplePlaceholder("Profile Screen"),
    SamplePlaceholder("Search Screen"),
  ];

  @override
  void initState() {
    super.initState();
    _initScaffoldFactory();
  }

  @override
  Widget build(BuildContext context) {
    _scaffoldFactory.textTheme = Theme.of(context).textTheme;

    _scaffoldFactory.bottomNavigationBar = _buildBottomNavigationBar();

    _scaffoldFactory.appBar = _scaffoldFactory.buildAppBar(
      titleVisibility: true,
      leadingVisibility: true,
      tabBarVisibility: false,
      titleWidget: const Text('Bottom App Bar Configuration'),
      backgroundColor: _scaffoldFactory.gradientBackgroundColors[0],
      leadingWidget: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => this.onBackButtonPressed(),
      ),
    );

    return Theme(
        data: Theme.of(context).copyWith(
          scaffoldBackgroundColor: _scaffoldFactory.gradientBackgroundColors[1],
        ),
        child: _scaffoldFactory.build(_bodyChildren[_currentIndex]));
  }

  void _initScaffoldFactory() {
    _scaffoldFactory = ScaffoldFactory(
      scaffoldKey: _scaffoldKey,
      materialPalette: _sampleColorPalette,
    );
    _scaffoldFactory.scaffoldFactoryBehavior = this;

    _scaffoldFactory.init(
      backgroundType: BackgroundType.gradient,
      gradientBackgroundColors: [
        const Color(0xFFff8c94),
        const Color(0xFFf65d6b),
      ],
      appBarVisibility: true,
      floatingActionButtonVisibility: true,
      bottomNavigationBarVisibility: true,
      floatingActionButton: _scaffoldFactory.buildFloatingActionButton(
        fabBody: Icon(
          Icons.add,
          color: Colors.white,
        ),
        tooltip: "Scaffold Factory Repository",
      ),
      nestedAppBarVisibility: false,
      drawerVisibility: false,
    );
  }

  Widget _buildBottomNavigationBar() {
    final List<Widget> rowContents = <Widget>[
      Expanded(
        child: MaterialButton(
          height: 50.0,
          onPressed: () {
            setState(() {
              _scaffoldFactory.gradientBackgroundColors = [
                const Color(0xFFff8c94),
                const Color(0xFFf65d6b),
              ];
              _currentIndex = 0;
            });
          },
          child: Icon(Icons.home,
              color: _currentIndex == 0 ? Colors.white : Colors.white30),
        ),
      ),
      Expanded(
        child: MaterialButton(
          height: 50.0,
          onPressed: () {
            setState(() {
              _scaffoldFactory.gradientBackgroundColors = [
                const Color(0xFFfeb786),
                const Color(0xFFfb9d54),
              ];

              _currentIndex = 1;
            });
          },
          child: Icon(Icons.mail,
              color: _currentIndex == 1 ? Colors.white : Colors.white30),
        ),
      ),
      Expanded(
        child: SizedBox(),
      ),
      Expanded(
        child: MaterialButton(
          height: 50.0,
          onPressed: () {
            setState(() {
              _scaffoldFactory.gradientBackgroundColors = [
                const Color(0xFFc5e19d),
                const Color(0xFFafd478),
              ];
              _currentIndex = 2;
            });
          },
          child: Icon(Icons.person,
              color: _currentIndex == 2 ? Colors.white : Colors.white30),
        ),
      ),
      Expanded(
        child: MaterialButton(
          height: 50.0,
          onPressed: () {
            setState(() {
              _scaffoldFactory.gradientBackgroundColors = [
                const Color(0xFF6fd4b0),
                const Color(0xFF00b47e),
              ];
              _currentIndex = 3;
            });
          },
          child: Icon(Icons.search,
              color: _currentIndex == 3 ? Colors.white : Colors.white30),
        ),
      ),
    ];

    return _scaffoldFactory.buildBottomAppBar(
      showNotch: true,
      color: _scaffoldFactory.gradientBackgroundColors[0],
      child: Row(
        children: rowContents,
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

class BottomAppBarButton {
  final VoidCallback onPressed;
  final Widget icon;
  final Color color;

  BottomAppBarButton(this.onPressed, this.icon, this.color);
}
