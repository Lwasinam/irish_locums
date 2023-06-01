import 'dart:async';

import 'package:flutter/material.dart';
import 'package:irish_locums/app/shared/app_bar.dart';
import 'package:irish_locums/app/shared/busy_button.dart';
import 'package:irish_locums/app/shared/input_field.dart';
import 'package:irish_locums/app/shared/shared_pref_helper.dart';
import 'package:irish_locums/core/constants/app_color.dart';
import 'package:irish_locums/core/constants/fonts.dart';
import 'package:irish_locums/core/constants/ui_helpers.dart';
import 'package:irish_locums/core/navigators/route_name.dart';
import 'package:irish_locums/features/auth/data/auth_repository.dart';
import 'package:provider/provider.dart';

class SignupCompany extends StatefulWidget {
  const SignupCompany({Key? key}) : super(key: key);

  @override
  State<SignupCompany> createState() => _SignupCompanyState();
}

class _SignupCompanyState extends State<SignupCompany> {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController companyWebsiteController =
      TextEditingController(text: 'https://');
  bool isChecking = false;

  var signupKey = GlobalKey<FormState>();

  storeDataAndNavigate(Map data) async {
    bool isUserExists = await checkIfUserExists();
    if (signupKey.currentState!.validate() && !isUserExists) {
      SharedPrefHelper prefHelper = SharedPrefHelper();
      await prefHelper.init();
      await prefHelper.setValue('emailAddress', emailController.text);
      Provider.of<AuthRepository>(context, listen: false)
          .userSignupData
          .addAll(data);

      Navigator.pushNamed(
        context,
        RouteName.signupUserUpload,
      );
    }
  }

  FutureOr<bool> checkIfUserExists() async {
    setState(() {
      isChecking = true;
    });
    Map? response = await Provider.of<AuthRepository>(context, listen: false)
        .checkIfUserExists(emailController.text);
    if (response != null) {
      if (response['status'] == false) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response['msg']),
        ));
        return true;
      } else if (response['msg'] == null) {
        return false;
      }
    }
    setState(() {
      isChecking = false;
    });
    return false;
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'empty field!!!!!';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.white,
        appBar: const IrishAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: SizedBox(
              // height: MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top- MediaQuery.of(context).padding.top-44,
              child: Form(
                key: signupKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        gapMedium,
                        gapSmall,
                        H1(
                          'Employer Sign-Up',
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        gapSmall,
                        TextBody(
                          'Company',
                          fontWeight: FontWeight.bold,
                          color: AppColors.textGrey,
                          fontSize: 12,
                        ),
                        gapMedium,
                        gapSmall,
                        TextBody(
                          'Email',
                          color: AppColors.black,
                          fontSize: 14,
                        ),
                        gapTiny,
                        InputField(
                            controller: emailController,
                            placeholder: '',
                            placeholderColor: AppColors.borderColor,
                            validator: validator),
                        gapSmall,
                        gapMedium,
                        TextBody(
                          'Company Name',
                          color: AppColors.black,
                          fontSize: 14,
                        ),
                        InputField(
                            controller: companyNameController,
                            placeholder: '',
                            placeholderColor: AppColors.borderColor,
                            validator: validator),
                        gapSmall,
                        gapMedium,
                        TextBody(
                          'Company Website',
                          color: AppColors.black,
                          fontSize: 14,
                        ),
                        gapTiny,
                        InputField(
                            controller: companyWebsiteController,
                            placeholder: 'https://',
                            placeholderColor: AppColors.borderColor,
                            validator: validator),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 120),
                      child: isChecking
                          ? Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 4,
                                color: AppColors.primaryColor,
                                backgroundColor:
                                    AppColors.primaryColor.withOpacity(0.5),
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                BusyButton(
                                  title: 'Next',
                                  buttonColor: AppColors.yellow,
                                  textColor: AppColors.black,
                                  onTap: () {
                                    storeDataAndNavigate({
                                      'company_name':
                                          companyNameController.text,
                                      'email': emailController.text,
                                      'company_website':
                                          companyWebsiteController.text
                                    });
                                  },
                                ),
                                gapMedium,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 22,
                                      height: 5,
                                      decoration: const BoxDecoration(
                                          color:
                                              AppColors.indicatorActiveColor),
                                      child: const Text(''),
                                    ),
                                    gapTiny,
                                    Container(
                                      width: 22,
                                      height: 5,
                                      decoration: const BoxDecoration(
                                          color:
                                              AppColors.indicatorActiveColor),
                                      child: const Text(''),
                                    ),
                                    gapTiny,
                                    Container(
                                      width: 22,
                                      height: 5,
                                      decoration: const BoxDecoration(
                                          color: AppColors.dotColor),
                                      child: const Text(''),
                                    ),
                                    gapTiny,
                                    Container(
                                      width: 22,
                                      height: 5,
                                      decoration: const BoxDecoration(
                                          color: AppColors.dotColor),
                                      child: const Text(''),
                                    ),
                                    gapTiny,
                                    Container(
                                      width: 22,
                                      height: 5,
                                      decoration: const BoxDecoration(
                                          color: AppColors.dotColor),
                                      child: const Text(''),
                                    ),
                                  ],
                                )
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
