import 'package:edu_bridge_app/core/resources/export.dart';
import 'package:edu_bridge_app/core/services/api_response.dart';

class NetworkUtils {
  final Logger _logger;

  NetworkUtils({Logger? logger}) : _logger = logger ?? Logger();

  void applyEqFilter(dynamic query, String? column, dynamic value) {
    if (column != null && value != null) {
      query.eq(column, value);
      _logger.d('Added filter: $column = $value');
    }
  }

  void applyQueryParams(dynamic query, Map<String, dynamic>? params) {
    if (params != null) {
      for (final entry in params.entries) {
        query.eq(entry.key, entry.value);
        _logger.d('Added query param: ${entry.key} = ${entry.value}');
      }
    }
  }

  void applyOrdering(dynamic query, String? column, String? direction) {
    if (column != null) {
      query.order(column, ascending: direction == 'asc');
      _logger.d('Added ordering: $column ($direction)');
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
