import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:edu_bridge_app/core/services/api_response.dart';
import 'package:edu_bridge_app/core/services/networks_utils.dart';

class NetworkCaller extends INetworkCaller {
  final SupabaseClient _supabase;
  final Logger _logger;
  final NetworkUtils _utils;

  NetworkCaller({SupabaseClient? client, Logger? logger})
      : _supabase = client ?? Supabase.instance.client,
        _logger = logger ?? Logger(),
        _utils = NetworkUtils(logger: logger);

  Future<ApiResponse> _sendRequest({
    required String method,
    required String tableName,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParams,
    String? eqColumn,
    dynamic eqValue,
    String? orderBy,
    String? orderDirection = 'asc',
  }) async {
    try {
      _logger.i('$method Request Initiated | Table: $tableName');
      if (data != null) _logger.d('Payload: $data');
      var query = _supabase.from(tableName).select();

      _utils.applyEqFilter(query, eqColumn, eqValue);
      _utils.applyQueryParams(query, queryParams);
      _utils.applyOrdering(query, orderBy, orderDirection);

      final response = await query;
      _logger.i(
          '$method Request Successful | Table: $tableName | Results: ${response.length}');
      return ApiResponse(
        isSuccess: true,
        responseData: response,
        errorMessage: '',
      );
    } catch (e) {
      return _utils.handleError(method, tableName, e);
    }
  }

  @override
  Future<ApiResponse> getRequest({
    required String tableName,
    Map<String, dynamic>? queryParams,
    String? eqColumn,
    dynamic eqValue,
    String? orderBy,
    String? orderDirection = 'asc',
  }) async {
    return await _sendRequest(
      method: 'GET',
      tableName: tableName,
      queryParams: queryParams,
      eqColumn: eqColumn,
      eqValue: eqValue,
      orderBy: orderBy,
      orderDirection: orderDirection,
    );
  }

  @override
  Future<ApiResponse> postRequest({
    required String tableName,
    required Map<String, dynamic> data,
  }) async {
    return await _sendRequest(
      method: 'POST',
      tableName: tableName,
      data: data,
    );
  }

  @override
  Future<ApiResponse> uploadFile({
    required String bucketName,
    required String filePath,
    required dynamic file,
  }) async {
    try {
      _logger
          .i('File Upload Initiated | Bucket: $bucketName | Path: $filePath');
      await _supabase.storage.from(bucketName).upload(filePath, file);
      final publicUrl =
          _supabase.storage.from(bucketName).getPublicUrl(filePath);
      _logger.i('File Upload Successful | URL: $publicUrl');
      return ApiResponse(
        isSuccess: true,
        responseData: publicUrl,
        errorMessage: '',
      );
    } catch (e) {
      return _utils.handleError('UPLOAD', bucketName, e);
    }
  }

  @override
  Future<ApiResponse> deleteRequest({
    required String tableName,
    Map<String, dynamic>? queryParams,
  }) async {
    return await _sendRequest(
      method: 'DELETE',
      tableName: tableName,
      queryParams: queryParams,
    );
  }

  @override
  String? getCurrentUserId() {
    return _supabase.auth.currentUser?.id;
  }

  @override
  Future<ApiResponse> saveUserCourse({
    required String userId,
    required String courseId,
  }) async {
    return await postRequest(
      tableName: 'user_saved_courses',
      data: {
        'user_id': userId,
        'course_id': courseId,
      },
    );
  }

  @override
  Future<ApiResponse> putRequest({
    required String tableName,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParams,
  }) async {
    return await _sendRequest(
      method: 'PUT',
      tableName: tableName,
      data: data,
      queryParams: queryParams,
    );
  }
}
