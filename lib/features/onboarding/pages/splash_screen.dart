import 'dart:async';

import 'package:flutter/material.dart';
import 'package:irish_locums/app/shared/permissions.dart';
import 'package:irish_locums/app/shared/shared_pref_helper.dart';
import 'package:irish_locums/core/constants/app_asset.dart';
import 'package:irish_locums/core/constants/app_color.dart';
import 'package:irish_locums/core/navigators/route_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedIn = false;
  checkIfUserIsLoggedIn() async {
    SharedPrefHelper prefHelper = SharedPrefHelper();
    Permissions permissions = Permissions();
    await permissions.isEmployerOrEmployee();
    await prefHelper.init();
    if (prefHelper.getValue('token') != null) {
      if (mounted) {
        if (permissions.isEmployee) {
          Navigator.pushReplacementNamed(context, RouteName.appNavPage);
        } else if (permissions.isEmployer) {
          Navigator.pushReplacementNamed(context, RouteName.employerAppNavPage);
        }
      }
    } else if (prefHelper.getValue('token') == null) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, RouteName.onBoardingPage);
      }
    }
  }

  @override
  void initState() {
    checkIfUserIsLoggedIn();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(27),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: const AssetImage(AppAssets.background),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      AppColors.backgroundfade.withOpacity(0.5),
                      BlendMode.multiply))),
          child: const Center(
            child: Image(
              image: AssetImage(AppAssets.logo),
            ),
          ),
        ),
      ],
    );
  }
}
