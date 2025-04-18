class Validators {
  static String? _isEmptyOrNull(String? value, String errorMessage) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    return null;
  }

  static String? emailValidator(String? value) {
    final error = _isEmptyOrNull(value, 'Please enter your email');
    if (error != null) return error;

    if (!RegExp(r"^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+")
        .hasMatch(value!)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    final error = _isEmptyOrNull(value, 'Please enter your password');
    if (error != null) return error;

    if (value!.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
