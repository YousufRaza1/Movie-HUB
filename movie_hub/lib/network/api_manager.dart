import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_end_point.dart';

class APIManager {
  // Singleton pattern
  APIManager._privateConstructor();
  static final APIManager instance = APIManager._privateConstructor();

  // Generic request method
  Future<APIResult<T>> request<T>(
      APIEndpoint endpoint,
      T Function(dynamic data) fromJson,
      ) async {
    try {
      http.Response response;

      // Choose the HTTP method
      switch (endpoint.method) {
        case HTTPMethod.GET:
          response = await http.get(endpoint.url, headers: endpoint.headers);
          break;
        case HTTPMethod.POST:
          response = await http.post(
            endpoint.url,
            headers: endpoint.headers,
            body: jsonEncode(endpoint.body),
          );
          break;
        case HTTPMethod.PUT:
          response = await http.put(
            endpoint.url,
            headers: endpoint.headers,
            body: jsonEncode(endpoint.body),
          );
          break;
        case HTTPMethod.DELETE:
          response = await http.delete(endpoint.url, headers: endpoint.headers);
          break;
      }

      // Handle response
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(response.body);
        return APIResult.success(fromJson(data));
      } else {
        return APIResult.failure(
          APIError.fromStatusCode(response.statusCode, response.body),
        );
      }
    } catch (error) {
      return APIResult.failure(APIError(message: error.toString()));
    }
  }
}
