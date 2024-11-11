import 'dart:io';
import 'package:du_an_1/controller/localization_controller.dart';
import 'package:du_an_1/firebase_options.dart';
import 'package:du_an_1/helper/route_helper.dart';
import 'package:du_an_1/theme/dark_theme.dart';
import 'package:du_an_1/theme/light_theme.dart';
import 'package:du_an_1/theme/theme_controller.dart';
import 'package:du_an_1/utils/app_constants.dart';
import 'package:du_an_1/utils/messages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'helper/get_di.dart' as di;

Future<void> main() async {
  if (kDebugMode) {
    print("Bắt đầu: ${DateTime.now()}");
  }
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  Map<String, Map<String, String>> _languages = await di.init();

  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MyApp(
        languages: _languages,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>>? languages;
  const MyApp({super.key, this.languages});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        FlutterNativeSplash.remove();
        if (kDebugMode) {
          print("Kết thúc init: ${DateTime.now()}");
        }
        return GetMaterialApp(
          title: AppConstants.APP_NAME,
          debugShowCheckedModeBanner: false,
          navigatorKey: Get.key,
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
          ),
          theme: themeController.darkTheme!
              ? themeController.darkColor == null
                  ? dark()
                  : dark(color: themeController.darkColor!)
              : themeController.lightColor == null
                  ? light()
                  : light(color: themeController.lightColor!),
          locale: localizeController.locale,
          translations: Messages(languages: languages),
          fallbackLocale: Locale(AppConstants.languages[0].languageCode,
              AppConstants.languages[0].countryCode),
          initialRoute: RouteHelper.getSplashRoute(),
          getPages: RouteHelper.routes,
          defaultTransition: Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 250),
        );
      });
    });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
