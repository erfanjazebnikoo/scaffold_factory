import 'package:flutter/material.dart';
import 'package:scaffold_factory/scaffold_factory.dart';

class SampleCatalog extends StatefulWidget {
  @override
  _SampleCatalogState createState() => _SampleCatalogState();
}

class _SampleCatalogState extends State<SampleCatalog>
    implements ScaffoldFactoryBehaviors {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ScaffoldFactory _scaffoldFactory;
  MaterialPalette _sampleColorPalette = MaterialPalette(
    primaryColor: Colors.indigo,
    accentColor: Colors.pinkAccent,
  );

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
      appBar: _scaffoldFactory.buildAppBar(
        titleVisibility: true,
        leadingVisibility: false,
        tabBarVisibility: false,
        titleWidget: const Text('Scaffold Factory examples catalog'),
        backgroundColor: _sampleColorPalette.primaryColor,
      ),
      floatingActionButtonVisibility: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: _scaffoldFactory.buildFloatingActionButton(
        fabBody: Icon(
          Icons.link,
          color: Colors.white,
        ),
        tooltip: "Scaffold Factory Repository",
      ),
      drawerVisibility: false,
      nestedAppBarVisibility: false,
      bottomNavigationBarVisibility: false,
    );
  }

  Widget _buildBody(BuildContext context) {
    final imageOverlayGradient = DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          radius: 1.0,
          colors: [
            Colors.black.withOpacity(0.5),
            Colors.black.withOpacity(0.0)
          ],
        ),
      ),
    );
    return Container(
      color: Colors.transparent,
      child: GridView.count(
        crossAxisCount: 2,
        children: List<Widget>.generate(
          catalogItems.length,
          (index) {
            return GridTile(
              child: GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, catalogItems[index].routeName),
                child: Card(
                  color: _scaffoldFactory.colorPalette.primaryColor,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.asset(
                        'asset/${catalogItems[index].imageUrl}',
                        width: 25.0,
                        fit: BoxFit.fill,
                      ),
                      imageOverlayGradient,
                      Center(
                        child: Text(
                          catalogItems[index].name,
                          style: _scaffoldFactory.textTheme.subhead
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
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
    _scaffoldFactory
        .launchURL("https://github.com/erfanjazebnikoo/scaffold_factory");
  }

  @override
  Future onEventBusMessageReceived(event) async {
    print("ScaffoldFactory: Event Received");
  }
}

class CatalogOption {
  final String routeName;
  final String imageUrl;
  final String name;

  CatalogOption(this.name, this.imageUrl, this.routeName);
}

final catalogItems = [
  CatalogOption(
    "App Bar",
    "components_toolbars.png",
    "/appBar",
  ),
  CatalogOption(
    "Floating Action Button",
    "components_buttons_fab.png",
    "/floatingActionButton",
  ),
  CatalogOption(
    "Bottom Navigation Bar",
    "components_bottom_navigation.png",
    "/bottomNavigationBar",
  ),
  CatalogOption(
    "Tab Bar",
    "components_tabs.png",
    "/tabBar",
  ),
  CatalogOption(
    "Nested Scroll View",
    "components_tabs.png",
    "/nestedAppBar",
  ),
//  CatalogOption(
//    "Snack Bar",
//    "components_snackbars.png",
//    "/snackBar",
//  ),
//  CatalogOption(
//    "Drawer",
//    "patterns_navigation_drawer.png",
//    "",
//  ),
  CatalogOption(
    "Bottom App Bar",
    "components_bottom_navigation.png",
    "/bottomAppBar",
  ),
];
