import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:edu_bridge_app/core/resources/urls.dart';
import 'package:edu_bridge_app/user_app.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Supabase.initialize(
    url: Urls.env['apiUrl'] ?? '',
    anonKey: Urls.env['apiKey'] ?? '',
  );
}

void main() async {
  await initializeApp();
  runApp(const EduBridgeUser());
}
