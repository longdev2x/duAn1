import 'package:du_an_1/controller/home_controller.dart';
import 'package:du_an_1/screens/home/widgets/home_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
    return Scaffold(
      body: Obx(() => screens[homeController.bottomIndexSelected.value]),
      bottomNavigationBar: const HomeBottomNavBar(),
    );
  }
}
