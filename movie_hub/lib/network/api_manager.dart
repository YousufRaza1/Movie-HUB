import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_end_point.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../common/network_connectivity_status.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';




class APIManager  {
  // Singleton pattern
  APIManager._privateConstructor();
  static final APIManager instance = APIManager._privateConstructor();

  final NetworkStatusController _networkStatusController = Get.find<NetworkStatusController>();


  Future<APIResult<T>> request<T>(
      APIEndpoint endpoint,
      T Function(dynamic data) fromJson,
      ) async {
    try {
      http.Response response;

      // Default headers
      final defaultHeaders = {'Content-Type': 'application/json'};
      final headers = {...defaultHeaders, ...?endpoint.headers};

      final isConnected = await hasConnection();
      print(isConnected);

      // If no connection, try to fetch cached data
      if (!isConnected) {
        print('No internet connection, attempting to fetch cached data...');

        final cachedData = await getMovieInOffline(endpoint.url.toString());

        // Check if cached data exists
        if (cachedData != null) {
          final data = jsonDecode(cachedData);  // Decode the string into JSON
          print('Returning data from cache');
          return APIResult.success(fromJson(data));  // Pass decoded data to fromJson
        } else {
          return APIResult.failure(APIError(message: "No internet and no cached data available."));
        }
      } else {
        print('Internet connection available, fetching data...');
      }

      // Handle different HTTP methods
      switch (endpoint.method) {
        case HTTPMethod.GET:
          response = await http.get(endpoint.url, headers: headers).timeout(Duration(seconds: 30));
          break;
        case HTTPMethod.POST:
          response = await http.post(
            endpoint.url,
            headers: headers,
            body: jsonEncode(endpoint.body),
          ).timeout(Duration(seconds: 30));
          break;
        case HTTPMethod.PUT:
          response = await http.put(
            endpoint.url,
            headers: headers,
            body: jsonEncode(endpoint.body),
          ).timeout(Duration(seconds: 30));
          break;
        case HTTPMethod.DELETE:
          response = await http.delete(endpoint.url, headers: headers).timeout(Duration(seconds: 30));
          break;
      }

      // Handle response
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = jsonDecode(response.body);  // Decode the response body
        print(data);

        // Store the raw response body as a string (already JSON-encoded)
        storeMovieInOffline(response.body, endpoint.url.toString());

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



  storeMovieInOffline(String jsonString, String api) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(api, jsonString);
  }

  Future<String?> getMovieInOffline(String api) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? jsonString = prefs.getString(api);
    print('successfully get');
    return jsonString;
  }

  Future<bool> hasConnection() async {
    return await InternetConnection().hasInternetAccess;
  }
}
