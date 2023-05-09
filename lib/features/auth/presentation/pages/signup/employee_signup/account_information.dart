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

class AccountInformation extends StatefulWidget {
  const AccountInformation({Key? key}) : super(key: key);

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  var signupKey = GlobalKey<FormState>();
  FutureOr<bool> checkIfUserExists() async {
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
    return false;
  }

  storeDataAndNavigate(Map data) async {
    bool isUserExists = await checkIfUserExists();
    if (signupKey.currentState!.validate() && !isUserExists) {
      SharedPrefHelper prefHelper = SharedPrefHelper();
      await prefHelper.init();

      await prefHelper.setValue('emailAddress', emailController.text);
      Provider.of<AuthRepository>(context, listen: false)
          .userSignupData
          .addAll(data);

      Navigator.pushReplacementNamed(
        context,
        RouteName.signupEmployeeLocation,
      );
    }
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
                          'Employee Sign-Up',
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        gapSmall,
                        TextBody(
                          'Account Information',
                          fontWeight: FontWeight.bold,
                          color: AppColors.textGrey,
                          fontSize: 12,
                        ),
                        gapTiny,
                        gapSmall,
                        TextBody(
                          'First Name',
                          color: AppColors.black,
                          fontSize: 14,
                        ),
                        gapTiny,
                        InputField(
                            controller: firstNameController,
                            placeholder: '',
                            placeholderColor: AppColors.borderColor,
                            validator: validator),
                        gapSmall,
                        gapMedium,
                        TextBody(
                          'Last Name',
                          color: AppColors.black,
                          fontSize: 14,
                        ),
                        InputField(
                            controller: lastNameController,
                            placeholder: '',
                            placeholderColor: AppColors.borderColor,
                            validator: validator),
                        gapSmall,
                        gapMedium,
                        TextBody(
                          'Email Address',
                          color: AppColors.black,
                          fontSize: 14,
                        ),
                        gapTiny,
                        InputField(
                            controller: emailController,
                            placeholder: '',
                            placeholderColor: AppColors.borderColor,
                            validator: validator),
                        gapTiny,
                        TextBody(
                          'This field will be shown to registered employers only',
                          fontWeight: FontWeight.bold,
                          color: AppColors.hintColor,
                          fontSize: 12,
                        ),
                        gapSmall,
                        gapMedium,
                        TextBody(
                          'Phone Number',
                          color: AppColors.black,
                          fontSize: 14,
                        ),
                        gapTiny,
                        InputField(
                            controller: phoneNumberController,
                            placeholder: '',
                            placeholderColor: AppColors.borderColor,
                            validator: validator),
                        gapTiny,
                        TextBody(
                          'This field will be shown to registered employers only',
                          fontWeight: FontWeight.bold,
                          color: AppColors.hintColor,
                          fontSize: 12,
                        ),
                        gapLarge,
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 120),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BusyButton(
                            title: 'Next',
                            buttonColor: AppColors.yellow,
                            textColor: AppColors.black,
                            onTap: () {
                              storeDataAndNavigate({
                                'fullname':
                                    '${firstNameController.text} ${lastNameController.text}',
                                'email': emailController.text,
                                'phone': phoneNumberController.text,
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
                                    color: AppColors.indicatorActiveColor),
                                child: const Text(''),
                              ),
                              gapTiny,
                              Container(
                                width: 22,
                                height: 5,
                                decoration: const BoxDecoration(
                                    color: AppColors.indicatorActiveColor),
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
