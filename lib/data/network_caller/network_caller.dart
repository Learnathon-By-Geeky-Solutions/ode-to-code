import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:logger/logger.dart';

class NetworkCaller {
  final SupabaseClient _supabase;
  final Logger _logger;

  NetworkCaller({SupabaseClient? client, Logger? logger})
      : _supabase = client ?? Supabase.instance.client,
        _logger = logger ?? Logger();

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

      if (eqColumn != null && eqValue != null) {
        query.eq(eqColumn, eqValue);
        _logger.d('Added filter: $eqColumn = $eqValue');
      }

      if (queryParams != null) {
        for (final param in queryParams.entries) {
          query.eq(param.key, param.value);
          _logger.d('Added query param: ${param.key} = ${param.value}');
        }
      }

      if (orderBy != null) {
        query.order(orderBy, ascending: orderDirection == 'asc');
        _logger.d('Added ordering: $orderBy ($orderDirection)');
      }

      final response = await query;
      _logger.i(
          'GET Request Successful | Table: $tableName | Results: ${response.length}');

      return ApiResponse(
        isSuccess: true,
        responseData: response,
        errorMessage: '',
      );
    } catch (e) {
      _logger.e('GET Request Failed | Table: $tableName', error: e);
      return ApiResponse(
        isSuccess: false,
        responseData: null,
        errorMessage: e.toString(),
      );
    }
  }

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
      _logger.e('POST Request Failed | Table: $tableName', error: e);
      return ApiResponse(
        isSuccess: false,
        responseData: null,
        errorMessage: e.toString(),
      );
    }
  }

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
      _logger.e('File Upload Failed | Bucket: $bucketName', error: e);
      return ApiResponse(
        isSuccess: false,
        responseData: null,
        errorMessage: e.toString(),
      );
    }
  }

// Add similar methods for PUT, DELETE, etc. with logging
}

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
