import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ScaffoldFactory {
  GlobalKey<ScaffoldState> scaffoldKey;
  ScaffoldFactoryButtonsBehavior buttonsBehavior;
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

  factory ScaffoldFactory(GlobalKey<ScaffoldState> scaffoldKey,
          MaterialPalette materialPalette) =>
      ScaffoldFactory._internal(scaffoldKey, materialPalette);

  ScaffoldFactory._internal(this.scaffoldKey, this.colorPalette);

  void init({
    BackgroundType backgroundType = BackgroundType.normal,
    bool appBarVisibility = false,
    bool floatingActionButtonVisibility = false,
    bool bottomNavigationBarVisibility = false,
    bool nestedAppBarVisibility = false,
    Widget floatingActionButton,
    FloatingActionButtonLocation floatingActionButtonLocation,
    AppBar appBar,
    Widget bottomNavigationBar,
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
    this.bottomNavigationBar = bottomNavigationBar;
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
//        child: bodyWidget,
      ),
    );
  }

  /// Simple implementation of App Bar which user can use it with
  /// easy configuration
  AppBar buildAppBar({
    @required bool titleVisibility,
    @required bool leadingVisibility,
    Widget titleWidget,
    Widget leadingWidget,
    Color backgroundColor,
    bool centerTitle = false,
  }) {
    return AppBar(
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      leading: leadingVisibility ? leadingWidget : null,
      title: titleVisibility ? titleWidget : null,
      centerTitle: centerTitle,

//      flexibleSpace: !isVisible(appBarTitleVisibility)
//          ? Column(
//              mainAxisAlignment: MainAxisAlignment.end,
//              children: [
//                isVisible(appBarTabBarVisibility)
//                    ? TabBar(
//                        isScrollable: this.isTabScrollable,
//                        tabs: this.tabList,
//                        controller: this.tabController,
//                        indicatorWeight: 4.0,
//                      )
//                    : null,
//              ],
//            )
//          : null,
//      bottom: isVisible(appBarTitleVisibility)
//          ? isVisible(appBarTabBarVisibility)
//              ? TabBar(
//                  isScrollable: this.isTabScrollable,
//                  tabs: this.tabList,
//                  controller: this.tabController,
//                  indicatorWeight: 4.0,
//                )
//              : null
//          : null,
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
  }) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: currentIndex,
      items: items,
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
      onPressed: () => this.buttonsBehavior.onFloatingActionButtonPressed(),
      tooltip: tooltip,
      child: fabBody,
      mini: mini,
      backgroundColor: backgroundColor ?? this.colorPalette.accentColor,
    );
  }

//  changeFrameColor() {
//    if (Platform.isAndroid) {
//      _changeStatusColor(this.colorPalette.primaryColor);
//      _changeNavigationColor(this.colorPalette.secondaryColor);
//    }
//  }
//
//  _changeStatusColor(Color color) async {
//    try {
//      await FlutterStatusbarcolor.setStatusBarColor(color);
//    } on PlatformException catch (e) {
//      print(e);
//    }
//  }
//
//  _changeNavigationColor(Color color) async {
//    try {
//      await FlutterStatusbarcolor.setNavigationBarColor(color);
//    } on PlatformException catch (e) {
//      print(e);
//    }
//  }

  void dispose() {
//    _notificationSubscription.cancel();
  }

//  void checkNotificationStatus() {
//    SharedPreferences.getInstance().then((SharedPreferences sp) {
//      notificationActive = sp.getBool("new_notification") ?? false;
//
//      if (notificationSeen) {
//        notificationActive = false;
//        notificationSeen = false;
//        sp.setBool("new_notification", notificationActive);
//      }
//    });
//  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

abstract class ScaffoldFactoryButtonsBehavior {
  void onBackButtonPressed();

  void onFloatingActionButtonPressed();
}

enum BackgroundType {
  normal,
  solidColor,
  gradient,
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
