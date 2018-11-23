# Scaffold Factory

[![Pub](https://img.shields.io/pub/v/scaffold_factory.svg)](https://pub.dartlang.org/packages/scaffold_factory)

A Flutter plugin to build and customize the Flutter's scaffold widget with simple and flexible configurations. Also, this plugin provides various implementations of useful widgets that can be used in UI design. The scaffold is a class provides APIs for showing drawers, snack bars, and bottom sheets. 

## How to use
### Import the package
To use this plugin, add ``scaffold_factory`` as a [dependency in your pubspec.yaml file][dependency]. Also, You can use [Dart packages' install instruction for this package][scaffold_factory_dart_packages].

### Use the plugin
1- Add the following import to your Dart code:

```dart
import 'package:scaffold_factory/scaffold_factory.dart';
```
2- Define these private variables inside your widget.

```dart
final _scaffoldKey = GlobalKey<ScaffoldState>();
ScaffoldFactory _scaffoldFactory;
MaterialPalette _sampleColorPalette = MaterialPalette(
  primaryColor: Colors.teal,
  accentColor: Colors.pinkAccent,
);
```

3- Your state class can Implements ``ScaffoldFactoryBehaviors`` interface:

```dart
class _ExampleScaffoldFactoryState extends State<ExampleScaffoldFactory> implements ScaffoldFactoryBehaviors {
  
  // body
 
  @override
  void onBackButtonPressed() {
    print("Scaffold Factory => onBackButtonPressed()");
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
```

4- Initialize ScaffoldFactory with the scopes you want:

```dart
 @override
  void initState() {
    super.initState();
    _initScaffoldFactory();
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
      floatingActionButtonVisibility: false,
      drawerVisibility: false,
      nestedAppBarVisibility: false,
      bottomNavigationBarVisibility: false,
    );
  }
```

5- Pass the body widget to ``build`` method of your ``_scaffoldFactory`` object and define your theme of texts:

```dart
@override
Widget build(BuildContext context) {
  _scaffoldFactory.textTheme = Theme.of(context).textTheme;

  return _scaffoldFactory.build(_buildBody(context));
}

Widget _buildBody(BuildContext context) {
  // return your body widget    
}

```

## Features

* Easily create a material interface with simple configurations.
* There is an implementation for each of scaffold's widget like the ``AppBar``, ``BottomNavigationBar``, ``FloatingActionButton``, etc.

| Method | Output |
| ------ | ------ |
| buildAppBar | `AppBar` widget |
| buildNestedScrollView | `NestedScrollView` widget |
| buildBottomNavigationBar | `BottomNavigationBar` widget |
| buildBottomAppBar | `BottomAppBar` widget |
| buildFloatingActionButton | `FloatingActionButton` widget |

* You can change the visibility of scaffold's widgets and pass your custom widget in the ``init`` method 
```dart
 _scaffoldFactory.init(
      appBarVisibility: true,
      appBar: _scaffoldFactory.buildAppBar(
        titleVisibility: true,
        leadingVisibility: false,
        tabBarVisibility: false,
        titleWidget: Text('Scaffol Factory Example'),
        backgroundColor: _scaffoldFactory.colorPalette.primaryColor,
      ),
    );
```
or whenever you want in the ``build`` method of your state.
```dart
@override
Widget build(BuildContext context) {
  _scaffoldFactory.textTheme = Theme.of(context).textTheme;
  
  _scaffoldFactory.appBarVisibility = true;
  _scaffoldFactory.appBar = _scaffoldFactory.buildAppBar(
      titleVisibility: true,
      leadingVisibility: false,
      tabBarVisibility: false,
      titleWidget: Text('Scaffol Factory Example'),
      backgroundColor: _scaffoldFactory.colorPalette.primaryColor,
    );

  return _scaffoldFactory.build(_buildBody(context));
}
```

## Example
There are two examples in the [example application][example] package. 

[![Solid](http://www.erfanjazebnikoo.com/downloads/scaffold_factory/scaffold_factory_example1_lq.jpg)](http://www.erfanjazebnikoo.com/downloads/scaffold_factory/scaffold_factory_example1_hq.jpg)
[![Solid](http://www.erfanjazebnikoo.com/downloads/scaffold_factory/scaffold_factory_catalog_lq.jpg)](http://www.erfanjazebnikoo.com/downloads/scaffold_factory/scaffold_factory_catalog_hq.jpg)
[![Solid](http://www.erfanjazebnikoo.com/downloads/scaffold_factory/scaffold_factory_bnb_lq.jpg)](http://www.erfanjazebnikoo.com/downloads/scaffold_factory/scaffold_factory_bnb_hq.jpg)
[![Solid](http://www.erfanjazebnikoo.com/downloads/scaffold_factory/scaffold_factory_ab_lq.jpg)](http://www.erfanjazebnikoo.com/downloads/scaffold_factory/scaffold_factory_ab_hq.jpg)

[dependency]:<https://flutter.io/docs/development/packages-and-plugins/using-packages>
[scaffold_factory_dart_packages]:<https://pub.dartlang.org/packages/scaffold_factory#-installing-tab->
[example]:<https://github.com/erfanjazebnikoo/scaffold_factory/tree/master/example>
