import 'package:edu_bridge_app/core/services/network_service/api_response.dart';

abstract class INetworkCaller {
  Future<ApiResponse> getRequest({
    required String tableName,
    Map<String, dynamic>? queryParams,
    String? eqColumn,
    dynamic eqValue,
    String? orderBy,
    String? orderDirection,
  });

  Future<ApiResponse> postRequest({
    required String tableName,
    required Map<String, dynamic> data,
  });

  Future<ApiResponse> uploadFile({
    required String bucketName,
    required String filePath,
    required dynamic file,
  });

  Future<ApiResponse> deleteRequest({
    required String tableName,
    Map<String, dynamic>? queryParams,
  });

  String? getCurrentUserId();

  Future<ApiResponse> saveUserCourse({
    required String userId,
    required String courseId,
  });

  // New PUT request method for updating data
  Future<ApiResponse> putRequest({
    required String tableName,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParams,
  });
}
