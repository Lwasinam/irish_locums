import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:irish_locums/app/shared/app_bar.dart';
import 'package:irish_locums/app/shared/busy_button.dart';
import 'package:irish_locums/app/shared/input_field.dart';
import 'package:irish_locums/core/constants/app_color.dart';
import 'package:irish_locums/core/constants/fonts.dart';
import 'package:irish_locums/core/constants/ui_helpers.dart';
import 'package:irish_locums/core/navigators/route_name.dart';
import 'package:irish_locums/features/auth/data/auth_repository.dart';
import 'package:provider/provider.dart';

class AdditionalInfo extends StatefulWidget {
  const AdditionalInfo({Key? key}) : super(key: key);

  @override
  State<AdditionalInfo> createState() => _AdditionalInfoState();
}

class _AdditionalInfoState extends State<AdditionalInfo> {
  final _countyDropdown = [
    'MPS',
    'McLernons',
    'QuickScript',
    'QuickScript.net',
    'Touchstore'
  ];
  bool isChecked = false;
  bool isLoading = false;
  String? selectedDispensingSoftware;
  final TextEditingController _pharmacyRegNumController =
      TextEditingController();

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return AppColors.yellow;
  }

  storeDataAndNavigate(Map data) async {
    setState(() {});
    if (isChecked != false &&
        selectedDispensingSoftware != null &&
        _pharmacyRegNumController.text != '') {
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
                        'Additional Info',
                        fontWeight: FontWeight.bold,
                        color: AppColors.textGrey,
                        fontSize: 12,
                      ),
                      gapMedium,
                      gapSmall,
                      TextBody(
                        'Pharmacy Dispensing Software',
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
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                            dropdownColor: AppColors.backgroundLightBlue,
                            onChanged: (val) {
                              setState(() {
                                selectedDispensingSoftware = val.toString();
                              });
                            },
                            items: _countyDropdown.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      selectedDispensingSoftware == null
                          ? const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Please select a dispensing software',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            )
                          : Container(),
                      gapSmall,
                      gapMedium,
                      TextBody(
                        'Pharmacy Registration Number',
                        color: AppColors.black,
                        fontSize: 14,
                      ),
                      gapTiny,
                      InputField(
                        controller: _pharmacyRegNumController,
                        placeholder: '',
                        placeholderColor: AppColors.borderColor,
                        onChanged: (val) {
                          setState(() {});
                        },
                      ),
                      _pharmacyRegNumController.text == ''
                          ? const Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                'Please enter your pharmacy registration number',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                ),
                              ),
                            )
                          : Container(),
                      gapMedium,
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
                  isLoading
                      ? Center(
                          child: SizedBox(
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
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 120),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BusyButton(
                                title: 'Create Account',
                                buttonColor: AppColors.secondaryColor,
                                textColor: AppColors.white,
                                onTap: () {
                                  storeDataAndNavigate({
                                    'dispensing_software':
                                        selectedDispensingSoftware,
                                    'regNumber': _pharmacyRegNumController.text
                                  });
                                },
                              ),
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
