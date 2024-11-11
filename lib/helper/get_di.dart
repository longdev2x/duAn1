import 'dart:convert';
import 'package:camera/camera.dart';
import 'package:du_an_1/controller/auth_controller.dart';
import 'package:du_an_1/controller/localization_controller.dart';
import 'package:du_an_1/controller/splash_controller.dart';
import 'package:du_an_1/data/api/api_client.dart';
import 'package:du_an_1/data/model/response/language_model.dart';
import 'package:du_an_1/data/repository/auth_repo.dart';
import 'package:du_an_1/data/repository/language_repo.dart';
import 'package:du_an_1/data/repository/splash_repo.dart';
import 'package:du_an_1/helper/notification_helper.dart';
import 'package:du_an_1/theme/theme_controller.dart';
import 'package:du_an_1/utils/app_constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  final firstCamera = await availableCameras();

  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => firstCamera);
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  // Repository
  Get.lazyPut(() => LanguageRepo());
  Get.lazyPut(() => SplashRepo(apiClient: Get.find()));
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  // Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashController(repo: Get.find()));
  Get.lazyPut(()=>AuthController(repo: Get.find()));


  //Init Notification
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  NotificationHelper.initialize(flutterLocalNotificationsPlugin);
  NotificationHelper.listenNetworkConnect(flutterLocalNotificationsPlugin);

  // Retrieving localized data
  Map<String, Map<String, String>> languages = {};

  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = Map();

    mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });

    languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        _json;
  }
  // Sẽ có dạng thế này
  // [{'vi_VN': {'All Map from Asset VN'}},
  //   {'en_US': {'All Map from Asset US'}},];
  return languages;
}
