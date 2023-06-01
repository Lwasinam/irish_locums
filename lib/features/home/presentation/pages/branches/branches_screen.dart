import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:irish_locums/core/constants/app_asset.dart';
import 'package:irish_locums/core/constants/app_color.dart';
import 'package:irish_locums/core/constants/fonts.dart';
import 'package:irish_locums/features/availability/presentation/widgets/app_bar_container.dart';
import 'package:irish_locums/features/home/data/branches_repositiory.dart';
import 'package:irish_locums/features/home/domain/branches_model.dart';
import 'package:irish_locums/features/home/presentation/widgets/loading_branch_widgets.dart';
import 'package:provider/provider.dart';

class BranchesScreen extends StatefulWidget {
  const BranchesScreen({super.key});

  @override
  State<BranchesScreen> createState() => _BranchesScreenState();
}

class _BranchesScreenState extends State<BranchesScreen> {
  bool getbrnaches = false;
  String? errorMessage;
  List<BranchModel> listOfBranches = [];
  getBranches() async {
    setState(() {
      getbrnaches = true;
    });
    var data = await Provider.of<BranchesRepository>(context, listen: false)
        .getBranches();

    if (data['status'] == true) {
      setState(() {
        listOfBranches = Provider.of<BranchesRepository>(context, listen: false)
            .branchesList;
      });
    } else if (data['status'] == false) {
      setState(() {
        errorMessage = 'An error occured';
      });
    }

    setState(() {
      getbrnaches = false;
    });
  }

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 1),
      getBranches,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Column(
        children: [
          const AppBarContainer(
            title: 'Branches',
            subtitle: 'Branches you’ve subscribed to would be shown here',
          ),
          const Gap(15),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 17,
            ),
            child: Container(
              height: 48,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    SvgPicture.asset(AppAssets.searchIcon),
                    const Gap(20),
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          log(value);
                          if (value != '') {
                            listOfBranches = listOfBranches
                                .where((branch) => branch.name
                                    .toLowerCase()
                                    .contains(value.toLowerCase()))
                                .toList();
                            setState(() {});
                          } else {
                            getBranches();
                            setState(() {});
                          }
                        },
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search Branches',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: AppColors.grey2,
                            )),
                      ),
                    ),
                    const Gap(10),
                  ],
                ),
              ),
            ),
          ),
          getbrnaches
              ? Expanded(
                  child: LoadingBranches(
                  title: 'Fetching Branches',
                ))
              : listOfBranches.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: listOfBranches.length,
                        itemBuilder: (BuildContext context, int index) {
                          BranchModel branch = listOfBranches[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 17,
                              vertical: 15,
                            ),
                            child: Container(
                              height: 138,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextBold(
                                      branch.name,
                                      color: AppColors.tertiaryTextColor,
                                      fontSize: 14,
                                    ),
                                    const Gap(9),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          AppAssets.locationIcon,
                                        ),
                                        const Gap(10),
                                        TextBody(
                                          '${branch.address}, 30km from you',
                                          color: AppColors.tertiaryTextColor
                                              .withOpacity(0.39),
                                          fontSize: 10,
                                        )
                                      ],
                                    ),
                                    const Gap(8),
                                    RichText(
                                      text: TextSpan(
                                        text: '\$ 20.31/hr',
                                        style: GoogleFonts.lato(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.tertiaryTextColor,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '\$161.04 (total)',
                                            style: GoogleFonts.lato(
                                              fontSize: 9,
                                              color: AppColors.tertiaryTextColor
                                                  .withOpacity(0.39),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Gap(8),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        height: 40,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                            child: TextBody(
                                          'Unsubscribe',
                                          fontSize: 14,
                                          color: AppColors.tertiaryTextColor,
                                        )),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Expanded(
                      child: Center(
                        child: TextBody(
                          errorMessage ?? 'No Branches',
                          fontSize: 14,
                          color: AppColors.tertiaryTextColor,
                        ),
                      ),
                    )
        ],
      ),
    );
  }
}
