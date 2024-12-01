
import 'package:du_an_1/data/model/response/language_model.dart';
import 'images.dart';

class AppConstants {
  static const String APP_NAME = 'Base';
  static const String APP_VERSION = "1.0.0";
  static const String BASE_URL = 'http://10.0.2.2:3000';  // ios http://localhost:3000
  static const String CONFIG_URI = '/public/config-app';
  static const String LOGIN_URI = '/oauth/token';
  static const String SEND_TOKEN_DEVICE = '/users/token-device';
  static const String SIGN_UP = '/public/sign';
  static const String LOG_OUT = '/oauth/logout';
  static const String GET_USER = '/users/get-user-current';
  static const String GET_CHECK_IN = '/time-sheets';
  static const String CHECK_IN = '/time-sheets/check-in';
  static const String TRACKING = '/tracking';
  static const String EDIT_TRACKING = '/tracking/{id}';
  static const String DELETE_TRACKING = '/tracking/{id}';
  static const String SEARCH_USER = '/users/searchByPage';
  static const String UPDATE_INFO = '/users/update-myself/';
  static const String UPDATE_USER_FOR_ADMIN = '/users/update/{id}';
  static const String UPLOAD_FILE = '/public/uploadFile';
  static const String GET_FILE = '/public/images/';
  static const String GET_NEWS = '/posts/get-news';
  static const String CREATE_POST = '/posts/create';
  static const String LIKE_POST = '/posts/likes/{id}';
  static const String SEND_COMMENT = '/posts/comments/{id}';
  static const String EDIT_POST = '/posts/update/{id}';
  static const String GET_NOTIFICATION = '/notifications';
  static const String TEST_PUSH_NOTIFY = '/notifications/test-push';
  static const String ROLE_USER= 'ROLE_USER';
  static const String ROLE_ADMIN= 'ROLE_ADMIN';
  static const String MALE = 'MALE';
  static const String FEMALE = 'MALE';
  // Shared Key
  static const String THEME = 'theme';
  static const String TOKEN = 'token';
  static const String TOKEN_DEVICE = 'token_device';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String USER_PASSWORD = 'user_password';
  static const String USER_ADDRESS = 'user_address';
  static const String USER_NUMBER = 'user_number';
  static const String USER_COUNTRY_CODE = 'user_country_code';
  static const String NOTIFICATION = 'notification';
  static const String NOTIFICATION_COUNT = 'notification_count';

  static const String MODULE_ID = 'moduleId';
  static const String LOCALIZATION_KEY = 'X-localization';

  // Shared Key
  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.vietnam,
        languageName: 'Việt Nam',
        countryCode: 'VN',
        languageCode: 'vi'),
    LanguageModel(
        imageUrl: Images.english,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
  ];
}
