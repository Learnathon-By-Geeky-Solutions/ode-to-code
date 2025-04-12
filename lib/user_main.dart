import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:edu_bridge_app/resources/urls.dart';
import 'package:edu_bridge_app/user_app.dart';

// Initialize app function
Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables from the .env file
  await dotenv.load();

  // Initialize Supabase using the loaded environment variables
  await Supabase.initialize(
    url: Urls.apiUrls, // Will now correctly access the loaded dotenv values
    anonKey: Urls.apiKey, // Will now correctly access the loaded dotenv values
  );
}

void main() async {
  await initializeApp(); // Load and initialize everything before running the app
  runApp(const EduBridgeUser());
}
