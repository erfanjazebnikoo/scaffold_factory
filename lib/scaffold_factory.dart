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

  /// Appbar
  ScaffoldVisibility appBarVisibility;
  AppBar appBar;

  /// Floating Action Button
  ScaffoldVisibility floatingActionButtonVisibility =
      ScaffoldVisibility.invisible;
  Widget floatingActionButton;
  FloatingActionButtonLocation fabLocation =
      FloatingActionButtonLocation.endFloat;
  bool showNotch = true;

  /// Bottom Navigation Bar
  ScaffoldVisibility bottomNavigationBarVisibility =
      ScaffoldVisibility.invisible;
  Widget bottomNavigationBar;

  factory ScaffoldFactory(GlobalKey<ScaffoldState> scaffoldKey,
          MaterialPalette materialPalette) =>
      ScaffoldFactory._internal(scaffoldKey, materialPalette);

  ScaffoldFactory._internal(this.scaffoldKey, this.colorPalette);

  void init({
    BackgroundType backgroundType = BackgroundType.normal,
    ScaffoldVisibility appBarVisibility = ScaffoldVisibility.invisible,
    ScaffoldVisibility floatingActionButtonVisibility =
        ScaffoldVisibility.invisible,
    ScaffoldVisibility bottomNavigationBarVisibility =
        ScaffoldVisibility.invisible,
    Widget floatingActionButton,
    FloatingActionButtonLocation floatingActionButtonLocation,
    Widget appBar,
    Widget bottomNavigationBar,
  }) {
    this.backgroundType = backgroundType;
    this.appBarVisibility = appBarVisibility;
    this.floatingActionButtonVisibility = floatingActionButtonVisibility;
    this.bottomNavigationBarVisibility = bottomNavigationBarVisibility;
    this.floatingActionButton = floatingActionButton;
    this.fabLocation = floatingActionButtonLocation;
    this.appBar = appBar;
    this.bottomNavigationBar = bottomNavigationBar;
  }

  Widget build(Widget bodyWidget) {
    return Scaffold(
      key: scaffoldKey,
      primary: primary,
      appBar: isVisible(appBarVisibility) ? this.appBar : null,
      floatingActionButtonLocation: fabLocation,
      bottomNavigationBar: isVisible(bottomNavigationBarVisibility)
          ? this.bottomNavigationBar
          : null,
      floatingActionButton: isVisible(floatingActionButtonVisibility)
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
//        child: isVisible(nestedAppbarVisibility)
//            ? _buildNestedScrollView(bodyWidget)
//            : bodyWidget ?? Center(),
        child: bodyWidget,
      ),
    );
  }

  /// Simple implementation of AppBar which user can use it with
  /// easy configuration
  AppBar buildAppBar({
    @required ScaffoldVisibility titleVisibility,
    @required ScaffoldVisibility leadingVisibility,
    Widget titleWidget,
    Widget leadingWidget,
    Color backgroundColor,
    bool centerTitle = false,
  }) {
    return AppBar(
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      leading:
          ScaffoldFactory.isVisible(leadingVisibility) ? leadingWidget : null,
      title: ScaffoldFactory.isVisible(titleVisibility) ? titleWidget : null,
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

//  NestedScrollView _buildNestedScrollView(Widget bodyWidget) {
//    return NestedScrollView(
////                controller: scrollController ??
////                    ScrollController(initialScrollOffset: 0.0),
//      headerSliverBuilder: (BuildContext context, bool boxIsScrolled) {
//        return <Widget>[
//          CustomSliverAppBar(
//            showTabBar: isVisible(appBarTabBarVisibility),
//            tabList: this.tabList,
//            tabColor: this.colorPalette.primaryColor,
//            isScrollable: this.isTabScrollable,
//            showTitle: isVisible(appBarTitleVisibility),
//            tabController: tabController,
//            title: this.appBarTitle,
//            backButtonColor: backButtonColor,
//            floating: appBarFloating,
//          )
//        ];
//      },
//      body: bodyWidget ?? Center(),
//    );
//  }

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

  static bool isVisible(ScaffoldVisibility visibility) {
    if (visibility == ScaffoldVisibility.visible)
      return true;
    else if (visibility == ScaffoldVisibility.invisible)
      return false;
    else
      return null;
  }

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

enum ScaffoldVisibility {
  visible,
  invisible,
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
    this.secondaryColor,
    @required this.accentColor,
    this.textColor,
    this.darkPrimaryColor,
    this.lightPrimaryColor,
    this.secondaryTextColor,
    this.iconColor,
    this.dividerColor,
  });
}
