import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:scaffold_factory/event_bus.dart';
import 'package:url_launcher/url_launcher.dart';

class ScaffoldFactory {
  GlobalKey<ScaffoldState> scaffoldKey;
  ScaffoldFactoryBehaviors scaffoldFactoryBehavior;
  bool primary = true;

  /// Color, Palette and Theme
  MaterialPalette colorPalette;
  List<Color> gradientBackgroundColors;
  BackgroundType backgroundType;
  TextTheme textTheme;

  /// App bar
  bool appBarVisibility;
  AppBar appBar;

  /// Nested app bar
  bool nestedAppBarVisibility;
  NestedScrollView nestedAppBar;

  /// Floating Action Button
  bool floatingActionButtonVisibility = false;
  Widget floatingActionButton;
  FloatingActionButtonLocation fabLocation =
      FloatingActionButtonLocation.endFloat;
  bool showNotch = true;

  /// Bottom Navigation Bar
  bool bottomNavigationBarVisibility = false;
  Widget bottomNavigationBar;

  /// Event Bus
  StreamSubscription _eventBusSubscription;

  factory ScaffoldFactory(
          {@required GlobalKey<ScaffoldState> scaffoldKey,
          @required MaterialPalette materialPalette,
          dynamic event}) =>
      ScaffoldFactory._internal(
          scaffoldKey: scaffoldKey,
          colorPalette: materialPalette,
          event: event);

  ScaffoldFactory._internal(
      {@required this.scaffoldKey,
      @required this.colorPalette,
      dynamic event}) {
    _eventBusSubscription = eventBus.on<dynamic>().listen((event) async {
      if (event != null)
        this.scaffoldFactoryBehavior.onEventBusMessageReceived(event);
    });
  }

  void init({
    BackgroundType backgroundType = BackgroundType.normal,
    bool appBarVisibility = false,
    bool floatingActionButtonVisibility = false,
    bool bottomNavigationBarVisibility = false,
    bool nestedAppBarVisibility = false,
    Widget floatingActionButton,
    FloatingActionButtonLocation floatingActionButtonLocation,
    AppBar appBar,
    NestedScrollView nestedAppBar,
  }) {
    this.appBarVisibility = appBarVisibility;
    this.floatingActionButtonVisibility = floatingActionButtonVisibility;
    this.bottomNavigationBarVisibility = bottomNavigationBarVisibility;
    this.nestedAppBarVisibility = nestedAppBarVisibility;
    this.backgroundType = backgroundType;
    this.floatingActionButton = floatingActionButton;
    this.fabLocation = floatingActionButtonLocation;
    this.appBar = appBar;
  }

  Widget build(Widget bodyWidget) {
    if (appBarVisibility && nestedAppBarVisibility) {
      throw Exception(
          "Both app bar widget and nested app bar widget are being used simultaneously. \n" +
              "Make app bar widget or nested app bar widget invisible for resolving this issue.");
    }
    return Scaffold(
      key: scaffoldKey,
      primary: primary,
      appBar: this.appBarVisibility ? this.appBar : null,
      floatingActionButtonLocation: fabLocation,
      bottomNavigationBar:
          this.bottomNavigationBarVisibility ? this.bottomNavigationBar : null,
      floatingActionButton: this.floatingActionButtonVisibility
          ? this.floatingActionButton
          : null,
      body: Container(
        decoration: BoxDecoration(
          color: backgroundType == BackgroundType.solidColor
              ? colorPalette.primaryColor
              : null,
          gradient: backgroundType == BackgroundType.gradient
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: gradientBackgroundColors,
                )
              : null,
        ),
        child: nestedAppBarVisibility ? this.nestedAppBar : bodyWidget,
      ),
    );
  }

  /// Simple implementation of App Bar which user can use it with
  /// easy configuration
  AppBar buildAppBar({
    @required bool titleVisibility,
    @required bool leadingVisibility,
    @required bool tabBarVisibility,
    Widget titleWidget,
    Widget leadingWidget,
    Color backgroundColor,
    bool centerTitle = false,
    bool scrollableTab,
    TabController tabController,
    List<Widget> tabWidgetList,
  }) {
    return AppBar(
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      leading: leadingVisibility ? leadingWidget : null,
      title: titleVisibility ? titleWidget : null,
      centerTitle: centerTitle,
      bottom: tabBarVisibility
          ? TabBar(
              isScrollable: scrollableTab,
              tabs: tabWidgetList,
              controller: tabController,
              indicatorWeight: 4.0,
            )
          : null,
    );
  }

  NestedScrollView buildNestedScrollView({
    @required bool titleVisibility,
    @required bool leadingVisibility,
    @required bool tabBarVisibility,
    @required Widget bodyWidget,
    bool scrollableTab,
    List<Widget> tabWidgetList,
    TabController tabController,
    Widget titleWidget,
    Widget leadingWidget,
    Color backgroundColor,
    bool centerTitle = false,
    bool floating = false,
  }) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            backgroundColor: backgroundColor,
            leading: leadingVisibility ? leadingWidget : null,
            title: titleVisibility ? titleWidget : null,
            bottom: tabBarVisibility
                ? TabBar(
                    isScrollable: scrollableTab,
                    tabs: tabWidgetList,
                    controller: tabController,
                    indicatorWeight: 4.0,
                  )
                : null,
            centerTitle: centerTitle,
            floating: floating,
            pinned: true,
            automaticallyImplyLeading: false,
            forceElevated: true,
          ),
        ];
      },
      body: bodyWidget,
    );
  }

  Widget buildBottomNavigationBar({
    @required List<BottomNavigationBarItem> items,
    @required ValueChanged<int> onTap,
    int currentIndex = 0,
    Color color,
  }) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: currentIndex,
      items: items,
      fixedColor: color,
    );
  }

  Widget buildBottomAppBar() {
    return null;
    //    return CustomBottomAppBar(
//      textTheme: textTheme,
//      color: this.colorPalette.primaryColor,
//      fabLocation: FloatingActionButtonLocation.centerDocked,
//      showNotch: showNotch,
//      splashColor: this.colorPalette.accentColor,
//      navigationOption: navigationOption,
//      scaffoldFactory: this,
//      activeNotification: notificationActive,
//    );
  }

  FloatingActionButton buildFloatingActionButton(
      {@required Widget fabBody,
      String tooltip = "",
      String heroTag = "",
      Color backgroundColor,
      bool mini = false}) {
    return FloatingActionButton(
      heroTag: heroTag,
      onPressed: () =>
          this.scaffoldFactoryBehavior.onFloatingActionButtonPressed(),
      tooltip: tooltip,
      child: fabBody,
      mini: mini,
      backgroundColor: backgroundColor ?? this.colorPalette.accentColor,
    );
  }

  void updateAndroidFrameColor() async {
    if (this.gradientBackgroundColors == null ||
        this.gradientBackgroundColors.isEmpty) {
      throw Exception("");
    }

    if (Platform.isAndroid) {
      try {
        await FlutterStatusbarcolor.setStatusBarColor(
            this.gradientBackgroundColors[0]);
        await FlutterStatusbarcolor.setNavigationBarColor(
            this.gradientBackgroundColors[1]);
      } on Exception catch (e) {
        print(e);
      }
    }
  }

  void dispose() {
    _eventBusSubscription.cancel();
  }

  void showSnackBar({
    @required SnackBarMessageType messageType,
    @required bool iconVisibility,
    String message = "",
    Duration duration,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    Color iconColor = Colors.white,
    TextDirection textDirection = TextDirection.ltr,
  }) {
    IconData icon;
    switch (messageType) {
      case SnackBarMessageType.info:
        icon = Icons.info;
        break;
      case SnackBarMessageType.warning:
        icon = Icons.warning;
        break;
      case SnackBarMessageType.error:
        icon = Icons.error;
        break;
      case SnackBarMessageType.successful:
        icon = Icons.done;
        break;
      case SnackBarMessageType.failed:
        icon = Icons.close;
        break;
      case SnackBarMessageType.none:
        break;
    }

    final text = Text(
      message,
      style: this.textTheme.subhead.copyWith(color: textColor),
    );

    this.scaffoldKey.currentState.showSnackBar(
          SnackBar(
            backgroundColor: backgroundColor,
            duration: duration ?? Duration(seconds: 1),
            content: Directionality(
              textDirection: textDirection,
              child: iconVisibility
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(icon, color: iconColor),
                        SizedBox(width: 4.0),
                        text,
                      ],
                    )
                  : text,
            ),
          ),
        );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

abstract class ScaffoldFactoryBehaviors {
  void onBackButtonPressed();

  void onFloatingActionButtonPressed();

  Future onEventBusMessageReceived(dynamic event);
}

enum BackgroundType {
  normal,
  solidColor,
  gradient,
}

enum SnackBarMessageType {
  info,
  warning,
  error,
  successful,
  failed,
  none,
}

class MaterialPalette {
  final Color primaryColor;
  final Color darkPrimaryColor;
  final Color lightPrimaryColor;
  final Color secondaryColor;
  final Color accentColor;
  final Color textColor;
  final Color secondaryTextColor;
  final Color iconColor;
  final Color dividerColor;

  MaterialPalette({
    @required this.primaryColor,
    @required this.accentColor,
    this.secondaryColor,
    this.textColor,
    this.darkPrimaryColor,
    this.lightPrimaryColor,
    this.secondaryTextColor,
    this.iconColor,
    this.dividerColor,
  });
}
