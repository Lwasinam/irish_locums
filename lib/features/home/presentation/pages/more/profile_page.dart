import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:irish_locums/app/shared/busy_button.dart';
import 'package:irish_locums/app/shared/shared_pref_helper.dart';
import 'package:irish_locums/core/constants/app_asset.dart';
import 'package:irish_locums/core/constants/app_color.dart';
import 'package:irish_locums/core/constants/fonts.dart';
import 'package:irish_locums/core/constants/ui_helpers.dart';
import 'package:irish_locums/core/navigators/route_name.dart';
import 'package:irish_locums/features/auth/data/auth_repository.dart';
import 'package:irish_locums/features/auth/domain/user_model.dart';
import 'package:irish_locums/features/availability/presentation/widgets/app_bar_container.dart';
import 'package:irish_locums/features/home/data/profile_repository.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isUpdating = false;
  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController psniNumber = TextEditingController();
  TextEditingController occupation = TextEditingController();
  SharedPrefHelper _prefHelper = SharedPrefHelper();
  String? errorMessage;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  getProfileInfo() async {
    setState(() {
      isLoading = true;
    });
    await _prefHelper.init();
    Map user = await Provider.of<ProfileRepository>(context, listen: false)
        .getProfile();
    if (user['status'] == true) {
      UserModel userModel = UserModel.fromJson(user['data']);
      fullName.text = userModel.fullname ?? '';
      email.text = userModel.email;
      phoneNumber.text = userModel.phone ?? '';
      psniNumber.text = userModel.psniNumber ?? '';
      occupation.text = userModel.occupation ?? '';

      setState(() {
        isLoading = false;
      });
    } else {
      errorMessage = 'An error occured';
    }

    setState(() {
      isLoading = false;
    });
  }

  updateProfile(Map user) async {
    setState(() {
      isUpdating = true;
    });
    if (_formKey.currentState!.validate()) {
      await Provider.of<AuthRepository>(context, listen: false)
          .updateUserData(user);
      _prefHelper.setValue('fullName', fullName.text);
      _prefHelper.setValue('email', email.text);
      _prefHelper.setValue('phone_nummber', phoneNumber.text);
      _prefHelper.setValue('psniNumber', psniNumber.text);
      _prefHelper.setValue('occupation', occupation.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextBody(
            'Profile updated successfully',
            fontSize: 14,
            color: AppColors.black,
          ),
          backgroundColor: AppColors.primaryColor,
        ),
      );
      // Navigator.pop(context);
    }

    setState(() {
      isUpdating = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getProfileInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: isLoading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const AppBarContainer(
                      title: 'Profile',
                      subtitle: '',
                      showBackIcon: true,
                    ),
                    gapLarge,
                    Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        color: AppColors.primaryColor,
                        backgroundColor:
                            AppColors.primaryColor.withOpacity(0.5),
                      ),
                    ),
                    gapTiny,
                    TextSemiBold(
                      'Loading Profile',
                      color: AppColors.tertiaryTextColor,
                      fontSize: 16,
                    )
                  ],
                )
              : errorMessage != null
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(child: Text('an error Occured')))
                  : Column(
                      children: [
                        Stack(
                          children: [
                            const AppBarContainer(
                              title: 'Profile',
                              subtitle: '',
                              showBackIcon: true,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 95),
                              child: Align(
                                child: Container(
                                  height: 107,
                                  width: 107,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(13.49),
                                      color: AppColors.white,
                                      border: Border.all(
                                        width: 3.6,
                                        color: AppColors.white,
                                      )),
                                  child: Image.asset(
                                    AppAssets.manImage,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const Gap(33),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RouteName.changePasswordScreen,
                            );
                          },
                          child: Container(
                            height: 34,
                            width: 128,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: AppColors.primaryBlue,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  AppAssets.editIcon,
                                ),
                                const Gap(8),
                                TextBody(
                                  'Edit profile',
                                  fontSize: 12,
                                  color: AppColors.blue500,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Gap(12),
                        ProfileItem(
                          item: fullName,
                          label: 'Full Name',
                        ),
                        ProfileItem(
                          item: email,
                          label: 'Email',
                        ),
                        ProfileItem(
                          item: phoneNumber,
                          label: 'Phone Number',
                        ),
                        ProfileItem(
                          item: psniNumber,
                          label: 'PSNI Number',
                        ),
                        ProfileItem(
                          item: TextEditingController(text: '-'),
                          label: 'Gender',
                        ),
                        ProfileItem(
                          item: occupation,
                          label: 'Occupation',
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        isUpdating
                            ? Center(
                                child: SizedBox(
                                  height: 48.3,
                                  width: 48.3,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 4,
                                      color: AppColors.primaryColor,
                                      backgroundColor: AppColors.primaryColor
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                ),
                                child: BusyButton(
                                  title: 'Save changes',
                                  onTap: () {
                                    updateProfile({
                                      'email': email.text,
                                      'fullname': fullName.text,
                                      'phone': phoneNumber.text,
                                      'psniNumber': psniNumber.text,
                                      'occupation': occupation.text
                                    });
                                  },
                                  buttonColor: AppColors.primaryColor,
                                  textColor: AppColors.tertiaryTextColor,
                                ),
                              ),
                        const Gap(20),
                      ],
                    ),
        ),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key,
    required this.item,
    required this.label,
  });
  final String label;
  final TextEditingController item;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextBold(
            label,
            fontSize: 12,
            color: AppColors.grey100,
          ),
          const Gap(5),
          SizedBox(
            height: 20,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: GoogleFonts.inter(
                      color: AppColors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    controller: item,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SvgPicture.asset(
                  AppAssets.editIcon,
                  width: 9,
                  height: 9,
                )
              ],
            ),
          ),
          const Gap(6),
          Container(
            height: 1,
            color: AppColors.grey20,
          )
        ],
      ),
    );
  }
}
