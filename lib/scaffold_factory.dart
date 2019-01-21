import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:scaffold_factory/event_bus.dart';
import 'package:url_launcher/url_launcher.dart';

/// This is a Flutter plugin to build and customize the Flutter's scaffold
/// widget with simple and flexible configurations. Also, this plugin
/// provides various implementations of useful widgets that can be used in
/// UI design. The scaffold is a class provides APIs for showing drawers,
/// snack bars, and bottom sheets.
///
/// See also:
///
///  * [AppBar], which is a horizontal bar typically shown at the top of an app
///    using the [appBar] property.
///  * [BottomAppBar], which is a horizontal bar typically shown at the bottom
///    of an app using the [bottomNavigationBar] property.
///  * [FloatingActionButton], which is a circular button typically shown in the
///    bottom right corner of the app using the [floatingActionButton] property.
///  * [FloatingActionButtonLocation], which is used to place the
///    [floatingActionButton] within the [Scaffold]'s layout.
///  * [FloatingActionButtonAnimator], which is used to animate the
///    [floatingActionButton] from one [floatingActionButtonLocation] to
///    another.
///  * [Drawer], which is a vertical panel that is typically displayed to the
///    left of the body (and often hidden on phones) using the [drawer]
///    property.
///  * [BottomNavigationBar], which is a horizontal array of buttons typically
///    shown along the bottom of the app using the [bottomNavigationBar]
///    property.
///  * [SnackBar], which is a temporary notification typically shown near the
///    bottom of the app using the [ScaffoldState.showSnackBar] method.
///  * [BottomSheet], which is an overlay typically shown near the bottom of the
///    app. A bottom sheet can either be persistent, in which case it is shown
///    using the [ScaffoldState.showBottomSheet] method, or modal, in which case
///    it is shown using the [showModalBottomSheet] function.
///  * [ScaffoldState], which is the state associated with this widget.
///  * <https://material.google.com/layout/structure.html>
class ScaffoldFactory {
  GlobalKey<ScaffoldState> scaffoldKey;

  /// Whether this scaffold is being displayed at the top of the screen.
  ///
  /// If true then the height of the [appBar] will be extended by the height
  /// of the screen's status bar, i.e. the top padding for [MediaQuery].
  ///
  /// The default value of this property, like the default value of
  /// [AppBar.primary], is true.
  bool primary = true;

  /// Your state class can Implements [ScaffoldFactoryBehaviors] interface.
  /// This interface allows you to listen to the event bus and implement
  /// the onPressed method for back button and floating action button.
  ScaffoldFactoryBehaviors scaffoldFactoryBehavior;

  /// The Material Design color system can be used to create a color theme that
  /// reflects your brand or style.
  MaterialPalette colorPalette;

  /// Contains
  BackgroundType backgroundType;

  /// The list of gradient colors of the [Material] widget that underlies
  /// the entire Scaffold.
  List<Color> gradientBackgroundColors;

  /// The color of the [Material] widget that underlies the entire Scaffold.
  Color backgroundColor;

  /// Material design text theme.
  ///
  /// To obtain the current text theme, call [Theme.of] with the current
  /// [BuildContext] and read the [ThemeData.textTheme] property.
  TextTheme textTheme;

  /// An app bar to display at the top of the scaffold.
  /// Whether the [nestedAppBar] is being displayed at the screen.
  bool appBarVisibility;

  /// An app bar to display at the top of the scaffold.
  AppBar appBar;

  /// Whether the [nestedAppBar] is being displayed at the screen.
  ///
  /// Defaults to false.
  bool nestedAppBarVisibility;

  /// A nested app bar to display at the top of the scaffold.
  NestedScrollView nestedAppBar;

  /// Whether the [floatingActionButton] is being displayed at the screen.
  ///
  /// Defaults to false.
  bool floatingActionButtonVisibility = false;

  /// A button displayed floating above [body], usually in the bottom right
  /// corner.
  ///
  /// Typically a [FloatingActionButton].
  Widget floatingActionButton;

  /// Responsible for determining where the [floatingActionButton] should go.
  ///
  /// If null, the [ScaffoldState] will use the default location, [FloatingActionButtonLocation.endFloat].
  FloatingActionButtonLocation fabLocation =
      FloatingActionButtonLocation.endFloat;

  /// Whether the [bottomNavigationBar] is being displayed at the screen.
  ///
  /// Defaults to false.
  bool bottomNavigationBarVisibility = false;

  /// A bottom navigation bar to display at the bottom of the scaffold.
  ///
  /// The [bottomNavigationBar] is rendered below the [persistentFooterButtons]
  /// and the [body].
  Widget bottomNavigationBar;

  /// Drawer
  bool drawerVisibility;

  /// A panel displayed to the side of the [body], often hidden on mobile
  /// devices. Swipes in from either left-to-right ([TextDirection.ltr]) or
  /// right-to-left ([TextDirection.rtl])
  ///
  /// In the uncommon case that you wish to open the drawer manually, use the
  /// [ScaffoldState.openDrawer] function.
  ///
  /// Typically a [Drawer].
  Widget drawer;

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

  /// Initialize [ScaffoldFactory] with the scopes you want
  void init({
    @required bool appBarVisibility,
    @required bool floatingActionButtonVisibility,
    @required bool bottomNavigationBarVisibility,
    @required bool nestedAppBarVisibility,
    @required bool drawerVisibility,
    BackgroundType backgroundType = BackgroundType.normal,
    Widget floatingActionButton,
    FloatingActionButtonLocation floatingActionButtonLocation,
    AppBar appBar,
    NestedScrollView nestedAppBar,
    Widget drawer,
    Widget bottomNavigationBar,
    List<Color> gradientBackgroundColors,
    Color backgroundColor,
  }) {
    this.appBarVisibility = appBarVisibility;
    this.floatingActionButtonVisibility = floatingActionButtonVisibility;
    this.bottomNavigationBarVisibility = bottomNavigationBarVisibility;
    this.nestedAppBarVisibility = nestedAppBarVisibility;
    this.drawerVisibility = drawerVisibility;
    this.backgroundType = backgroundType;
    this.floatingActionButton = floatingActionButton;
    this.fabLocation = floatingActionButtonLocation;
    this.appBar = appBar;
    this.drawer = drawer;
    this.bottomNavigationBar = bottomNavigationBar;
    this.gradientBackgroundColors = gradientBackgroundColors;
    this.backgroundColor = backgroundColor;
  }

  Widget build(Widget bodyWidget) {
    if (appBarVisibility && nestedAppBarVisibility) {
      throw Exception(
          "Both app bar widget and nested app bar widget are being used simultaneously. \n" +
              "Make app bar widget or nested app bar widget invisible for resolving this issue.");
    }

    /// Creates a visual scaffold for material design widgets.
    return Scaffold(
      key: scaffoldKey,
      primary: primary,
      appBar: this.appBarVisibility ? this.appBar : null,
      floatingActionButtonLocation: fabLocation,
      bottomNavigationBar:
          this.bottomNavigationBarVisibility ? this.bottomNavigationBar : null,
      drawer: this.drawerVisibility ? this.drawer : null,
      floatingActionButton: this.floatingActionButtonVisibility
          ? this.floatingActionButton
          : null,
      body: Container(
        decoration: BoxDecoration(
          color: backgroundType == BackgroundType.solidColor
              ? backgroundColor ?? colorPalette.primaryColor
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
    Key key,
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
    List<Widget> actions,
  }) {
    bool useFlexible =
        !titleVisibility && !leadingVisibility && tabBarVisibility;
    return AppBar(
      key: key,
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      leading: leadingVisibility ? leadingWidget : null,
      title: titleVisibility ? titleWidget : null,
      centerTitle: centerTitle,
      actions: actions,
      flexibleSpace: useFlexible
          ? Container(
              alignment: Alignment.bottomCenter,
              child: TabBar(
                isScrollable: scrollableTab,
                tabs: tabWidgetList,
                controller: tabController,
                indicatorWeight: 4.0,
              ),
            )
          : null,
      bottom: !useFlexible && tabBarVisibility
          ? TabBar(
              isScrollable: scrollableTab,
              tabs: tabWidgetList,
              controller: tabController,
              indicatorWeight: 4.0,
            )
          : null,
    );
  }

  /// Simple implementation of Nested Scroll View which user can use it with
  /// easy configuration
  NestedScrollView buildNestedScrollView({
    Key key,
    @required bool titleVisibility,
    @required bool leadingVisibility,
    @required bool tabBarVisibility,
    @required Widget bodyWidget,
    bool scrollableTab,
    List<Widget> tabWidgetList,
    List<Widget> actions,
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
            key: key,
            backgroundColor: backgroundColor,
            leading: leadingVisibility ? leadingWidget : null,
            title: titleVisibility ? titleWidget : null,
            actions: actions,
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

  /// Simple implementation of Bottom Navigation Bar which user can use it with
  /// easy configuration
  Widget buildBottomNavigationBar({
    Key key,
    @required List<BottomNavigationBarItem> items,
    @required ValueChanged<int> onTap,
    int currentIndex = 0,
    Color color,
    double iconSize,
    BottomNavigationBarType type,
  }) {
    return BottomNavigationBar(
      onTap: onTap,
      currentIndex: currentIndex,
      items: items,
      fixedColor: color,
      iconSize: iconSize,
      type: type,
      key: key,
    );
  }

  /// Simple implementation of Bottom App Bar which user can use it with
  /// easy configuration
  Widget buildBottomAppBar({
    @required Widget child,
    bool showNotch = false,
    Color color,
    Color splashColor,
  }) {
    if (floatingActionButtonVisibility)
      this.fabLocation = FloatingActionButtonLocation.centerDocked;
    return BottomAppBar(
      shape: showNotch ? CircularNotchedRectangle() : null,
      color: color,
      child: child,
    );
  }

  /// Simple implementation of Floating Action Button which user can use it with
  /// easy configuration
  FloatingActionButton buildFloatingActionButton({
    @required Widget fabBody,
    String tooltip = "",
    String heroTag = "",
    Color backgroundColor,
    bool mini = false,
  }) {
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

  void updateAndroidFrameColor({
    Color statusBarColor,
    Color navigationBarColor,
  }) async {
    if (Platform.isAndroid) {
      try {
        if (statusBarColor != null)
          await FlutterStatusbarcolor.setStatusBarColor(statusBarColor);
        if (navigationBarColor != null)
          await FlutterStatusbarcolor.setNavigationBarColor(navigationBarColor);
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
    TextStyle style,
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
      style: style != null
          ? style.copyWith(color: textColor != null ? textColor : null)
          : this.textTheme.subhead.copyWith(color: textColor),
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
  Color primaryColor;
  Color darkPrimaryColor;
  Color lightPrimaryColor;
  Color secondaryColor;
  Color accentColor;
  Color textColor;
  Color secondaryTextColor;
  Color iconColor;
  Color dividerColor;

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
