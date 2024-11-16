import 'package:du_an_1/controller/home_controller.dart';
import 'package:du_an_1/screens/notify/notify_screen.dart';
import 'package:du_an_1/screens/post/post_screen.dart';
import 'package:du_an_1/screens/setting/setting_screen.dart';
import 'package:du_an_1/screens/tracking/tracking_screen.dart';
import 'package:du_an_1/screens/users/users_screen.dart';
import 'package:du_an_1/utils/images.dart';
import 'package:du_an_1/view/app_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<Widget> screens = [
  const TrackingScreen(),
  const UsersScreen(),
  const PostScreen(),
  const NotifyScreen(),
  const SettingScreen(),
];

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final HomeController homeController = Get.find<HomeController>();
    return Obx(
      () => BottomNavigationBar(
        currentIndex: homeController.bottomIndexSelected.value,
        onTap: (value) {
          homeController.onSelected(value);
        },
        items: listBottoms
            .map((objBottom) => _bottomItem(objBottom: objBottom, theme: theme))
            .toList(),
        backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }

  BottomNavigationBarItem _bottomItem({
    required BottomItemEntity objBottom,
    required ThemeData theme,
  }) =>
      BottomNavigationBarItem(
        icon: AppImageAsset(
          imagePath: objBottom.icon,
          height: 25,
          width: 25,
        ),
        label: objBottom.name,
        activeIcon: AppImageAsset(
          imagePath: objBottom.icon,
          height: 25,
          width: 25,
          color: theme.colorScheme.onSurface,
        ),
      );
}


List<BottomItemEntity> listBottoms = [
  const BottomItemEntity(name: 'Home', icon: Images.icHome),
  const BottomItemEntity(name: 'Users', icon: Images.icUsers),
  const BottomItemEntity(name: 'Social', icon: Images.icSocial),
  const BottomItemEntity(name: 'Notify', icon: Images.icNotify),
  const BottomItemEntity(name: 'Settings', icon: Images.icSetting),
];

class BottomItemEntity {
  final String name;
  final String icon;
  const BottomItemEntity({
    required this.name,
    required this.icon,
  });
}
