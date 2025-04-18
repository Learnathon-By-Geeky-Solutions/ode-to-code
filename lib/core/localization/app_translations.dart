import 'package:edu_bridge_app/core/localization/bn.dart';
import 'package:edu_bridge_app/core/localization/en.dart';
import 'package:edu_bridge_app/core/resources/export.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'bn': bn,
      };
}
