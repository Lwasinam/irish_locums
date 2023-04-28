import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:irish_locums/app/shared/app_bar.dart';
import 'package:irish_locums/app/shared/busy_button.dart';
import 'package:irish_locums/app/shared/input_field.dart';
import 'package:irish_locums/core/constants/app_asset.dart';
import 'package:irish_locums/core/constants/app_color.dart';
import 'package:irish_locums/core/constants/fonts.dart';
import 'package:irish_locums/core/constants/ui_helpers.dart';
import 'package:irish_locums/core/navigators/route_name.dart';
import 'package:irish_locums/features/auth/data/authRepository.dart';
import 'package:provider/provider.dart';

class SignupUserAccount extends StatefulWidget {
  const SignupUserAccount({Key? key}) : super(key: key);

  @override
  State<SignupUserAccount> createState() => _SignupUserAccountState();
}

class _SignupUserAccountState extends State<SignupUserAccount> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassowrdController = TextEditingController();

  var signupKey = GlobalKey<FormState>();

  storeDataAndNavigate(Map data) {
    if (signupKey.currentState!.validate()) {
      Provider.of<AuthRepository>(context, listen: false)
          .userSignupData
          .addAll(data);

      Navigator.pushReplacementNamed(
        context,
        RouteName.signupUserCompany,
      );
    }
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
            child: Form(
              key: signupKey,
              child: SizedBox(
                // height: MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top- MediaQuery.of(context).padding.top-44,
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
                          'User Account',
                          fontWeight: FontWeight.bold,
                          color: AppColors.textGrey,
                          fontSize: 12,
                        ),
                        gapMedium,
                        gapSmall,
                        TextBody(
                          'Username',
                          color: AppColors.black,
                          fontSize: 14,
                        ),
                        gapTiny,
                        InputField(
                            controller: usernameController,
                            placeholder: '',
                            placeholderColor: AppColors.borderColor,
                            validator: (value) {
                              if (value == '') {
                                return 'input username';
                              }
                            }),
                        gapSmall,
                        gapMedium,
                        TextBody(
                          'Password',
                          color: AppColors.black,
                          fontSize: 14,
                        ),
                        InputField(
                          controller: passwordController,
                          placeholder: '**********',
                          placeholderColor: AppColors.borderColor,
                          password: true,
                          validator: (value) {
                            if (value == null) {
                              return 'input password';
                            } else if (value!.length < 8) {
                              return 'password must be atleast 8 characters long';
                            }
                          },
                        ),
                        gapTiny,
                        TextBody(
                          'Password should be atleast 8 characters long',
                          fontWeight: FontWeight.bold,
                          color: AppColors.hintColor,
                          fontSize: 12,
                        ),
                        gapSmall,
                        gapMedium,
                        TextBody(
                          'Confirm Password ',
                          color: AppColors.black,
                          fontSize: 14,
                        ),
                        gapTiny,
                        InputField(
                          controller: null,
                          placeholder: '**********',
                          placeholderColor: AppColors.borderColor,
                          password: true,
                          validator: (value) {
                            if (value == '') {
                              return 'input passowrd';
                            } else if (value != passwordController.text) {
                              return 'passwords not the same';
                            }
                          },
                        ),
                        gapMedium,
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
                                'username': usernameController.text,
                                'password': passwordController.text
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
