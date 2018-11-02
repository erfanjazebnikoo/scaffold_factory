import 'package:flutter/material.dart';
import 'package:scaffold_factory/scaffold_factory.dart';

class SampleFloatingActionButton extends StatefulWidget {
  @override
  _SampleFloatingActionButtonState createState() =>
      new _SampleFloatingActionButtonState();
}

class _SampleFloatingActionButtonState extends State<SampleFloatingActionButton>
    implements ScaffoldFactoryButtonsBehavior {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScaffoldFactory _scaffoldFactory;
  MaterialPalette _sampleColorPalette = MaterialPalette(
    primaryColor: Colors.orange,
    accentColor: Colors.deepOrange,
  );
  static bool floatingActionButtonSwitch;

  @override
  void initState() {
    super.initState();
    floatingActionButtonSwitch = false;
    _initScaffoldFactory();
  }

  @override
  Widget build(BuildContext context) {
    _scaffoldFactory.textTheme = Theme.of(context).textTheme;
    return _scaffoldFactory.build(context, _buildBody(context));
  }

  void _initScaffoldFactory() {
    _scaffoldFactory = ScaffoldFactory(_scaffoldKey, _sampleColorPalette);
    _scaffoldFactory.buttonsBehavior = this;

    _scaffoldFactory.init(
      backgroundType: BackgroundType.normal,
      appBarVisibility: ScaffoldVisibility.invisible,
      appBar: _scaffoldFactory.buildAppBar(
        titleVisibility: ScaffoldVisibility.visible,
        leadingVisibility: ScaffoldVisibility.invisible,
        titleWidget: const Text('Scaffold Factory example'),
        leadingWidget: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => this.onBackButtonPressed(),
        ),
        backgroundColor: _sampleColorPalette.primaryColor,
      ),
      floatingActionButtonVisibility: ScaffoldVisibility.invisible,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _scaffoldFactory.buildFloatingActionButton(
        fabBody: Icon(
          Icons.link,
          color: Colors.white,
        ),
        tooltip: "Scaffold Factory Repository",
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: <Widget>[
          ListTile(
              title: Text(
            'Floating Action Button Configuration',
            style: _scaffoldFactory.textTheme.subhead.copyWith(
              color: _scaffoldFactory.colorPalette.accentColor,
            ),
          )),
          SwitchListTile(
            value: floatingActionButtonSwitch,
            onChanged: (bool value) {
              setState(() {
                _scaffoldFactory.floatingActionButtonVisibility = value
                    ? ScaffoldVisibility.visible
                    : ScaffoldVisibility.invisible;
                floatingActionButtonSwitch = value;
              });
            },
            activeColor: _scaffoldFactory.colorPalette.accentColor,
            title: Text('Floating Action Button'),
            subtitle: Text('Change floating action button visibility'),
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
  }
}
