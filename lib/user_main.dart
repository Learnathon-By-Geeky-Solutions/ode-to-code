import 'package:edu_bridge_app/resources/urls.dart';
import 'package:edu_bridge_app/user_app.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: Urls.apiUrls,
    anonKey: Urls.apiKey,
  );
  runApp(
    const EduBridgeUser(),
  );
}
