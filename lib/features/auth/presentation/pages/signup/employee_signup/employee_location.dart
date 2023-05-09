import 'package:flutter/material.dart';
import 'package:irish_locums/app/shared/app_bar.dart';
import 'package:irish_locums/app/shared/busy_button.dart';
import 'package:irish_locums/app/shared/input_field.dart';
import 'package:irish_locums/core/constants/app_color.dart';
import 'package:irish_locums/core/constants/fonts.dart';
import 'package:irish_locums/core/constants/ui_helpers.dart';
import 'package:irish_locums/core/navigators/route_name.dart';
import 'package:country_picker/country_picker.dart';
import 'package:irish_locums/features/auth/data/auth_repository.dart';
import 'package:provider/provider.dart';

class EmployeeLocation extends StatefulWidget {
  const EmployeeLocation({Key? key}) : super(key: key);

  @override
  State<EmployeeLocation> createState() => _EmployeeLocationState();
}

class _EmployeeLocationState extends State<EmployeeLocation> {
  TextEditingController townTextController = TextEditingController();
  String? selectedCountry;
  final _willingToRelocate = ['Yes', 'No'];
  bool? canRelocate;

  storeDataAndNavigate(Map data) {
    setState(() {});
    if (selectedCountry != null &&
        canRelocate != null &&
        townTextController.text != '') {
      Provider.of<AuthRepository>(context, listen: false)
          .userSignupData
          .addAll(data);

      Navigator.pushReplacementNamed(
        context,
        RouteName.signupEmployeeJobType,
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
                        'Location',
                        fontWeight: FontWeight.bold,
                        color: AppColors.textGrey,
                        fontSize: 12,
                      ),
                      gapMedium,
                      gapSmall,
                      TextBody(
                        'Town/City',
                        color: AppColors.black,
                        fontSize: 14,
                      ),
                      gapTiny,
                      InputField(
                        controller: townTextController,
                        placeholder: '',
                        placeholderColor: AppColors.borderColor,
                        onChanged: (vale) {
                          setState(() {});
                        },
                      ),
                      gapTiny,
                      townTextController.text == ''
                          ? const Text(
                              'Empty field',
                              style: TextStyle(color: AppColors.red),
                            )
                          : const SizedBox(),
                      gapSmall,
                      gapMedium,
                      TextBody(
                        'County',
                        color: AppColors.black,
                        fontSize: 14,
                      ),
                      gapTiny,
                      GestureDetector(
                        onTap: () {
                          showCountryPicker(
                              context: context,
                              onSelect: (Country country) {
                                setState(() {
                                  selectedCountry =
                                      country.displayNameNoCountryCode;
                                });
                              },
                              showSearch: false,
                              useSafeArea: true);
                        },
                        child: Container(
                            padding: const EdgeInsets.only(left: 12, top: 5),
                            height: 50,
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: AppColors.borderColor,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedCountry ?? 'select country',
                                ),
                                const Icon(Icons.arrow_drop_down)
                              ],
                            )),
                      ),
                      gapTiny,
                      selectedCountry == null
                          ? const Text(
                              'Empty field',
                              style: TextStyle(color: AppColors.red),
                            )
                          : const SizedBox(),
                      gapSmall,
                      gapMedium,
                      TextBody(
                        'Willing to relocate?',
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
                            onChanged: (String? val) {
                              setState(() {
                                if (val == 'Yes') {
                                  canRelocate = true;
                                } else if (val == 'No') {
                                  canRelocate = false;
                                }
                              });
                            },
                            items: _willingToRelocate.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      gapTiny,
                      canRelocate == null
                          ? const Text(
                              'Empty field',
                              style: TextStyle(color: AppColors.red),
                            )
                          : const SizedBox(),
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
                              'city': townTextController.text,
                              'country': selectedCountry,
                              'canRelocate': canRelocate
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
        ));
  }
}
