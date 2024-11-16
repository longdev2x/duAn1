import 'package:camera/camera.dart';
import 'package:du_an_1/data/api/api_client.dart';
import 'package:du_an_1/data/model/response/user.dart';
import 'package:du_an_1/utils/app_constants.dart';
import 'package:get/get.dart';

class ProfileRepo extends GetxService {
  final ApiClient apiClient;

  ProfileRepo({required this.apiClient});

  Future<Response> updateInfo(User objUser) async {
    return await apiClient.postData(
      AppConstants.UPDATE_INFO,
      objUser.toJson(),
      null,
    );
  }

    Future<Response> getCurrentUser() async {
    return await apiClient.getData(AppConstants.GET_USER);
  }

  Future<Response> updateUserForAdmin(User objUser) async {
    return await apiClient.postData(
      AppConstants.UPDATE_USER_FOR_ADMIN,
      objUser.toJson(),
      id: objUser.id,
      null,
    );
  }

  Future<Response> uploadFile(XFile xFile) async {
    return await apiClient.postMultipartData(
      AppConstants.UPLOAD_FILE,
      {},
      [MultipartBody('uploadfile', xFile)],
      headers: null,
    );
  }

  Future<Response> getFile(String filePath) async {
    return await apiClient.getImageData(
      AppConstants.GET_FILE,
      nameFile: filePath,
    );
  }
}
