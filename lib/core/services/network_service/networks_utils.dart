import 'package:edu_bridge_app/core/resources/export.dart';

class NetworkUtils {
  final Logger _logger;

  NetworkUtils({Logger? logger}) : _logger = logger ?? Logger();

  void _logQueryOperation(String operation, String key, dynamic value) {
    _logger.d('$operation: $key = $value');
  }

  void applyEqFilter(dynamic query, String? column, dynamic value) {
    if (column != null && value != null) {
      query.eq(column, value);
      _logQueryOperation('Added filter', column, value);
    }
  }

  void applyQueryParams(dynamic query, Map<String, dynamic>? params) {
    if (params != null) {
      params.forEach((key, value) {
        query.eq(key, value);
        _logQueryOperation('Added query param', key, value);
      });
    }
  }

  void applyOrdering(dynamic query, String? column, String? direction) {
    if (column != null) {
      query.order(column, ascending: direction == 'asc');
      _logQueryOperation('Added ordering', column, direction ?? 'asc');
    }
  }

  ApiResponse handleError(String method, String name, dynamic error) {
    _logger.e('$method Request Failed | Target: $name', error: error);
    return ApiResponse(
      isSuccess: false,
      responseData: null,
      errorMessage: error.toString(),
    );
  }
}
