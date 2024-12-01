import 'package:du_an_1/data/api/api_checker.dart';
import 'package:du_an_1/data/model/response/notification_entity.dart';
import 'package:du_an_1/data/repository/notification_repo.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController implements GetxService {
  final NotificationRepo repo;
  NotificationController({required this.repo});

  bool _loading = false;
  List<NotificationEntity>? _notifications;

  bool get loading => _loading;
  List<NotificationEntity>? get notifications => _notifications;

  @override
  void onReady() {
    super.onReady();
    getNotification();
  }

  Future<int> refreshData() async {
    _notifications?.clear();
    int statusCode = await getNotification();
    return statusCode;
  }

  Future<int> getNotification() async {
    _loading = true;
    update();

    Response response = await repo.getNotification();

    if (response.statusCode == 200) {
      _notifications = (response.body as List<dynamic>).isNotEmpty
          ? (response.body as List<dynamic>)
              .map((json) => NotificationEntity.fromJson(json))
              .toList()
              .reversed
              .toList()
          : [];
    } else {
      ApiChecker.checkApi(response);
    }

    _loading = false;
    update();

    return response.statusCode!;
  }

  Future<int> testPushNotify() async {
    Response response = await repo.testPushNotify();

    if (response.statusCode == 200) {
      // trả về bool
    } else {
      ApiChecker.checkApi(response);
    }

    update();
    return response.statusCode!;
  }
}




// {
//     "content": [
//         {
//             "id": 140,
//             "content": "hihihiha",
//             "date": 1731320377000,
//             "user": {
//                 "id": 221,
//                 "displayName": "huy99",
//                 "username": "huy99",
//                 "email": "huy@gmail.com",
//                 "gender": "M", 
//                 "university": "DH Thai Nguyen",
//                 "year": 7,
//                 "roles": [
//                     {
//                         "id": 4,
//                         "name": "ROLE_USER"
//                     }
//                 ]
//             },
//             "media": [
//                 {
//                     "id": 0,
//                     "contentType": "application/octet-stream",
//                     "contentSize": 237056,
//                     "name": "2024-10-29 06:24:27.664070.png",
//                     "filePath": "src/main/resources/uploads/images/2024-10-29 06:24:27.664070.png"
//                 }
//             ],
//             "likes": [
//                 {
//                     "id": 1068,
//                     "type": 0,
//                     "date": 1731320733000,
//                     "user": {
//                         "id": 221,
//                         "username": "huy99"
//                     }
//                 }
//             ],
//             "comments": [
//                 {
//                     "id": 166,
//                     "content": "hehe", 
//                     "date": 1731320741000,
//                     "user": {
//                         "id": 221,
//                         "username": "huy99"
//                     }
//                 }
//             ]
//         }
//     ],
//     "pageable": {
//         "pageNumber": 0,
//         "pageSize": 1,
//         "sort": {
//             "sorted": false,
//             "unsorted": true
//         }
//     },
//     "totalElements": 140,
//     "totalPages": 140,
//     "size": 1,
//     "first": true,
//     "last": false
// }