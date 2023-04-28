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

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _SigninState extends State<Signin> {
  bool isLoading = false;
  var signInKey = GlobalKey<FormState>();
  storeDataAndNavigate(Map data) async {
    if (signInKey.currentState!.validate()) {
      Provider.of<AuthRepository>(context, listen: false)
          .userLoginData
          .addAll(data);
      setState(() {
        isLoading = true;
      });
      Map? response =
          await Provider.of<AuthRepository>(context, listen: false).login();
      setState(() {
        isLoading = false;
      });
      if (response != null) {
        if (response['auth'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login Successful'),
            ),
          );
          Navigator.pushNamed(context, RouteName.appNavPage);
        } else if (response['auth'] == false) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response['msg']),
            ),
          );
        }
      } else if (response == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Something went wrong'),
          ),
        );
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
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.top -
                  44,
              child: Form(
                key: signInKey,
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
                          'Sign-In',
                          color: AppColors.black,
                        ),
                        gapLarge,
                        gapSmall,
                        gapTiny,
                        TextBody(
                          'Email Address',
                          color: AppColors.black,
                          fontSize: 14,
                        ),
                        InputField(
                          controller: emailController,
                          placeholder: 'Patricktj@gmail.com',
                          placeholderColor: AppColors.borderColor,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email address';
                            }
                            return null;
                          },
                        ),
                        gapLarge,
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
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        gapTiny,
                        TextBody(
                          'Forgot Password?',
                          color: AppColors.yellow,
                          fontSize: 14,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 120),
                      child: isLoading
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
                              title: 'Sign-In',
                              buttonColor: AppColors.secondaryColor,
                              onTap: () {
                                storeDataAndNavigate({
                                  'email': emailController.text,
                                  'password': passwordController.text
                                });
                              },
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
