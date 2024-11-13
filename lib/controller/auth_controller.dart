import 'package:du_an_1/data/api/api_checker.dart';
import 'package:du_an_1/data/model/response/role.dart';
import 'package:du_an_1/data/model/response/token_resposive.dart';
import 'package:du_an_1/data/model/response/user.dart';
import 'package:du_an_1/data/repository/auth_repo.dart';
import 'package:du_an_1/utils/app_constants.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo repo;

  AuthController({required this.repo});

  bool _loading = false;
  final Rx<User> _user = User().obs;
  bool _everInit = false;

  bool get loading => _loading;
  User get user => _user.value;

  void _listenUserUpdate() {
    _everInit = true;
    ever(
      _user,
      (callback) {
        
      },
    );
  }

  Future<int> signUp(User objUser) async {
    Role role = Role(null, AppConstants.ROLE_USER, AppConstants.ROLE_USER);

    objUser = objUser.copyWith(active: true, changePass: true, roles: [role]);
    _loading = true;
    update();

    Response response = await repo.signUp(objUser: objUser);

    if (response.statusCode != 200) {
      ApiChecker.checkApi(response);
    }

    _loading = false;
    update();
    return response.statusCode!;
  }

  Future<int> login(String username, String password) async {
    _loading = true;
    update();
    Response response =
        await repo.login(username: username, password: password);
    if (response.statusCode == 200) {
      TokenResponsive tokeBody = TokenResponsive.fromJson(response.body);
      await repo.saveUserToken(tokeBody.accessToken!);
      await repo.setDeviceToken();

      await getCurrentUser();
    } else {
      ApiChecker.checkApi(response);
    }
    _loading = false;
    update();
    return response.statusCode!;
  }

  Future<int> logOut() async {
    _loading = true;
    Response response = await repo.logOut();
    if (response.statusCode == 200) {
      repo.clearUserToken();
    } else {
      ApiChecker.checkApi(response);
    }
    _loading = false;
    update();
    return response.statusCode!;
  }

  Future<int> getCurrentUser() async {
    Response response = await repo.getCurrentUser();
    if (response.statusCode == 200) {
      _user.value = User.fromJson(response.body);
      if (!_everInit) {
        _listenUserUpdate();
      }
      update();
    } else {
      ApiChecker.checkApi(response);
    }
    return response.statusCode!;
  }

  void updateUser(User userUpdate) {
    _user.value = userUpdate;
  }

  void clearData() {
    _loading = false;
    _user.value = User();
  }
}
