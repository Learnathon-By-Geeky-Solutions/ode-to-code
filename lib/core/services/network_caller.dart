import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:edu_bridge_app/core/services/api_response.dart';

class NetworkCaller extends INetworkCaller {
  final SupabaseClient _supabase;
  final Logger _logger;

  NetworkCaller({SupabaseClient? client, Logger? logger})
      : _supabase = client ?? Supabase.instance.client,
        _logger = logger ?? Logger();

  @override
  Future<ApiResponse> getRequest({
    required String tableName,
    Map<String, dynamic>? queryParams,
    String? eqColumn,
    dynamic eqValue,
    String? orderBy,
    String? orderDirection = 'asc',
  }) async {
    try {
      _logger.i('GET Request Initiated | Table: $tableName');
      final query = _supabase.from(tableName).select();

      _applyEqFilter(query, eqColumn, eqValue);
      _applyQueryParams(query, queryParams);
      _applyOrdering(query, orderBy, orderDirection);

      _logger.d('Query: $query');

      final response = await query;

      _logger.i(
        'GET Request Successful | Table: $tableName | Results: ${response.length}',
      );

      return ApiResponse(
        isSuccess: true,
        responseData: response,
        errorMessage: '',
      );
    } catch (e) {
      return _handleError('GET', tableName, e);
    }
  }

  @override
  Future<ApiResponse> postRequest({
    required String tableName,
    required Map<String, dynamic> data,
  }) async {
    try {
      _logger.i('POST Request Initiated | Table: $tableName');
      _logger.d('Payload: $data');

      final response = await _supabase.from(tableName).insert(data);

      _logger.i('POST Request Successful | Table: $tableName');

      return ApiResponse(
        isSuccess: true,
        responseData: response,
        errorMessage: '',
      );
    } catch (e) {
      return _handleError('POST', tableName, e);
    }
  }

  @override
  Future<ApiResponse> uploadFile({
    required String bucketName,
    required String filePath,
    required dynamic file,
  }) async {
    try {
      _logger.i(
        'File Upload Initiated | Bucket: $bucketName | Path: $filePath',
      );

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
      return _handleError('UPLOAD', bucketName, e);
    }
  }

  @override
  Future<ApiResponse> deleteRequest({
    required String tableName,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      _logger.i('DELETE Request Initiated | Table: $tableName');

      var query = _supabase.from(tableName).delete();
      query = _applyQueryParamsToQuery(query, queryParams);

      final response = await query;

      _logger.i('DELETE Request Successful | Table: $tableName');

      return ApiResponse(
        isSuccess: true,
        responseData: response,
        errorMessage: '',
      );
    } catch (e) {
      return _handleError('DELETE', tableName, e);
    }
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

  // New PUT request method for updating data
  @override
  Future<ApiResponse> putRequest({
    required String tableName,
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      _logger.i('PUT Request Initiated | Table: $tableName');
      _logger.d('Payload: $data');

      var query = _supabase.from(tableName).upsert(data);
      query = _applyQueryParamsToQuery(query, queryParams);

      final response = await query;

      _logger.i('PUT Request Successful | Table: $tableName');

      return ApiResponse(
        isSuccess: true,
        responseData: response,
        errorMessage: '',
      );
    } catch (e) {
      return _handleError('PUT', tableName, e);
    }
  }

  // ----------------------
  // Private Helper Methods
  // ----------------------

  void _applyEqFilter(dynamic query, String? column, dynamic value) {
    if (column != null && value != null) {
      query.eq(column, value);
      _logger.d('Added filter: $column = $value');
    }
  }

  void _applyQueryParams(dynamic query, Map<String, dynamic>? params) {
    if (params != null) {
      for (final entry in params.entries) {
        query.eq(entry.key, entry.value);
        _logger.d('Added query param: ${entry.key} = ${entry.value}');
      }
    }
  }

  dynamic _applyQueryParamsToQuery(
      dynamic query, Map<String, dynamic>? params) {
    if (params != null) {
      for (final entry in params.entries) {
        query = query.eq(entry.key, entry.value);
        _logger.d('Added query param: ${entry.key} = ${entry.value}');
      }
    }
    return query;
  }

  void _applyOrdering(dynamic query, String? column, String? direction) {
    if (column != null) {
      query.order(column, ascending: direction == 'asc');
      _logger.d('Added ordering: $column ($direction)');
    }
  }

  ApiResponse _handleError(String method, String name, dynamic error) {
    _logger.e('$method Request Failed | Target: $name', error: error);
    return ApiResponse(
      isSuccess: false,
      responseData: null,
      errorMessage: error.toString(),
    );
  }
}
