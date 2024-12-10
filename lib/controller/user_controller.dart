import 'dart:io';
import 'package:du_an_1/data/api/api_checker.dart';
import 'package:du_an_1/data/model/body/request/search_request.dart';
import 'package:du_an_1/data/model/response/role.dart';
import 'package:du_an_1/data/model/response/user.dart';
import 'package:du_an_1/data/model/response/user_search_entity.dart';
import 'package:du_an_1/data/repository/profile_repo.dart';
import 'package:du_an_1/data/repository/user_search_repo.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class UserController extends GetxController implements GetxService {
  final UserSearchRepo repo;
  final ProfileRepo repoProfile;
  UserController({required this.repo, required this.repoProfile});

  List<User>? _users;
  List<User> _userSearchs = [];
  bool _hasSearchError = false;
  bool _isFirstLoad = true;
  bool _loading = false;
  bool _hasMoreData = true;
  final Map<String, File> _mapFileAvatar = {};

  List<User>? get users => _users;
  List<User>? get userSearchs => _userSearchs;
  bool get hasSearchError => _hasSearchError;
  bool get isFirstLoad => _isFirstLoad;
  bool get loading => _loading;
  bool get hasMoreData => _hasMoreData;
  Map<String, File> get mapFileAvatar => _mapFileAvatar;

  @override
  void onReady() {
    super.onReady();
    searchUser(keyWord: null, pageIndex: 0, size: 15, status: null);
  }

  @override
  void onClose() {
    _mapFileAvatar.forEach((key, file) async {
      if (await file.exists()) {
        await file.delete();
      }
    });
    super.onClose();
  }

  Future<int> refreshData() async {
    _users?.clear();
    int statusCode =
        await searchUser(keyWord: null, pageIndex: 1, size: 15, status: null);
    return statusCode;
  }

  Future<int> searchUser({
    String? keyWord,
    required int pageIndex,
    required int size,
    required int? status,
  }) async {
    _userSearchs = [];
    _hasSearchError = false;
    SearchRequest objSearchRequest = SearchRequest(
      keyWord,
      pageIndex,
      size,
      status,
    );

    if (!hasMoreData && keyWord == null) return 400;

    _loading = true;
    update();

    Response response = await repo.searchUser(objSearchRequest);

    if (response.statusCode == 200) {
      UserSearchEntity objUserSearch = UserSearchEntity.fromJson(response.body);
      List<User> newUsers = objUserSearch.content;

      //Get avatar
      for (User objUser in newUsers) {
        if (objUser.image != null &&
            !_mapFileAvatar.containsKey(objUser.image)) {
          await getImage(objUser.image!);
        }
      }

      if (keyWord == null) {
        _users = [...?_users, ...newUsers];
        _hasMoreData = newUsers.isNotEmpty && newUsers.length == size;
      } else {
        _userSearchs = newUsers;
      }
    } else {
      _hasSearchError = true;
      ApiChecker.checkApi(response);
    }

    _isFirstLoad = false;
    _loading = false;
    update();

    return response.statusCode!;
  }

  Future<void> getImage(String nameFile) async {
    Response response = await repo.getImage(nameFile);

    if (response.statusCode == 200) {
      final Directory tempDir = await getTemporaryDirectory();
      File file = File('${tempDir.path}/$nameFile');

      if (response.bodyString != null) {
        file = await file.writeAsBytes(response.bodyString!.codeUnits);
        _mapFileAvatar[nameFile] = file;
      }
    } else {
      ApiChecker.checkApi(response);
    }
  }

  Future<int> blocUser(User objUser) async {
    print('zzzzzzz ${objUser.id}');
    
    Response response = await repo.blocUser(objUser.id!);
    if (response.statusCode != 200) {
      ApiChecker.checkApi(response);
    } else {
      for (int i = 0; i < _users!.length; i++) {
        if (_users![i] == objUser) {
          _users!.remove(objUser);
        }
      }
    }
    

    update();

    return response.statusCode!;
  }

  Future<int> updateUserForAdmin(
    User objUser, {
    String? username,
    bool? active,
    bool? changePass,
    bool? hasPhoto,
    bool? setPassword,
    String? birthPlace,
    String? tokenDevice,
    String? confirmPassword,
    String? displayName,
    DateTime? dob,
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
    User oldUser = objUser;
    for (int i = 0; i < _users!.length; i++) {
      if (_users![i] == objUser) {
        _users![i] = _users![i].copyWith(
          active: active,
          changePass: changePass,
          setPassword: setPassword,
          hasPhoto: hasPhoto,
          tokenDevice: tokenDevice,
          birthPlace: birthPlace,
          confirmPassword: confirmPassword,
          countDayCheckin: countDayCheckin,
          countDayTracking: countDayTracking,
          displayName: displayName,
          dob: dob,
          email: email,
          firstName: firstName,
          gender: gender,
          image: image,
          lastName: lastName,
          password: password,
          roles: roles,
          university: university,
          username: username,
          year: year,
        );
        objUser = _users![i];
      }
    }

    update();

    Response response = await repoProfile.updateUserForAdmin(objUser);
    if (response.statusCode != 200) {
      ApiChecker.checkApi(response);
      objUser = oldUser;
    }

    update();

    return response.statusCode!;
  }
}
