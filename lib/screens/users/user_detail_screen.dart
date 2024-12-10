import 'package:du_an_1/data/model/response/user.dart';

import 'package:du_an_1/screens/users/edit_member_user_screen.dart';
import 'package:du_an_1/screens/users/widgets/user_parameter_widget.dart';
import 'package:du_an_1/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:du_an_1/controller/auth_controller.dart';
import 'package:du_an_1/controller/user_controller.dart';

import 'package:du_an_1/helper/date_converter.dart';

import 'package:du_an_1/utils/images.dart';
import 'package:du_an_1/view/app_button.dart';
import 'package:du_an_1/view/app_toast.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;
  const UserDetailScreen({super.key, required this.user, });

  void blockUser(User objUser, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AppConfirm(
        title: 'Bạn thực sự muốn block ${objUser.displayName}',
        onConfirm: () async {
            Navigator.pop(context);
            Navigator.pop(context);
            await Get.find<UserController>().blocUser(objUser);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User currentUser = Get.find<AuthController>().user;
    bool isAdmin = false;

    if (currentUser.roles != null && currentUser.roles!.isNotEmpty) {
      isAdmin = currentUser.roles?[0].name == AppConstants.ROLE_ADMIN;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(user.displayName ?? ''),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h),
        child: Column(
          children: [
            GetBuilder<UserController>(
              builder: (controller) => CircleAvatar(
                radius: 80.r,
                backgroundImage: controller.mapFileAvatar[user.image] != null
                    ? FileImage(controller.mapFileAvatar[user.image]!)
                    : const AssetImage(Images.imgAvatarDefault)
                        as ImageProvider,
              ),
            ),
            SizedBox(height: 25.h),
            if (isAdmin)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: AppButton(
                        ontap: () {
                          Get.to(() => EditMemberUserScreen(objUser: user));
                        },
                        name: 'edit_profile'.tr,
                        height: 37,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: AppButton(
                        ontap: () {
                          blockUser(user, context);
                        },
                        name: 'block_user'.tr,
                        height: 37,
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 35.h),
            if (user.username != null)
              UserParameterWidget(
                name: 'username'.tr,
                icon: Images.icSocial,
                prameter: user.username!,
                isFirst: true,
              ),
            if (user.email != null)
              UserParameterWidget(
                name: 'email'.tr,
                icon: Images.icSocial,
                prameter: user.email!,
              ),
            if (user.lastName != null || user.firstName != null)
              UserParameterWidget(
                name: 'full_name'.tr,
                icon: Images.icSocial,
                prameter: '${user.lastName} ${user.firstName}',
              ),
            if (user.dob != null)
              UserParameterWidget(
                name: 'date_of_birth'.tr,
                icon: Images.icSocial,
                prameter: user.dob != null
                    ? DateConverter.getOnlyFomatDate(user.dob!)
                    : 'unavailable'.tr,
              ),
            if (user.gender != null)
              UserParameterWidget(
                name: 'gender'.tr,
                icon: Images.icSocial,
                prameter: user.gender!,
              ),
            if (user.birthPlace != null)
              UserParameterWidget(
                name: 'birth_place'.tr,
                icon: Images.icSocial,
                prameter: user.birthPlace!,
              ),
            if (user.university != null)
              UserParameterWidget(
                name: 'university'.tr,
                icon: Images.icSocial,
                prameter: user.university!,
              ),
            if (user.year != null)
              UserParameterWidget(
                name: 'year_student'.tr,
                icon: Images.icSocial,
                prameter: user.year.toString(),
              ),
            if(isAdmin) UserParameterWidget(
              name: 'count_day_check_in'.tr,
              icon: Images.icSocial,
              prameter: user.countDayCheckin != null
                  ? user.countDayCheckin.toString()
                  : '0',
            ),
           if(isAdmin) UserParameterWidget(
              name: 'count_day_tracking'.tr,
              icon: Images.icSocial,
              prameter: user.countDayTracking != null
                  ? user.countDayTracking.toString()
                  : '0',
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }
}
