import 'package:flutter/material.dart';
import 'package:scaffold_factory/scaffold_factory.dart';
import 'package:scaffold_factory_example/sample/sample_placeholder.dart';

class SampleBottomNavigationBar extends StatefulWidget {
  @override
  _SampleBottomNavigationBarState createState() =>
      new _SampleBottomNavigationBarState();
}

class _SampleBottomNavigationBarState extends State<SampleBottomNavigationBar>
    implements ScaffoldFactoryButtonsBehavior {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScaffoldFactory _scaffoldFactory;
  MaterialPalette _sampleColorPalette = MaterialPalette(
    primaryColor: Colors.orange,
    accentColor: Colors.deepOrange,
  );

  int _currentIndex = 0;

  final List<Widget> _bodyChildren = [
    SamplePlaceholder(Colors.lightBlue),
    SamplePlaceholder(Colors.deepOrange),
    SamplePlaceholder(Colors.green)
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

    return _scaffoldFactory.build(_bodyChildren[_currentIndex]);
  }

  void _initScaffoldFactory() {
    _scaffoldFactory = ScaffoldFactory(_scaffoldKey, _sampleColorPalette);
    _scaffoldFactory.buttonsBehavior = this;

    _scaffoldFactory.init(
      backgroundType: BackgroundType.normal,
      appBarVisibility: ScaffoldVisibility.visible,
      floatingActionButtonVisibility: ScaffoldVisibility.invisible,
      bottomNavigationBarVisibility: ScaffoldVisibility.visible,
//      bottomNavigationBar: _buildBottomNavigationBar(),
      appBar: _scaffoldFactory.buildAppBar(
        titleVisibility: ScaffoldVisibility.visible,
        leadingVisibility: ScaffoldVisibility.visible,
        titleWidget: const Text('Navigation Bar Configuration'),
        leadingWidget: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => this.onBackButtonPressed(),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return _scaffoldFactory.buildBottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mail),
          title: Text('Messages'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('Profile'),
        ),
      ],
      currentIndex: _currentIndex,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
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
