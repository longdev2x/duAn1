import 'package:du_an_1/data/api/api_client.dart';
import 'package:du_an_1/data/model/body/request/search_request.dart';
import 'package:du_an_1/utils/app_constants.dart';
import 'package:get/get.dart';


class UserSearchRepo extends GetxService{
  final ApiClient apiClient;
  UserSearchRepo({required this.apiClient});

  Future<Response> searchUser(SearchRequest objUserSearchRequest) async {
    return await apiClient.postData(
      AppConstants.SEARCH_USER,
      objUserSearchRequest.toJson(),
      null,
    );
  }

    Future<Response> getImage(String nameFile) async {
    return await apiClient.getImageData(AppConstants.GET_FILE,
        nameFile: nameFile,);
  }
}
