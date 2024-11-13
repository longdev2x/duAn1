import 'package:du_an_1/controller/home_controller.dart';
import 'package:du_an_1/screens/profile/profile_screen.dart';
import 'package:du_an_1/utils/images.dart';
import 'package:du_an_1/view/app_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<Widget> screens = [
   Center(child: ElevatedButton(onPressed: () => const ProfileScreen(), child: const Text('Navigate To Profile')),),
  const Center(child: Text('Users'),),
  const Center(child: Text('PostScreen'),),
  const Center(child: Text('NotifyScreen'),),
  const Center(child: Text('Setting'),),
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
