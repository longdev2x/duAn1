import 'package:du_an_1/data/api/api_client.dart';
import 'package:du_an_1/data/model/response/tracking_entity.dart';
import 'package:du_an_1/utils/app_constants.dart';
import 'package:get/get.dart';

class TrackingRepo extends GetxService {
  final ApiClient apiClient;

  TrackingRepo({required this.apiClient});

  Future<Response> getCurrentUserTracking() async {
    return await apiClient.getData(AppConstants.TRACKING);
  }

  Future<Response> updateCurrentUserTracking(TrackingEntity objTracking) async {
    return await apiClient.postData(
      AppConstants.TRACKING,
      objTracking.toJson(),
      null,
    );
  }

  Future<Response> editTracking(TrackingEntity objTracking) async {
    return await apiClient.postData(
      AppConstants.DELETE_TRACKING,
      objTracking.toJson(),
      null,
      id: objTracking.id,
    );
  }

  Future<Response> deleteTracking(String id) async {
    return await apiClient.deleteData(
      AppConstants.DELETE_TRACKING,
      id,
    );
  }
}
