import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:irish_locums/core/constants/app_asset.dart';
import 'package:irish_locums/core/constants/app_color.dart';
import 'package:irish_locums/core/constants/fonts.dart';
import 'package:irish_locums/features/auth/data/auth_repository.dart';
import 'package:irish_locums/features/home/data/jobs_repository.dart';
import 'package:irish_locums/features/home/domain/jobs_model.dart';
import 'package:irish_locums/features/home/presentation/widgets/apply_shift_dialog.dart';
import 'package:irish_locums/features/home/presentation/widgets/shift_filter_modal.dart';
import 'package:provider/provider.dart';

class ShiftListingWidget extends StatefulWidget {
  const ShiftListingWidget({super.key});

  @override
  State<ShiftListingWidget> createState() => _ShiftListingWidgetState();
}

class _ShiftListingWidgetState extends State<ShiftListingWidget> {
  bool getShift = true;
  String? errorMessage;
  List<JobModel> jobsList = [
    // JobModel(
    //     userId: '609c6f9f2e0e4c74b0a51701',
    //     title: "Senior Software Engineer",
    //     description:
    //         "We are looking for a senior software engineer to join our team.",
    //     payFrequency: "monthly",
    //     workHour: "fulltime",
    //     workPattern: "day shift",
    //     startDate: DateTime.now(),
    //     category: "Engineering",
    //     endDate: DateTime.now(),
    //     vacancies: 2,
    //     salary: 80000,
    //     jobType: "permanent",
    //     branchId: "609c6f9f2e0e4c74b0a51702",
    //     publishedDate: DateTime.now(),
    //     expiredDate: DateTime.now(),
    //     benefit: ["Health insurance", "Paid vacation"],
    //     requirements: [
    //       "5+ years of experience in software engineering",
    //       "Strong problem-solving skills"
    //     ],
    //     isActive: true,
    //     isDeleted: false,
    //     createdAt: DateTime.now()),
    // JobModel(
    //     userId: '609c6f9f2e0e4c74b0a51701',
    //     title: "Senior Software Engineer",
    //     description:
    //         "We are looking for a senior software engineer to join our team.",
    //     payFrequency: "monthly",
    //     workHour: "fulltime",
    //     workPattern: "day shift",
    //     startDate: DateTime.now(),
    //     category: "Engineering",
    //     endDate: DateTime.now(),
    //     vacancies: 2,
    //     salary: 80000,
    //     jobType: "permanent",
    //     branchId: "609c6f9f2e0e4c74b0a51702",
    //     publishedDate: DateTime.now(),
    //     expiredDate: DateTime.now(),
    //     benefit: ["Health insurance", "Paid vacation"],
    //     requirements: [
    //       "5+ years of experience in software engineering",
    //       "Strong problem-solving skills"
    //     ],
    //     isActive: true,
    //     isDeleted: false,
    //     createdAt: DateTime.now())
  ];

  getJobsList() async {
    if (mounted) {
      setState(() {
        getShift = true;
      });
    }

    var data =
        await Provider.of<JobsRepository>(context, listen: false).getJobs();

    if (data['status'] == true) {
      // ignore: use_build_context_synchronously
      jobsList = Provider.of<JobsRepository>(context, listen: false).jobsList;
    } else if (data['status'] == false) {
      errorMessage = 'an error occured';
    }
    setState(() {
      getShift = false;
    });
  }

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 1),
      getJobsList,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: getShift
          ? const FetchShiftProgressIndicator()
          : jobsList.isNotEmpty
              ? Column(
                  children: [
                    const Gap(15),
                    Container(
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
                                    hintText: 'Search shift',
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
                                  onTap: () {
                                    showModalBottomSheet(
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                      ),
                                      context: context,
                                      builder: (context) =>
                                          const ShiftFilterModal(),
                                    );
                                  },
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
                    Expanded(
                      child: ListView.builder(
                        itemCount: jobsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          JobModel job = jobsList[index];
                          return Container(
                            height: 196,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextBold(
                                        job.title,
                                        color: AppColors.tertiaryTextColor,
                                        fontSize: 14,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(AppAssets.shareIcon),
                                          const Gap(22),
                                          SvgPicture.asset(
                                              AppAssets.bookmarkIcon),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Gap(12),
                                  Row(
                                    children: [
                                      SvgPicture.asset(AppAssets.locationIcon),
                                      const Gap(10),
                                      TextBody(
                                        'Lucan, 10km from you',
                                        color: AppColors.grey,
                                        fontSize: 10,
                                      ),
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
                                        color: AppColors.grey,
                                        fontSize: 10,
                                      ),
                                      const Gap(8),
                                      Container(
                                        height: 3,
                                        width: 3,
                                        decoration: const BoxDecoration(
                                          color: AppColors.grey2,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const Gap(8),
                                      TextBody(
                                        '9:00 am - 6:30 pm',
                                        color: AppColors.grey,
                                        fontSize: 10,
                                      ),
                                    ],
                                  ),
                                  const Gap(12),
                                  Row(
                                    children: [
                                      SvgPicture.asset(AppAssets.home),
                                      const Gap(10),
                                      TextBody(
                                        'MPS',
                                        color: AppColors.grey,
                                        fontSize: 10,
                                      ),
                                    ],
                                  ),
                                  const Gap(12),
                                  RichText(
                                    text: TextSpan(
                                        text: "\$20.31/hr",
                                        style: const TextStyle(
                                          color: AppColors.tertiaryTextColor,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '/\$${job.salary}(total)',
                                            style: const TextStyle(
                                              color: AppColors.grey,
                                              fontSize: 9,
                                            ),
                                          )
                                        ]),
                                  ),
                                  const Gap(16),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return ApplyShiftDialog(
                                              job: job,
                                            );
                                          });
                                    },
                                    child: Container(
                                      height: 40,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: TextBody(
                                          'Apply',
                                          color: AppColors.tertiaryTextColor,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Text(
                    errorMessage ?? 'No Shifts Found',
                    style: GoogleFonts.lato(color: AppColors.tertiaryTextColor),
                  ),
                ),
    );
  }
}

class FetchShiftProgressIndicator extends StatelessWidget {
  const FetchShiftProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          SizedBox(
            height: 48.3,
            width: 48.3,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 4,
                color: AppColors.primaryColor,
                backgroundColor: AppColors.primaryColor.withOpacity(0.5),
              ),
            ),
          ),
          const Gap(18),
          TextSemiBold(
            'Fetching shift details',
            color: AppColors.tertiaryTextColor,
            fontSize: 16,
          )
        ],
      ),
    );
  }
}
