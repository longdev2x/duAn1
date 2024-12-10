import 'dart:io';
import 'package:camera/camera.dart';
import 'package:du_an_1/controller/auth_controller.dart';
import 'package:du_an_1/data/api/api_checker.dart';
import 'package:du_an_1/data/model/response/media_entity.dart';
import 'package:du_an_1/data/model/response/role.dart';
import 'package:du_an_1/data/model/response/user.dart';
import 'package:du_an_1/data/repository/profile_repo.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class ProfileController extends GetxController implements GetxService {
  final ProfileRepo repo;
  ProfileController({required this.repo});

  User? _user;
  bool _loading = false;
  bool _imgLoading = false;
  File? _fileAvatar;

  User? get user => _user;
  bool get loading => _loading;
  bool get imgLoading => _imgLoading;
  File? get fileAvatar => _fileAvatar;

  @override
  void onReady() {
    super.onReady();
    _user = Get.find<AuthController>().user;
  }

  @override
  void onClose() async {
    if (fileAvatar != null && await fileAvatar!.exists()) {
      await fileAvatar!.delete();
    }
    super.onClose();
  }



  Future<int> getCurrentUser() async {
    _loading = true;
    update();
    Response response = await repo.getCurrentUser();
    if (response.statusCode == 200) {
      _user = User.fromJson(response.body);
      update();
    } else {
      ApiChecker.checkApi(response);
    }

    _loading = false;
    update();
    return response.statusCode!;
  }

  Future<int> updateInfo({
    String? username,
    bool? active,
    String? birthPlace,
    String? confirmPassword,
    String? displayName,
    DateTime? dob,
    String? tokenDevice,
    String? email,
    String? firstName,
    String? lastName,
    String? gender,
    String? image,
    String? university,
    String? password,
    int? countDayCheckin,
    int? countDayTracking,
    int? year,
    List<Role>? roles,
  }) async {
    if (_user == null) {
      return Future.delayed(
        const Duration(seconds: 1),
        () => 400,
      );
    }

    _user = _user!.copyWith(
      username: username,
      active: active,
      tokenDevice: tokenDevice,
      birthPlace: birthPlace,
      confirmPassword: confirmPassword,
      countDayCheckin: countDayCheckin,
      countDayTracking: countDayTracking,
      displayName: displayName,
      dob: dob,
      email: email,
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      image: image,
      password: password,
      roles: roles,
      university: university,
      year: year,
    );

    _loading = true;
    update();

    Response response = await repo.updateInfo(_user!);

    if (response.statusCode == 200) {
      _user = User.fromJson(response.body);

      Get.find<AuthController>().updateUser(_user!);
    } else {
      ApiChecker.checkApi(response);
    }

    _loading = false;
    update();
    return response.statusCode!;
  }


  Future<int> uploadAvatar(XFile xFile) async {
    _imgLoading = true;
    update();

    // Không có quyền trên storage
    // String? url = await FirebaseStorageRepo.uploadImage(File(xFile.path));
    // if (url == null) {
    //   AppToast.showToast('Lỗi khi upload ảnh');
    //   return 400;
    // }
    // Response response = await repo.updateInfo(_user!);
    // if (response.statusCode != 200) {
    //   ApiChecker.checkApi(response);
    // }

    Response response = await repo.uploadFile(xFile);

    if (response.statusCode == 200) {
      MediaEntity? objMedia = MediaEntity.fromJson(response.body);
      _user = _user!.copyWith(
        image: objMedia.name,
      );

      Response updateResponse = await repo.updateInfo(_user!);

      if (updateResponse.statusCode == 200) {
        await getImage();
      } else {
        ApiChecker.checkApi(response);
        return updateResponse.statusCode!;
      }
    } else {
      _imgLoading = false;
      update();
      ApiChecker.checkApi(response);
    }

    return response.statusCode!;
  }

  Future<void> getImage() async {
    if (_user?.image == null) {
      return;
    }

    Response response = await repo.getFile(_user!.image!);

    if (response.statusCode == 200) {
      //Tạo file
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/${_user!.image!}');

      //Ghi dữ liệu vào file
      if (response.bodyString != null) {
        _fileAvatar = await file.writeAsBytes(response.bodyString!.codeUnits);
        update();
      }
    } else {
      ApiChecker.checkApi(response);
    }

    _imgLoading = false;
    update();
  }

  void updateUser(User userUpdate) {
    _user = userUpdate;
  }
}
