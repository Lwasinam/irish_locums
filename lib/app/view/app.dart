import 'package:flutter/material.dart';
import 'package:irish_locums/core/constants/app_theme.dart';
import 'package:irish_locums/core/navigators/route_name.dart';
import 'package:irish_locums/core/navigators/router.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      title: 'Irish Locums',
      theme: AppTheme.themeData,
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
