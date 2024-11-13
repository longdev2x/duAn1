import 'package:du_an_1/data/api/api_client.dart';
import 'package:du_an_1/utils/app_constants.dart';
import 'package:get/get.dart';

class NotificationRepo extends GetxService {
  final ApiClient apiClient;
  NotificationRepo({required this.apiClient});

  Future<Response> getNotification() async {
    return await apiClient.getData(
      AppConstants.GET_NOTIFICATION,
    ); 
  }

  Future<Response> testPushNotify() async {
    return await apiClient.getData(
      AppConstants.TEST_PUSH_NOTIFY,
    ); 
  }
}