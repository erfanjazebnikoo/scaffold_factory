import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScaffoldFactory {
  GlobalKey<ScaffoldState> scaffoldKey;

  factory ScaffoldFactory(GlobalKey<ScaffoldState> scaffoldKey) {
    return ScaffoldFactory._internal(scaffoldKey);
  }

  ScaffoldFactory._internal(this.scaffoldKey);
}

abstract class BackButtonBehavior {
  VoidCallback onBackPressed();
}

abstract class FloatingActionBarBehavior {
  void onFABPressed();
}

class MaterialPalette {
  Color primaryColor;
  Color secondaryColor;
  Color accentColor;
  Color textColor;

  MaterialPalette(
      this.primaryColor, this.secondaryColor, this.accentColor, this.textColor);
}
