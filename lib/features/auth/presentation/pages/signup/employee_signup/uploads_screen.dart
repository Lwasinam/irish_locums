import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:irish_locums/app/shared/app_bar.dart';
import 'package:irish_locums/app/shared/busy_button.dart';
import 'package:irish_locums/app/shared/shared_pref_helper.dart';
import 'package:irish_locums/core/constants/app_color.dart';
import 'package:irish_locums/core/constants/fonts.dart';
import 'package:irish_locums/core/constants/ui_helpers.dart';
import 'package:irish_locums/core/navigators/route_name.dart';
import 'package:irish_locums/features/auth/data/auth_repository.dart';
import 'package:irish_locums/features/auth/presentation/widgets/upload_widget.dart';
import 'package:irish_locums/features/home/home.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

class EmployeeUploads extends StatefulWidget {
  const EmployeeUploads({Key? key}) : super(key: key);

  @override
  State<EmployeeUploads> createState() => _EmployeeUploadsState();
}

class _EmployeeUploadsState extends State<EmployeeUploads> {
  bool isChecked = false;
  bool isLoading = false;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return AppColors.black;
  }

  storeDataAndNavigate(Map data) async {
    setState(() {});

    if (isChecked != false) {
      Provider.of<AuthRepository>(context, listen: false)
          .userSignupData
          .addAll(data);

      // log(Provider.of<AuthRepository>(context, listen: false)
      //     .userSignupData
      //     .toString());
      setState(() {
        isLoading = true;
      });
      Map? response =
          await Provider.of<AuthRepository>(context, listen: false).signup();

      if (response != null) {
        log(response.toString());
        setState(() {
          isLoading = false;
        });
        if (response['status'] == false) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response['msg']),
          ));
        } else if (response['status'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response['msg']),
          ));
          Navigator.pushReplacementNamed(
            context,
            RouteName.signin,
          );
        }
      } else {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('error occured'),
        ));
      }
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
            child: SizedBox(
              //height: MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top- MediaQuery.of(context).padding.top-44,
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
                        'Uploads',
                        fontWeight: FontWeight.bold,
                        color: AppColors.textGrey,
                        fontSize: 12,
                      ),
                      gapMedium,
                      gapSmall,
                      TextBody(
                        'Your Photo',
                        color: AppColors.black,
                        fontSize: 14,
                      ),
                      gapTiny,
                      UploadWidget(
                        fileName: 'image',
                      ),
                      gapSmall,
                      gapMedium,
                      TextBody(
                        'Garda Vetting',
                        color: AppColors.black,
                        fontSize: 14,
                      ),
                      gapTiny,
                      UploadWidget(
                        fileName: 'gardaVetting',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: isChecked,
                            fillColor:
                                MaterialStateProperty.resolveWith(getColor),
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                          gapTiny,
                          RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 14.0,
                                color: AppColors.textGrey,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'I agree to the ',
                                  style: TextStyle(fontSize: 12),
                                ),
                                TextSpan(
                                    text: 'Terms and Conditions',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.yellow,
                                      fontSize: 12,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                      gapLarge,
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        isLoading
                            ? SizedBox(
                                height: 48.3,
                                width: 48.3,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 4,
                                    color: AppColors.primaryColor,
                                    backgroundColor:
                                        AppColors.primaryColor.withOpacity(0.5),
                                  ),
                                ),
                              )
                            : BusyButton(
                                title: 'Create Account',
                                buttonColor: AppColors.secondaryColor,
                                textColor: AppColors.white,
                                onTap: () {
                                  storeDataAndNavigate({
                                    'vettingFile': '',
                                    'createdAt': DateTime.now().toString(),
                                    'updatedAt': ''
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
                                  color: AppColors.indicatorActiveColor),
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
        ));
  }
}
