import 'package:du_an_1/data/model/response/user.dart';
import 'package:du_an_1/screens/profile/edit_profile_screen.dart';
import 'package:du_an_1/screens/profile/widgets/profile_avatar_widget.dart';

import 'package:du_an_1/screens/sign_in/sign_in_screen.dart';
import 'package:du_an_1/screens/users/widgets/user_parameter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:du_an_1/controller/auth_controller.dart';
import 'package:du_an_1/controller/home_controller.dart';
import 'package:du_an_1/controller/profile_controller.dart';
import 'package:du_an_1/helper/date_converter.dart';
import 'package:du_an_1/utils/app_constants.dart';
import 'package:du_an_1/utils/images.dart';
import 'package:du_an_1/view/app_button.dart';
import 'package:du_an_1/view/app_text.dart';
import 'package:du_an_1/view/app_toast.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _logout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AppConfirm(
        title: 'Bạn muốn đăng xuất?',
        onConfirm: () async {
          if (await Get.find<AuthController>().logOut() == 200) {
            Get.offAll(() => const SignInScreen());
            Get.find<HomeController>().bottomIndexSelected.value = 0;
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile'.tr),
        actions: [
          IconButton(
              onPressed: () => _logout(context),
              icon: const Icon(Icons.logout)),
          SizedBox(width: 10.w),
        ],
      ),
      body: GetBuilder<ProfileController>(
        builder: (controller) {
          bool isAdmin = false;

          if (controller.user?.roles != null &&
              controller.user!.roles!.isNotEmpty) {
            isAdmin = controller.user!.roles?[0].name == AppConstants.ROLE_ADMIN;
          }

          User objUser = controller.user!;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const ProfileAvatarWidget(),
                    SizedBox(height: 15.h),
                    AppText20(
                        '${objUser.displayName} (${isAdmin ? AppConstants.ROLE_ADMIN : 'user'.tr.toUpperCase()})',
                        fontWeight: FontWeight.bold),
                    SizedBox(height: 5.h),
                    AppText16(objUser.email),
                    SizedBox(height: 15.h),
                    AppButton(
                        ontap: () {
                          Get.to(() => const EditProfileScreen());
                        },
                        name: 'edit_profile'.tr,
                        width: 250),
                    SizedBox(height: 20.h),
                    if (objUser.username != null)
                      UserParameterWidget(
                        name: 'username'.tr,
                        icon: Images.icUsername,
                        prameter: objUser.username!,
                        isFirst: true,
                      ),
                    if (objUser.email != null)
                      UserParameterWidget(
                        name: 'email'.tr,
                        icon: Images.icEmail,
                        prameter: objUser.email!,
                      ),
                    if (objUser.lastName != null || objUser.firstName != null)
                      UserParameterWidget(
                        name: 'full_name'.tr,
                        icon: Images.icSocial,
                        prameter: '${objUser.lastName} ${objUser.firstName}',
                      ),
                    if (objUser.dob != null)
                      UserParameterWidget(
                        name: 'date_of_birth'.tr,
                        icon: Images.icSocial,
                        prameter: objUser.dob != null
                            ? DateConverter.getOnlyFomatDate(objUser.dob!)
                            : 'no_data_found'.tr,
                      ),
                    if (objUser.gender != null)
                      UserParameterWidget(
                        name: 'gender'.tr,
                        icon: Images.icSocial,
                        prameter: objUser.gender! == 'M' ? 'male'.tr : 'female'.tr,
                      ),
                    if (objUser.birthPlace != null)
                      UserParameterWidget(
                        name: 'birth_place'.tr,
                        icon: Images.icSocial,
                        prameter: objUser.birthPlace!,
                      ),
                    if (objUser.university != null)
                      UserParameterWidget(
                        name: 'university'.tr,
                        icon: Images.icUniversity,
                        prameter: objUser.university!,
                      ),
                    if (objUser.year != null)
                      UserParameterWidget(
                        name: 'year_student'.tr,
                        icon: Images.icYear,
                        prameter: objUser.year.toString(),
                      ),
                    UserParameterWidget(
                      name: 'count_day_check_in'.tr,
                      icon: Images.icCheckIn,
                      prameter: objUser.countDayCheckin != null
                          ? objUser.countDayCheckin.toString()
                          : '0',
                    ),
                    UserParameterWidget(
                      name: 'count_day_tracking'.tr,
                      icon: Images.icTracking,
                      prameter: objUser.countDayTracking != null
                          ? objUser.countDayTracking.toString()
                          : '0',
                      isLast: true,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
