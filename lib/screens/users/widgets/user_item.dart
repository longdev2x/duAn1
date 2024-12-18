import 'package:du_an_1/data/model/response/user.dart';
import 'package:du_an_1/screens/users/edit_member_user_screen.dart';
import 'package:du_an_1/screens/users/user_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:du_an_1/controller/auth_controller.dart';
import 'package:du_an_1/controller/user_controller.dart';

import 'package:du_an_1/utils/images.dart';
import 'package:du_an_1/view/app_image.dart';
import 'package:du_an_1/view/app_text.dart';
import 'package:du_an_1/view/app_toast.dart';

class UserItem extends StatelessWidget {
  final User objUser;
  final VoidCallback? onBack;
  const UserItem({super.key, required this.objUser, this.onBack});

  @override
  Widget build(BuildContext context) {
    User currentUser = Get.find<AuthController>().user;
    bool isAdmin = false;

    if (currentUser.roles != null && currentUser.roles!.isNotEmpty) {
      isAdmin = currentUser.roles?[0].name == 'ROLE_ADMIN';
    }

    void blockUser(User objUser, BuildContext context)  {
      showDialog(
        context: context,
        builder: (context) => AppConfirm(
          title: 'Bạn thực sự muốn block ${objUser.displayName}',
          onConfirm: () async {
            // User không lưu thông 
             await Get.find<UserController>().blocUser(objUser);
            Navigator.pop(context);
          },
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        Get.to(() => UserDetailScreen(user: objUser));
      },
      child: Card(
        margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 10.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
          child: Row(
            children: [
              GetBuilder<UserController>(
                builder: (controller) => CircleAvatar(
                  radius: 25.r,
                  backgroundImage:
                      controller.mapFileAvatar[objUser.image] != null
                          ? FileImage(controller.mapFileAvatar[objUser.image]!)
                          : const AssetImage(Images.imgAvatarDefault)
                              as ImageProvider,
                ),
              ),
              SizedBox(width: 20.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppText14(
                    objUser.displayName ?? 'No name',
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 3.h),
                  AppText14(objUser.username ?? ''),
                ],
              ),
              const Spacer(),
              if (isAdmin)
                Row(
                  children: [
                    AppImageAsset(
                      imagePath: Images.icUpdateUser,
                      onTap: () {
                        Get.to(() => EditMemberUserScreen(
                                  objUser: objUser,
                                ))
                            ?.then((v) => onBack);
                      },
                      height: 22,
                      width: 22,
                    ),
                    SizedBox(width: 15.w),
                    AppImageAsset(
                      imagePath: Images.icBlock,
                      onTap: () {
                        blockUser(objUser, context);
                      },
                      height: 22,
                      width: 22,
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
