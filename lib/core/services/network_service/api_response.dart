class ApiResponse {
  final bool isSuccess;
  final dynamic responseData;
  final String errorMessage;

  ApiResponse({
    required this.isSuccess,
    required this.responseData,
    required this.errorMessage,
  });
}
