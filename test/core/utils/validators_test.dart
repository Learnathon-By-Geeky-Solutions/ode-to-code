import 'package:edu_bridge_app/core/export.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Email Validator', () {
    test('returns error if email is empty', () {
      expect(Validators.emailValidator(''), 'Please enter your email');
    });

    test('returns error if email is invalid', () {
      expect(Validators.emailValidator('invalid'),
          'Please enter a valid email address');
    });

    test('returns null for valid email', () {
      expect(Validators.emailValidator('test@example.com'), null);
    });
  });

  group('Password Validator', () {
    test('returns error if password is empty', () {
      expect(Validators.passwordValidator(''), 'Please enter your password');
    });

    test('returns error if password is too short', () {
      expect(Validators.passwordValidator('123'),
          'Password must be at least 6 characters');
    });

    test('returns null for valid password', () {
      expect(Validators.passwordValidator('123456'), null);
    });
  });
}
