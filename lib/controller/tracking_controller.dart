import 'package:du_an_1/controller/auth_controller.dart';
import 'package:du_an_1/data/api/api_checker.dart';
import 'package:du_an_1/data/model/response/tracking_entity.dart';
import 'package:du_an_1/data/model/response/user.dart';
import 'package:du_an_1/data/repository/tracking_repo.dart';
import 'package:get/get.dart';

class TrackingController extends GetxController implements GetxService {
  final TrackingRepo repo;

  TrackingController({required this.repo});

  bool _loading = false;
  List<TrackingEntity>? _trackings;
  DateTime? _dateFilter;

  bool get loading => _loading;
  DateTime? get dateFilter => _dateFilter;
  List<TrackingEntity>? get trackings => _trackings;

  Future<int> refreshData() async {
    _trackings?.clear();
    int statusCode = await getTracking();
    return statusCode;
  }

  Future<int> getTracking() async {
    _loading = true;
    update();

    Response response = await repo.getCurrentUserTracking();

    if (response.statusCode == 200) {
      _trackings = List.from(response.body)
          .map((json) => TrackingEntity.fromJson(json))
          .toList();
    } else {
      ApiChecker.checkApi(response);
    }
    _loading = false;
    update();
    return response.statusCode!;
  }

  void filterList(DateTime? date) async {
    _dateFilter = date;
    update();
  }

  Future<int> saveTracking({required String content}) async {
    User user = Get.find<AuthController>().user;
    DateTime now = DateTime.now();

    TrackingEntity objTracking = TrackingEntity(
      content: content,
      date: now,
      user: user,
    );

    _loading = true;
    update();

    Response response = await repo.updateCurrentUserTracking(objTracking);
    if (response.statusCode == 200) {
      TrackingEntity objTracking = TrackingEntity.fromJson(response.body);
      _trackings = [...?_trackings, objTracking];
    } else {
      ApiChecker.checkApi(response);
    }
    _loading = false;
    update();
    return response.statusCode!;
  }

  Future<int> editTracking(TrackingEntity objTracking,
      {required String newContent}) async {
    objTracking = objTracking.copyWith(
      content: newContent,
    );

    _loading = true;
    update();

    Response response = await repo.editTracking(objTracking);

    if (response.statusCode == 200) {
      int index = _trackings!.indexWhere((e) => e.id == objTracking.id);
      _trackings![index] = objTracking;
    } else {
      ApiChecker.checkApi(response);
    }

    _loading = false;
    update();
    return response.statusCode!;
  }

  Future<int> deleteTracking({required String id}) async {
    print('zzzz -1 ');
    Response response = await repo.deleteTracking(id);
print('zzzz -2 ');
    if (response.statusCode == 200) {print('zzzz -3 ');
      _trackings!.removeWhere((e) => e.id == id);
      print('zzzz -4 ');
      update();
    } else {
      ApiChecker.checkApi(response);
    }

    return response.statusCode!;
  }
}
