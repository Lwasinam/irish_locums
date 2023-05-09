import 'package:country_picker/country_picker.dart';
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

class SignupUserLocation extends StatefulWidget {
  const SignupUserLocation({Key? key}) : super(key: key);

  @override
  State<SignupUserLocation> createState() => _SignupUserLocationState();
}

class _SignupUserLocationState extends State<SignupUserLocation> {
  _SignupUserLocationState() {}

  TextEditingController eirTextController = TextEditingController();
  TextEditingController addressTextController = TextEditingController();
  String? selectedCountry;

  storeDataAndNavigate(Map data) {
    setState(() {});
    if (selectedCountry != null &&
        addressTextController.text != '' &&
        eirTextController.text != '') {
      Provider.of<AuthRepository>(context, listen: false)
          .userSignupData
          .addAll(data);

      Navigator.pushReplacementNamed(
        context,
        RouteName.signupAdditionalInfo,
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
                        'Employer Sign-Up',
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
                        'Address',
                        color: AppColors.black,
                        fontSize: 14,
                      ),
                      gapTiny,
                      InputField(
                        controller: addressTextController,
                        placeholder: '',
                        placeholderColor: AppColors.borderColor,
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      gapTiny,
                      addressTextController.text == ''
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
                        'Eir Code',
                        color: AppColors.black,
                        fontSize: 14,
                      ),
                      InputField(
                        controller: eirTextController,
                        placeholder: '',
                        onChanged: (value) {
                          setState(() {});
                        },
                        placeholderColor: AppColors.borderColor,
                      ),
                      gapTiny,
                      eirTextController.text == ''
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
                              'address': addressTextController.text,
                              'county': selectedCountry,
                              'eir_code': eirTextController.text
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
