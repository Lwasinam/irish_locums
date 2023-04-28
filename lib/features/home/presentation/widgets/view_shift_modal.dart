import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:irish_locums/core/constants/app_asset.dart';
import 'package:irish_locums/core/constants/app_color.dart';
import 'package:irish_locums/core/constants/fonts.dart';
import 'package:irish_locums/core/navigators/route_name.dart';
import 'package:irish_locums/features/home/domain/jobs_model.dart';
import 'package:readmore/readmore.dart';

class ViewShiftModal extends StatefulWidget {
  ViewShiftModal({super.key, required this.job});
  JobModel job;

  @override
  State<ViewShiftModal> createState() => _ViewShiftModalState();
}

class _ViewShiftModalState extends State<ViewShiftModal> {
  @override
  Widget build(BuildContext context) {
    bool switchValue = true;

    return Container(
      height: MediaQuery.of(context).size.height * 0.95,
      color: AppColors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(15),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 17,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 14,
                      width: 14,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.darkGrey,
                          )),
                      child: const Center(
                        child: Icon(
                          Icons.close,
                          size: 12,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                  ),
                  TextBold(
                    'Adrian Dunne Pharmacy',
                    color: AppColors.tertiaryTextColor,
                    fontSize: 14,
                  ),
                  const SizedBox()
                ],
              ),
            ),
            const Gap(6),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.asset(AppAssets.clinicImage),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextBold(
                        widget.job.title,
                        fontSize: 14,
                        color: AppColors.grey900,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.shareIcon,
                            color: AppColors.blackColor,
                          ),
                          const Gap(32),
                          SvgPicture.asset(AppAssets.bookmarkIcon),
                        ],
                      ),
                    ],
                  ),
                  const Gap(15),
                  RichText(
                    text: TextSpan(
                        text: "\$20.31/hr",
                        style: const TextStyle(
                          color: AppColors.grey900,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                        children: [
                          TextSpan(
                            text: '/\$${widget.job.salary}(total)',
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          )
                        ]),
                  ),
                  const Gap(14),
                  TextBody(
                    DateFormat.yMMMMEEEEd().format(widget.job.startDate),
                    color: AppColors.grey,
                    fontSize: 12,
                  ),
                  const Gap(15),
                  Row(
                    children: [
                      SvgPicture.asset(AppAssets.directionIcon),
                      const Gap(10),
                      TextBody(
                        'View Direction',
                        color: AppColors.secondaryColor,
                      )
                    ],
                  ),
                  const Gap(23),
                  Container(
                    height: 1,
                    color: AppColors.grey200,
                  ),
                  const Gap(24),
                  TextBody(
                    'Overview',
                    color: AppColors.blackColor,
                    fontSize: 14,
                  ),
                  const Gap(22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextBody(
                            'Role',
                            color: AppColors.grey,
                            fontSize: 12,
                          ),
                          const Gap(3),
                          TextBody(
                            widget.job.title,
                            color: AppColors.blackColor,
                            fontSize: 14,
                          ),
                          const Gap(30),
                          TextBody(
                            'Time',
                            color: AppColors.grey,
                            fontSize: 12,
                          ),
                          const Gap(3),
                          TextBody(
                            '9:00am - 6:30pm',
                            color: AppColors.blackColor,
                            fontSize: 14,
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextBody(
                            'Job type',
                            color: AppColors.grey,
                            fontSize: 12,
                          ),
                          const Gap(3),
                          TextBody(
                            widget.job.jobType,
                            color: AppColors.blackColor,
                            fontSize: 14,
                          ),
                          const Gap(30),
                          TextBody(
                            'Location',
                            color: AppColors.grey,
                            fontSize: 12,
                          ),
                          const Gap(3),
                          TextBody(
                            'Lucan, Ireland',
                            color: AppColors.blackColor,
                            fontSize: 14,
                          )
                        ],
                      ),
                      const SizedBox(),
                    ],
                  ),
                  const Gap(22),
                  Container(
                    height: 1,
                    color: AppColors.grey200,
                  ),
                  const Gap(24),
                  TextBold(
                    'Job description & responsibilities',
                    color: AppColors.blackColor,
                    fontSize: 14,
                  ),
                  const Gap(22),
                  ReadMoreText(
                    widget.job.description,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grey600),
                    trimLines: 4,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'ReadMore',
                    trimExpandedText: ' ReadLess',
                    moreStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryColor),
                    colorClickableText: AppColors.secondaryColor,
                  ),
                  const Gap(22),
                  Container(
                    height: 1,
                    color: AppColors.grey200,
                  ),
                  const Gap(24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextBold(
                            'Set alert for similar openings',
                            color: AppColors.blackColor,
                            fontSize: 14,
                          ),
                          const Gap(14),
                          TextBody(
                            'Support Pharmacist, Dublin',
                            color: AppColors.grey600,
                            fontSize: 14,
                          )
                        ],
                      ),
                      CupertinoSwitch(
                        value: switchValue,
                        activeColor: AppColors.blue500,
                        onChanged: (value) {
                          setState(() {
                            switchValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                  const Gap(22),
                  Container(
                    height: 1,
                    color: AppColors.grey200,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(
                        context,
                        RouteName.shiftListingDirectionPage,
                      );
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: TextBody(
                          'Apply',
                          color: AppColors.tertiaryTextColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const Gap(30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
