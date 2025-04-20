// test/mocks/mock_auth_service.dart

import 'package:mocktail/mocktail.dart';
import 'package:edu_bridge_app/core/services/auth_service/i_auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockAuthService extends Mock implements IAuthService {}

class MockUser extends Mock implements User {}
