import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:edu_bridge_app/feature/auth/forgot_password/view_model/forget_password_controller.dart';
import 'package:edu_bridge_app/core/services/auth_service/i_auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements IAuthService {}

void main() {
  late MockAuthService mockAuthService;
  late ForgotPasswordController controller;

  setUp(() {
    mockAuthService = MockAuthService();

    when(() => mockAuthService.resetPassword(any()))
        .thenAnswer((_) async => Future.value());

    controller = ForgotPasswordController(authService: mockAuthService);
  });

  Widget createWidgetUnderTest() {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          home: GetBuilder<ForgotPasswordController>(
            init: controller,
            builder: (_) => const ForgotPasswordView(),
          ),
        );
      },
    );
  }

  testWidgets('ForgotPasswordView renders and triggers reset',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle();

    final emailField = find.byType(TextFormField);
    expect(emailField, findsOneWidget);
    await tester.enterText(emailField, 'test@example.com');

    final resetButton = find.byType(ElevatedButton);
    expect(resetButton, findsOneWidget);
    await tester.tap(resetButton);

    await tester.pump(const Duration(seconds: 4));

    verify(() => mockAuthService.resetPassword('test@example.com')).called(1);
  });
}
