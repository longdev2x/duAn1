import 'package:du_an_1/data/api/api_client.dart';
import 'package:du_an_1/data/model/body/request/search_request.dart';
import 'package:du_an_1/data/model/response/comment_entity.dart';
import 'package:du_an_1/data/model/response/like_entity.dart';
import 'package:du_an_1/data/model/response/post_entity.dart';
import 'package:du_an_1/utils/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:image_picker/image_picker.dart';

class PostRepo extends GetxService {
  final ApiClient apiClient;

  PostRepo({required this.apiClient});

  Future<Response> searchNews(SearchRequest objUserSearchRequest) async {
    return await apiClient.postData(
      AppConstants.GET_NEWS,
      objUserSearchRequest.toJson(),
      null,
    );
  }

  Future<Response> createPost(PostEntity objPost) async {
    return await apiClient.postData(
      AppConstants.CREATE_POST,
      objPost.toJson(),
      null,
    );
  }

  Future<Response> uploadImage(XFile xFile) async {
    List<MultipartBody> multipartBodys = [MultipartBody('uploadfile', xFile)];
    return await apiClient.postMultipartData(
      AppConstants.UPLOAD_FILE,
      {},
      multipartBodys,
      headers: null,
    );
  }

  Future<Response> getImage(String nameFile) async {
    return await apiClient.getImageData(
      AppConstants.GET_FILE,
      nameFile: nameFile,
    );
  }

  Future<Response> likePost(LikeEntity objLike, String postId) async {
    return await apiClient.postData(
      AppConstants.LIKE_POST,
      objLike.toJson(),
      null,
      id: postId,
    );
  }

  Future<Response> comment(CommentEntity objComment) async {
    return await apiClient.postData(
        AppConstants.SEND_COMMENT, objComment.toJson(), null,
        id: objComment.objPost?.id);
  }

  Future<Response> editPost(PostEntity objPost) async {
    return await apiClient.postData(
      AppConstants.EDIT_POST,
      objPost.toJson(),
      null,
      id: objPost.id,
    );
  }
}
