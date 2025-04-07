import 'package:edu_bridge_app/resources/export.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'appTitle': 'EduBridge',
          'welcome': 'Welcome',
          'signIn': 'Sign In',
          'profile': 'Profile',
          'home': 'Home',
          'settings': 'Settings',
          'dark_mode': 'Dark Mode',
          'language': 'Language',
        },
        'bn': {
          'appTitle': 'এডু ব্রিজ',
          'welcome': 'স্বাগতম',
          'signIn': 'সাইন ইন',
          'profile': 'প্রোফাইল',
          'home': 'হোম',
          'settings': 'সেটিংস',
          'dark_mode': 'ডার্ক মোড',
          'language': 'ভাষা',
        },
      };
}
