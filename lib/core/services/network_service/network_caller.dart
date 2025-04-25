import 'package:edu_bridge_app/core/resources/export.dart';

class NetworkCaller extends INetworkCaller {
  final SupabaseClient _supabase;
  final Logger _logger;
  final NetworkUtils _utils;

  NetworkCaller({
    SupabaseClient? client,
    Logger? logger,
    NetworkUtils? utils,
  })  : _supabase = client ?? Supabase.instance.client,
        _logger = logger ?? Logger(),
        _utils = utils ?? NetworkUtils();

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

      _utils.applyEqFilter(query, eqColumn, eqValue);
      _utils.applyQueryParams(query, queryParams);
      _utils.applyOrdering(query, orderBy, orderDirection);

      final response = await query;
      _logger.i(
          'GET Request Successful | Table: $tableName | Results: ${response.length}');

      return ApiResponse(
        isSuccess: true,
        responseData: response,
        errorMessage: '',
      );
    } catch (e) {
      return _utils.handleError('GET', tableName, e);
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
      return _utils.handleError('POST', tableName, e);
    }
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
    try {
      _logger.i('DELETE Request Initiated | Table: $tableName');

      // Ensure queryParams is not null and has valid data
      if (queryParams == null || queryParams.isEmpty) {
        _logger.e('DELETE failed: No query parameters provided.');
        return ApiResponse(
          isSuccess: false,
          responseData: null,
          errorMessage: 'DELETE requires a WHERE clause.',
        );
      }

      // Apply query parameters to match the condition for deletion
      var query = _supabase
          .from(tableName)
          .delete()
          .match; // match applies the WHERE condition

      final response = await query;
      _logger.i('DELETE Request Successful | Table: $tableName');

      return ApiResponse(
        isSuccess: true,
        responseData: response,
        errorMessage: '',
      );
    } catch (e) {
      // Handle errors from Supabase with a custom error message
      return _utils.handleError('DELETE', tableName, e);
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
}
