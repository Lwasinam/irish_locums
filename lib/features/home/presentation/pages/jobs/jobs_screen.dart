import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:irish_locums/core/constants/app_asset.dart';
import 'package:irish_locums/core/constants/app_color.dart';
import 'package:irish_locums/core/constants/fonts.dart';
import 'package:irish_locums/core/constants/ui_helpers.dart';
import 'package:irish_locums/features/auth/data/authRepository.dart';
import 'package:irish_locums/features/availability/presentation/widgets/app_bar_container.dart';
import 'package:irish_locums/features/home/data/jobs_repository.dart';
import 'package:irish_locums/features/home/domain/jobs_model.dart';
import 'package:irish_locums/features/home/presentation/widgets/job_view_widget.dart';
import 'package:irish_locums/features/home/presentation/widgets/widgets.dart';
import 'package:provider/provider.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  bool gettingJobs = false;
  String? errorMessage;
  List<JobModel> jobsList = [
    JobModel(
        userId: "609c6f9f2e0e4c74b0a51701",
        title: "Senior Software Engineer",
        description:
            "We are looking for a senior software engineer to join our team.",
        payFrequency: "monthly",
        workHour: "fulltime",
        workPattern: "day shift",
        startDate: DateTime.now(),
        category: "Engineering",
        endDate: DateTime.now(),
        vacancies: 2,
        salary: 80000,
        jobType: "permanent",
        branchId: "609c6f9f2e0e4c74b0a51702",
        publishedDate: DateTime.now(),
        expiredDate: DateTime.now(),
        benefit: ["Health insurance", "Paid vacation"],
        requirements: [
          "5+ years of experience in software engineering",
          "Strong problem-solving skills"
        ],
        isActive: true,
        isDeleted: false,
        createdAt: DateTime.now()),
    JobModel(
        userId: "609c6f9f2e0e4c74b0a51701",
        title: "Senior Software Engineer",
        description:
            "We are looking for a senior software engineer to join our team.",
        payFrequency: "monthly",
        workHour: "fulltime",
        workPattern: "day shift",
        startDate: DateTime.now(),
        category: "Engineering",
        endDate: DateTime.now(),
        vacancies: 2,
        salary: 80000,
        jobType: "permanent",
        branchId: "609c6f9f2e0e4c74b0a51702",
        publishedDate: DateTime.now(),
        expiredDate: DateTime.now(),
        benefit: ["Health insurance", "Paid vacation"],
        requirements: [
          "5+ years of experience in software engineering",
          "Strong problem-solving skills"
        ],
        isActive: true,
        isDeleted: false,
        createdAt: DateTime.now())
  ];

  getJobsList() async {
    setState(() {
      gettingJobs = true;
    });
    var data =
        await Provider.of<JobsRepository>(context, listen: false).getJobs();

    if (data['status'] == true) {
      // jobsList = Provider.of<JobsRepository>(context, listen: false).jobsList;
    } else if (data['status'] == false) {
      errorMessage = 'an error occured';
    }
    setState(() {
      gettingJobs = false;
    });
  }

  @override
  void initState() {
    getJobsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: Column(
        children: [
          const AppBarContainer(
            title: 'Jobs',
            subtitle: '',
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
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search Jobs',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: AppColors.grey2,
                            )),
                      ),
                    ),
                    const Gap(10),
                    Row(
                      children: [
                        Container(
                          width: 1,
                          height: 35,
                          color: AppColors.grey2,
                        ),
                        const Gap(20),
                        InkWell(
                          onTap: () {},
                          child: SvgPicture.asset(
                            AppAssets.filterIcon,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          gettingJobs
              ? Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 4,
                          color: AppColors.primaryColor,
                          backgroundColor:
                              AppColors.primaryColor.withOpacity(0.5),
                        ),
                      ),
                      gapTiny,
                      TextSemiBold(
                        'Loading Jobs',
                        color: AppColors.tertiaryTextColor,
                        fontSize: 16,
                      )
                    ],
                  ),
                )
              : jobsList.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: jobsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          JobModel job = jobsList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 17),
                            child: Container(
                              height: 196,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 22,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextBold(
                                      job.title,
                                      color: AppColors.tertiaryTextColor,
                                      fontSize: 14,
                                    ),
                                    const Gap(12),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                            AppAssets.locationIcon),
                                        const Gap(10),
                                        TextBody(
                                          'Dublin, 30km from you',
                                          fontSize: 10,
                                          color: AppColors.tertiaryTextColor
                                              .withOpacity(0.39),
                                        )
                                      ],
                                    ),
                                    const Gap(12),
                                    Row(
                                      children: [
                                        SvgPicture.asset(AppAssets.timeIcon),
                                        const Gap(10),
                                        TextBody(
                                          DateFormat.yMMMMEEEEd()
                                              .format(job.startDate),
                                          fontSize: 10,
                                          color: AppColors.tertiaryTextColor
                                              .withOpacity(0.39),
                                        )
                                      ],
                                    ),
                                    const Gap(12),
                                    Row(
                                      children: [
                                        SvgPicture.asset(AppAssets.home),
                                        const Gap(10),
                                        TextBody(
                                          'Dun Laoghaire - ${job.jobType}',
                                          fontSize: 10,
                                          color: AppColors.tertiaryTextColor
                                              .withOpacity(0.39),
                                        )
                                      ],
                                    ),
                                    const Gap(12),
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
                                            text: '\$${job.salary} (total)',
                                            style: GoogleFonts.lato(
                                              fontSize: 9,
                                              color: AppColors.tertiaryTextColor
                                                  .withOpacity(0.39),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Gap(12),
                                    InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                            isDismissible: false,
                                            isScrollControlled: true,
                                            context: context,
                                            builder: (context) {
                                              return JobViewWidget(
                                                job: job,
                                              );
                                            });
                                      },
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
                                          'View',
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
                      child: Text(
                        errorMessage ?? 'No Jobs Found',
                        style: GoogleFonts.lato(
                            color: AppColors.tertiaryTextColor),
                      ),
                    ))
        ],
      ),
    );
  }
}
