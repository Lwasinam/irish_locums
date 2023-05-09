import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:irish_locums/core/constants/app_asset.dart';
import 'package:irish_locums/core/constants/app_color.dart';
import 'package:irish_locums/core/constants/fonts.dart';
import 'package:irish_locums/core/navigators/route_name.dart';
import 'package:irish_locums/features/availability/presentation/widgets/app_bar_container.dart';
import 'package:irish_locums/features/home/data/appliactions_repository.dart';
import 'package:irish_locums/features/home/data/branches_repositiory.dart';
import 'package:irish_locums/features/home/domain/applications_model.dart';
import 'package:irish_locums/features/home/domain/jobs_model.dart';
import 'package:provider/provider.dart';

class MyAplicationScreen extends StatefulWidget {
  MyAplicationScreen(
      {super.key, this.ViewApplicationsForSpecificJob = false, this.jobModel});
  bool ViewApplicationsForSpecificJob;
  JobModel? jobModel;

  @override
  State<MyAplicationScreen> createState() => _MyAplicationScreenState();
}

class _MyAplicationScreenState extends State<MyAplicationScreen> {
  bool isLoading = false;
  String? errorMessage;

  var data;
  List<MyApplications> listOfApplications = [];
  getApplications() async {
    setState(() {
      isLoading = true;
    });

    if (widget.ViewApplicationsForSpecificJob) {
      data = await Provider.of<ApplicationsRepository>(context, listen: false)
          .getApplicationsForSpecificJob(widget.jobModel!.id!);
    } else {
      data = await Provider.of<ApplicationsRepository>(context, listen: false)
          .getApplications();
    }

    if (data['status'] == true) {
      setState(() {
        listOfApplications =
            Provider.of<ApplicationsRepository>(context, listen: false)
                .myApplicationsList;
      });
    } else if (data['status'] == false) {
      setState(() {
        errorMessage = 'An error occured';
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getApplications();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Stack(children: [
        const AppBarContainer(
          title: 'My Applications',
          subtitle: '',
          showBackIcon: true,
        ),
        isLoading
            ? Center(
                child: CircularProgressIndicator(
                  strokeWidth: 4,
                  color: AppColors.primaryColor,
                  backgroundColor: AppColors.primaryColor.withOpacity(0.5),
                ),
              )
            : listOfApplications.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(
                      top: 110,
                      left: 17,
                      right: 17,
                    ),
                    child: ListView.builder(
                      itemCount: listOfApplications.length,
                      itemBuilder: (BuildContext context, int index) {
                        MyApplications application = listOfApplications[index];
                        return MyApplicationItem(
                          title: 'Dun Laoghaire Pharmacy',
                          status: application.status,
                          image: AppAssets.folderIcon,
                          onTapView: () {
                            setState(() {
                              setState(() {
                                showActions = false;
                              });
                            });
                            Navigator.pushNamed(
                              context,
                              RouteName.viewMyApplicationWidget,
                            );
                          },
                          onTapDelete: () {},
                        );
                      },
                    ),
                  )
                : Center(
                    child: TextBody(
                      errorMessage ?? 'No applications found',
                      color: AppColors.tertiaryTextColor,
                      fontSize: 14,
                    ),
                  ),
      ]),
    );
  }
}

class MyApplicationItem extends StatefulWidget {
  const MyApplicationItem(
      {super.key,
      required this.title,
      required this.status,
      required this.image,
      required this.onTapView,
      required this.onTapDelete,
      this.showStatus = true,
      this.imgHeighht = 38.4,
      this.imgWidth = 48});
  final String title;
  final String status;
  final String image;
  final VoidCallback onTapView;
  final VoidCallback onTapDelete;
  final bool showStatus;
  final double imgHeighht;
  final double imgWidth;
  @override
  State<MyApplicationItem> createState() => _MyApplicationItemState();
}

bool showActions = false;

class _MyApplicationItemState extends State<MyApplicationItem> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 24,
          ),
          child: Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        widget.image,
                        height: widget.imgHeighht,
                        width: widget.imgWidth,
                        fit: BoxFit.fill,
                      ),
                      const Gap(8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextBold(
                            widget.title,
                            fontSize: 14,
                            color: AppColors.tertiaryTextColor,
                          ),
                          const Gap(4),
                          widget.showStatus
                              ? TextBody(
                                  'STATUS: ${widget.status}',
                                  color: AppColors.tertiaryTextColor
                                      .withOpacity(0.39),
                                  fontSize: 10,
                                )
                              : const SizedBox()
                        ],
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        showActions = !showActions;
                      });
                    },
                    child: Row(
                      children: [
                        TextBody(
                          'Actions',
                          color: AppColors.grey,
                          fontSize: 12,
                        ),
                        const Gap(11),
                        Icon(
                          showActions
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          size: 20,
                          color: AppColors.borderColor,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        showActions
            ? Padding(
                padding: const EdgeInsets.only(
                  top: 54,
                ),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 65,
                    width: 105,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: widget.onTapView,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppAssets.viewIconn,
                              ),
                              const Gap(13),
                              TextBody(
                                'View',
                                fontSize: 10,
                                color: AppColors.black,
                              )
                            ],
                          ),
                        ),
                        const Gap(15),
                        InkWell(
                          onTap: widget.onTapDelete,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppAssets.deleteIconn,
                              ),
                              const Gap(13),
                              TextBody(
                                'Delete',
                                fontSize: 10,
                                color: AppColors.black,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
