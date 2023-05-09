import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:irish_locums/core/constants/app_asset.dart';
import 'package:irish_locums/core/constants/app_color.dart';
import 'package:irish_locums/features/availability/presentation/pages/availabilty_page.dart';
import 'package:irish_locums/features/home/presentation/pages/branches/branches_screen.dart';
import 'package:irish_locums/features/home/presentation/pages/jobs/jobs_screen.dart';
import 'package:irish_locums/features/home/presentation/pages/jobs/post_job_page.dart';
import 'package:irish_locums/features/home/presentation/pages/more/more_page.dart';
import 'package:irish_locums/features/home/presentation/pages/more/my_application_screen.dart';
import 'package:irish_locums/features/home/presentation/pages/shift_listing_page.dart';

class EmployerAppNavBar extends StatefulWidget {
  const EmployerAppNavBar({super.key});

  @override
  State<EmployerAppNavBar> createState() => _AppNavBarState();
}

class _AppNavBarState extends State<EmployerAppNavBar> {
  int _currentIndex = 0;
  List tabs = [
    const JobsScreen(),
    // const ShiftListingPage(),
    MyAplicationScreen(),
    const PostJobScreen(),
    const JobsScreen(),
    MorePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        showSelectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.white,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedItemColor: AppColors.primaryColor,
        currentIndex: _currentIndex,
        enableFeedback: true,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedLabelStyle: const TextStyle(
          color: AppColors.primaryColor,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        unselectedLabelStyle: const TextStyle(
          color: AppColors.grey,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: SvgPicture.asset(
                AppAssets.homeIcon,
                color: AppColors.grey,
                height: 20,
                width: 20,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: SvgPicture.asset(
                AppAssets.homeIcon,
                height: 20,
                width: 20,
                color: AppColors.primaryColor,
              ),
            ),
            label: 'Locums',
          ),
          BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(
                  bottom: 7,
                ),
                child: SvgPicture.asset(
                  AppAssets.applicationsIcon,
                  height: 20,
                  width: 20,
                ),
              ),
              activeIcon: Padding(
                padding: const EdgeInsets.only(
                  bottom: 7,
                ),
                child: SvgPicture.asset(
                  AppAssets.applicationsIcon,
                  height: 20,
                  width: 20,
                  color: AppColors.primaryColor,
                ),
              ),
              label: 'Applications'),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(
                bottom: 7,
              ),
              child: SvgPicture.asset(
                AppAssets.addJobIcon,
                width: 20,
                height: 20,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: SvgPicture.asset(
                AppAssets.addJobIcon,
                color: AppColors.primaryColor,
                width: 20,
                height: 20,
              ),
            ),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: SvgPicture.asset(
                AppAssets.jobsIcon,
                width: 20,
                height: 20,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.only(
                bottom: 7,
              ),
              child: SvgPicture.asset(
                AppAssets.jobsIcon,
                color: AppColors.primaryColor,
                width: 20,
                height: 20,
              ),
            ),
            label: 'Listings',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(
                bottom: 7,
              ),
              child: SvgPicture.asset(
                AppAssets.moreIcon,
                width: 20,
                height: 20,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.only(
                bottom: 7,
              ),
              child: SvgPicture.asset(
                AppAssets.moreIcon,
                color: AppColors.primaryColor,
                width: 20,
                height: 20,
              ),
            ),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
