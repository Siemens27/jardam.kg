
import '../core/vendor/viewobject/common/language.dart';

class PsConfig {
  PsConfig._();

  ///
  /// AppVersion

  static const String app_version = '1.0';

  ///
  /// Bearer Token
  ///
  static const String ps_bearer_token =
      'Bearer E3tL5629IXbbXZG9QmHyh3k94S5o5CPzV35C77t6';

  ///
  ///
  static const String ps_core_url =
      'https://ads.ustech.kg';

  static const String ps_app_url = ps_core_url + '/api/v1.0/'; //index.php/';

  static const String ps_app_image_url =
      ps_core_url + '/public/storage/PSX_MPC/uploads/';

  static const String ps_app_image_thumbs_url =
      ps_core_url + '/public/storage/PSX_MPC/thumbnail/';

  static const String ps_app_image_thumbs_2x_url =
      ps_core_url + '/public/storage/PSX_MPC/thumbnail2x/';

  static const String ps_app_image_thumbs_3x_url =
      ps_core_url + '/public/storage/PSX_MPC/thumbnail3x/';

  ///
  /// Chat Setting
  ///
  static const String iosGoogleAppId =
      '1:376498785645:ios:8358047bf3bbdacc215e64';
  static const String iosGcmSenderId = '376498785645';
  static const String iosProjectId = 'adsustech-1f299';
  static const String iosDatabaseUrl =
      'https://adsustech-1f299-default-rtdb.firebaseio.com';
  static const String iosApiKey = 'AIzaSyAS190y6_7tVpf53BpLTw_N2ERdU34lVCw';

  static const String androidGoogleAppId =
      '1:376498785645:android:9aa35f5a2f7ca83e215e64';
  static const String androidGcmSenderId = '376498785645';
  static const String androidProjectId = 'adsustech-1f299';
  static const String androidApiKey = 'AIzaSyDt7TDlfC1kE4hGxi1hsYD7WnUoi87lI4U';
  static const String androidDatabaseUrl =
      'https://adsustech-1f299-default-rtdb.firebaseio.com';

  ////
  static bool isDemo = false;

  ///
  /// Animation Duration
  ///
  static const Duration animation_duration = Duration(milliseconds: 500);

  ///
  /// Fonts Family Config
  /// Before you declare you here,
  /// 1) You need to add font under assets/fonts/
  /// 2) Declare at pubspec.yaml
  /// 3) Update your font family name at below
  ///
  // static const String ps_default_font_family = 'Product Sans';

  static const String ps_app_db_name = 'ps_db.db';

  ///
  /// Default Language
  ///
  static final Language defaultLanguage =
      Language(languageCode: 'ru', countryCode: 'RU', name: 'Russian RU');

  /// For default language change, please check
  /// LanguageFragment for language code and country code
  /// ..............................................................
  /// Language             | Language Code     | Country Code
  /// ..............................................................
  /// "English"            | "en"              | "US"
  /// "Russian"            | "ru"              | "RU"
  /// ..............................................................
  ///
  static final List<Language> psSupportedLanguageList = <Language>[
    Language(languageCode: 'en', countryCode: 'US', name: 'English'),
    Language(languageCode: 'ru', countryCode: 'RU', name: 'Russian'),
  ];

  ///
  /// Tmp Image Folder Name
  ///
  static const String tmpImageFolderName = 'PSXMPC';

  ///
  /// set showLog [True] to enable log
  ///
  static bool showLog = false;
}
