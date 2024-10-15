import 'dart:convert';
import 'package:http/http.dart' as http;

class APIEndpoint {
  final String path;
  final HTTPMethod method;
  final Map<String, String>? headers;
  final dynamic body;

  APIEndpoint({
    required this.path,
    required this.method,
    this.headers,
    this.body,
  });

  Uri get url => Uri.parse('https://yourapi.com$path');
}


enum HTTPMethod { GET, POST, PUT, DELETE }


class APIResult<T> {
  final T? data;
  final APIError? error;

  APIResult.success(this.data) : error = null;
  APIResult.failure(this.error) : data = null;
}

class APIError {
  final String message;
  final int? statusCode;

  APIError({required this.message, this.statusCode});

  factory APIError.fromStatusCode(int statusCode, String responseBody) {
    String message;

    switch (statusCode) {
      case 400:
        message = 'Bad Request (400): Invalid request.';
        break;
      case 401:
        message = 'Unauthorized (401): Authentication failed.';
        break;
      case 403:
        message = 'Forbidden (403): Access denied.';
        break;
      case 404:
        message = 'Not Found (404): Resource not found.';
        break;
      case 500:
        message = 'Internal Server Error (500).';
        break;
      default:
        message = 'Error ($statusCode): ${responseBody}';
    }

    return APIError(message: message, statusCode: statusCode);
  }
}
