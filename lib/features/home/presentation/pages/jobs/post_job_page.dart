import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:irish_locums/app/shared/busy_button.dart';
import 'package:irish_locums/app/shared/input_field.dart';
import 'package:irish_locums/app/shared/shared_pref_helper.dart';
import 'package:irish_locums/core/constants/app_color.dart';
import 'package:irish_locums/core/constants/fonts.dart';
import 'package:irish_locums/core/constants/ui_helpers.dart';
import 'package:irish_locums/features/availability/presentation/widgets/app_bar_container.dart';
import 'package:irish_locums/features/home/data/jobs_repository.dart';
import 'package:irish_locums/features/home/domain/jobs_model.dart';
import 'package:provider/provider.dart';

class PostJobScreen extends StatefulWidget {
  const PostJobScreen({super.key});

  @override
  State<PostJobScreen> createState() => _PostJobState();
}

class _PostJobState extends State<PostJobScreen> {
  TextEditingController payTextController = TextEditingController(text: '£');
  final _category = [
    'DOCTOR',
    'HEALTHCARE ASSISTANT',
    'NURSE',
    'PHARMACIST',
    'PHARMACY TECHNICIAN',
    'SOCIAL CARE WORKER'
  ];
  final _jobType = [
    'APPRENTICESHIP',
    'CONTRACT',
    'FIXED',
    'PART-TIME',
    'TEMPORARY',
    'PERMANENT'
  ];
  DateTime selectedDate = DateTime.now();
  final TextEditingController _startDateController =
      TextEditingController(text: 'dd/mm/yy');
  final TextEditingController _endDateController =
      TextEditingController(text: 'dd/mm/yy');
  final TextEditingController _startTimeController =
      TextEditingController(text: 'hh:mm');
  final TextEditingController _endTimeController =
      TextEditingController(text: 'hh:mm');
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _jobDescriptionController =
      TextEditingController();
  final TextEditingController _jobBenefitsController = TextEditingController();
  final TextEditingController _jobRequirementsController =
      TextEditingController();

  String? userId;
  getUserId() async {
    SharedPrefHelper prefHelper = SharedPrefHelper();
    await prefHelper.init();

// Get value
    userId = prefHelper.getValue('userId');
  }

  Future _selectTime(BuildContext context,
      {bool startTime = false, bool endTime = false}) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && startTime == true) {
      setState(() {
        _startTimeController.text =
            '${picked.hour.toString()}:${picked.minute.toString()}';
      });
    } else if (picked != null && endTime == true) {
      setState(() {
        _endTimeController.text =
            '${picked.hour.toString()}:${picked.minute.toString()}';
      });
    }
  }

  Future _selectDate(BuildContext context,
      {bool startDate = false, bool endDate = false}) async {
    if (_startDateController.text == 'dd/mm/yy' && endDate == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select start date first'),
        ),
      );
      return;
    } else {
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          initialDatePickerMode: DatePickerMode.day,
          firstDate: DateTime(2015),
          lastDate: DateTime(2101));
      if (picked != null && startDate == true) {
        setState(() {
          selectedDate = picked;
          _startDateController.text = DateFormat.yMd().format(selectedDate);
        });
      } else if (picked != null &&
          endDate == true &&
          picked.isBefore(DateFormat.yMd().parse(_startDateController.text)) ==
              false) {
        setState(() {
          selectedDate = picked;
          _endDateController.text = DateFormat.yMd().format(selectedDate);
        });
      }
    }
  }

  bool isAllFieldsFilled() {
    if (_jobTitleController.text == '' ||
        _jobDescriptionController.text == '' ||
        _startDateController.text == 'dd/mm/yy' ||
        _endDateController.text == 'dd/mm/yy' ||
        _startTimeController.text == 'hh:mm' ||
        _endTimeController.text == 'hh:mm' ||
        selectedCategory == null ||
        selectedJobType == null ||
        payTextController.text == '£') {
      return false;
    } else {
      return true;
    }
  }

  postJob(JobModel job) async {
    setState(() {
      isLoading = true;
    });
    Map response =
        await Provider.of<JobsRepository>(context, listen: false).postJob(job);

    if (response['status'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Job posted successfully'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Job posting failed'),
        ),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  String? selectedCategory;
  String? selectedJobType;
  bool isLoading = false;
  @override
  void initState() {
    getUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const AppBarContainer(
          title: 'Jobs',
          subtitle: 'Post a Job',
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            children: [
              TextBody(
                'Job Title',
                color: AppColors.black,
                fontSize: 14,
              ),
              gapTiny,
              InputField(
                controller: _jobTitleController,
                placeholder: '',
                placeholderColor: AppColors.borderColor,
                onChanged: (vale) {
                  setState(() {});
                },
              ),
              gapMedium,
              gapSmall,
              TextBody(
                'Job Type',
                color: AppColors.black,
                fontSize: 14,
              ),
              gapTiny,
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(border: InputBorder.none),
                    dropdownColor: AppColors.backgroundLightBlue,
                    onChanged: (String? val) {
                      setState(() {});
                      selectedJobType = val!.toLowerCase();
                    },
                    items: _jobType.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                  ),
                ),
              ),
              gapTiny,
              selectedCategory == null
                  ? const Text(
                      'Empty field',
                      style: TextStyle(color: AppColors.red),
                    )
                  : const SizedBox(),
              gapMedium,
              gapSmall,
              TextBody(
                'Job Category',
                color: AppColors.black,
                fontSize: 14,
              ),
              gapTiny,
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(border: InputBorder.none),
                    dropdownColor: AppColors.backgroundLightBlue,
                    onChanged: (String? val) {
                      setState(() {});
                      selectedCategory = val!.toLowerCase();
                    },
                    items: _category.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                  ),
                ),
              ),
              gapTiny,
              selectedCategory == null
                  ? const Text(
                      'Empty field',
                      style: TextStyle(color: AppColors.red),
                    )
                  : const SizedBox(),
              gapMedium,
              gapSmall,
              TextBody(
                'Job Description',
                color: AppColors.black,
                fontSize: 14,
              ),
              gapTiny,
              InputField(
                controller: _jobDescriptionController,
                placeholder: '',
                maxLines: 5,
                placeholderColor: AppColors.borderColor,
                onChanged: (vale) {
                  setState(() {});
                },
              ),
              gapTiny,
              TextBody(
                'Give a detailed description of the job and any other extra information which  relates to the job.',
                color: AppColors.black,
                fontSize: 14,
              ),
              gapMedium,
              gapSmall,
              TextBody(
                'Job Benefits',
                color: AppColors.black,
                fontSize: 14,
              ),
              gapTiny,
              InputField(
                controller: _jobBenefitsController,
                placeholder: '',
                maxLines: 5,
                placeholderColor: AppColors.borderColor,
                onChanged: (vale) {
                  setState(() {});
                },
              ),
              gapTiny,
              TextBody(
                'Seperate them with a comma (,)',
                color: AppColors.red,
                fontSize: 14,
              ),
              gapMedium,
              gapSmall,
              TextBody(
                'Job Requirements',
                color: AppColors.black,
                fontSize: 14,
              ),
              gapTiny,
              InputField(
                controller: _jobRequirementsController,
                placeholder: '',
                maxLines: 5,
                placeholderColor: AppColors.borderColor,
                onChanged: (vale) {
                  setState(() {});
                },
              ),
              gapTiny,
              TextBody(
                'Seperate them with a comma (,)',
                color: AppColors.red,
                fontSize: 14,
              ),
              gapMedium,
              TextBody('Job duration', color: AppColors.black, fontSize: 16),
              gapMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      _selectDate(context, startDate: true);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextBody(
                          'Start ',
                          color: AppColors.black,
                          fontSize: 14,
                        ),
                        gapTiny,
                        Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.borderColor),
                          ),
                          child: Center(child: Text(_startDateController.text)),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context, endDate: true),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextBody(
                          'End ',
                          color: AppColors.black,
                          fontSize: 14,
                        ),
                        gapTiny,
                        Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.borderColor),
                          ),
                          child: Center(child: Text(_endDateController.text)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              gapLarge,
              TextBody(
                'Job time',
                fontSize: 16,
                color: AppColors.black,
              ),
              gapMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => _selectTime(context, startTime: true),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextBody(
                          'From',
                          color: AppColors.black,
                          fontSize: 14,
                        ),
                        gapTiny,
                        Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.borderColor),
                          ),
                          child: Center(child: Text(_startTimeController.text)),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selectTime(context, endTime: true),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextBody(
                          'To',
                          color: AppColors.black,
                          fontSize: 14,
                        ),
                        gapTiny,
                        Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.borderColor),
                          ),
                          child: Center(child: Text(_endTimeController.text)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              gapMedium,
              gapSmall,
              TextBody(
                'Pay',
                color: AppColors.black,
                fontSize: 14,
              ),
              gapTiny,
              InputField(
                controller: payTextController,
                placeholder: '',
                placeholderColor: AppColors.borderColor,
                onChanged: (vale) {
                  setState(() {});
                },
              ),
              gapMedium,
              isLoading
                  ? Center(
                      child: SizedBox(
                        height: 50.3,
                        width: 50.3,
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 4,
                            color: AppColors.primaryColor,
                            backgroundColor:
                                AppColors.primaryColor.withOpacity(0.5),
                          ),
                        ),
                      ),
                    )
                  : BusyButton(
                      title: 'Post Job',
                      buttonColor: isAllFieldsFilled()
                          ? AppColors.yellow
                          : AppColors.grey,
                      textColor: AppColors.black,
                      onTap: isAllFieldsFilled()
                          ? () {
                              postJob(JobModel(
                                  id: '',
                                  userId: userId!,
                                  title: _jobTitleController.text,
                                  description: _jobDescriptionController.text,
                                  payFrequency: 'monthly',
                                  workHour: selectedJobType!,
                                  workPattern: 'day shift',
                                  startDate: DateFormat.yMd()
                                      .parse(_startDateController.text),
                                  category: selectedCategory!,
                                  endDate: DateFormat.yMd()
                                      .parse(_endDateController.text),
                                  vacancies: 2,
                                  salary: int.parse(payTextController.text
                                      .replaceFirst('£', '')),
                                  jobType: selectedJobType!,
                                  // branchId: userId!,
                                  publishedDate: DateTime.now(),
                                  expiredDate: DateTime.utc(2028),
                                  benefit:
                                      _jobBenefitsController.text.split(','),
                                  requirements: _jobRequirementsController.text
                                      .split(','),
                                  isActive: true,
                                  isDeleted: false,
                                  createdAt: DateTime.now()));
                            }
                          : () {},
                    ),
            ],
          ),
        ),
      ],
    ));
  }
}
