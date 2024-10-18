import 'package:get/get.dart';
import '../model/movie_details_model.dart';
import '../../../network/api_manager.dart';
import '../../../network/api_end_point.dart';

class MovieDetailsViewModel extends GetxController {
  Rxn<MovieDetailsModel> movieDetails = Rxn<MovieDetailsModel>();

  void addToFavorite(int movieId) async {

    final APIEndpoint endpoint = APIEndpoint(
        path: '/account/21572778/favorite?session_id=7f54d9be5fb4c228621bd97367ae3f420c962f22',
        method: HTTPMethod.POST,
        headers: {
          'accept': 'application/json',
          'content-type': 'application/json',
          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZGMwN2RlNTA1ZTM0ZjIyY2FhYWZlNzI0ZDc1ZmVjNiIsIm5iZiI6MTcyOTA1NjE1NS43MTEwNjQsInN1YiI6IjY3MGU2YjJkMGI4MDA1MzdkNzVjZjM1NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.vu4IZ5ObJWkshT1D14mcP70iKTRaF4PCsDSHL0kgitc',
        },
      queryParams: {
        'session_id': '7f54d9be5fb4c228621bd97367ae3f420c962f22',
      },
      body: {
        'media_id': movieId,
        'media_type': 'movie',
        'favorite': true,
      }
    );

    final result = await APIManager.instance.request<AddFavoriteSuccess>(
      endpoint,
          (data) => AddFavoriteSuccess.fromJson(data), // Convert the raw response into MovieDetailsModel
    );

    // Handle the result
    if (result.data != null) {
      print('add to favorite success');
      print(result.data!);
    } else {
      // Handle the error
      print('add to favorite fail');
      print('Error: ${result.error?.message}');
    }

  }

  void removeFromWatchList(int movieId) async {

    final APIEndpoint endpoint = APIEndpoint(
        path: '/account/21572778/favorite?session_id=7f54d9be5fb4c228621bd97367ae3f420c962f22',
        method: HTTPMethod.POST,
        headers: {
          'accept': 'application/json',
          'content-type': 'application/json',
          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZGMwN2RlNTA1ZTM0ZjIyY2FhYWZlNzI0ZDc1ZmVjNiIsIm5iZiI6MTcyOTA1NjE1NS43MTEwNjQsInN1YiI6IjY3MGU2YjJkMGI4MDA1MzdkNzVjZjM1NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.vu4IZ5ObJWkshT1D14mcP70iKTRaF4PCsDSHL0kgitc',
        },
        queryParams: {
          'session_id': '7f54d9be5fb4c228621bd97367ae3f420c962f22',
        },
        body: {
          'media_id': movieId,
          'media_type': 'movie',
          'favorite': false,
        }
    );

    final result = await APIManager.instance.request<AddFavoriteSuccess>(
      endpoint,
          (data) => AddFavoriteSuccess.fromJson(data), // Convert the raw response into MovieDetailsModel
    );

    // Handle the result
    if (result.data != null) {
      print('add to favorite success');
      print(result.data!);
    } else {
      // Handle the error
      print('add to favorite fail');
      print('Error: ${result.error?.message}');
    }

  }

  void getDetailsOfMovie(int movieId) async {
    // Define the endpoint with headers and query parameters
    final APIEndpoint endpoint = APIEndpoint(
        path: '/movie/${movieId}', // Example path
        method: HTTPMethod.GET,
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZGMwN2RlNTA1ZTM0ZjIyY2FhYWZlNzI0ZDc1ZmVjNiIsIm5iZiI6MTcyOTA1NjE1NS43MTEwNjQsInN1YiI6IjY3MGU2YjJkMGI4MDA1MzdkNzVjZjM1NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.vu4IZ5ObJWkshT1D14mcP70iKTRaF4PCsDSHL0kgitc',
        }

    );

    // Call the API manager
    final result = await APIManager.instance.request<MovieDetailsModel>(
      endpoint,
          (data) => MovieDetailsModel.fromJson(data), // Convert the raw response into MovieDetailsModel
    );

    // Handle the result
    if (result.data != null) {
      movieDetails.value = result.data;
      print('movie details success');
    } else {
      // Handle the error
      print('movie details fail');
      print('Error: ${result.error?.message}');
    }
  }
}
