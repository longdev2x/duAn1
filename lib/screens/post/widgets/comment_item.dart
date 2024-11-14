import 'package:du_an_1/data/model/response/comment_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:du_an_1/controller/post_controller.dart';

import 'package:du_an_1/utils/images.dart';
import 'package:du_an_1/view/app_text.dart';

class CommentItem extends StatelessWidget {
  final CommentEntity objComment;
  const CommentItem({super.key, required this.objComment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetBuilder<PostController>(
            builder: (controller) => CircleAvatar(
              radius: 25.r,
              backgroundImage: controller
                          .mapFileAvatar[objComment.user?.image] !=
                      null
                  ? FileImage(controller.mapFileAvatar[objComment.user?.image]!)
                  : const AssetImage(Images.imgAvatarDefault) as ImageProvider,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText16(
                  objComment.user?.displayName,
                  fontWeight: FontWeight.bold,
                ),
                AppText14(objComment.content, maxLines: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
