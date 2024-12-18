import 'package:du_an_1/data/repository/auth_repo.dart';
import 'package:get/get.dart';

class HomeController extends GetxController implements GetxService  {
  final RxInt bottomIndexSelected = 0.obs;

  @override
  void onInit() {
    super.onInit();
    Get.find<AuthRepo>().setDeviceToken();
  }

  void onSelected(int index) {
    bottomIndexSelected.value = index;
  }
}