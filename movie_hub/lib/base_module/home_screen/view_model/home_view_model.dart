import '../model/home_screen_models.dart';
import '../../../network/api_manager.dart';
import 'package:get/get.dart';
import '../../../network/api_end_point.dart';
import '../model/popular_movies_model.dart';
import '../model/top_rated_movie_model.dart';
import '../model/tranding_movie_list_model.dart';



class HomeViewController extends GetxController {
  RxList<UpcomingMovie> listOfUpcomingMovies = <UpcomingMovie>[].obs;
  RxList<PopularMovie> listOfPopularMovies =  <PopularMovie>[].obs;
  RxList<TopRatedMovie> listOfTopRatedMovies =  <TopRatedMovie>[].obs;
  RxList<TrandingMovie> listOfTrandingMovies = <TrandingMovie>[].obs;


  void fetchIncomingMovies() async {
    // Define the endpoint with headers and query parameters
    final APIEndpoint endpoint = APIEndpoint(
      path: '/movie/upcoming', // Example path
      method: HTTPMethod.GET,
      headers: {
        'accept': 'application/json',
        'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZGMwN2RlNTA1ZTM0ZjIyY2FhYWZlNzI0ZDc1ZmVjNiIsIm5iZiI6MTcyOTA1NjE1NS43MTEwNjQsInN1YiI6IjY3MGU2YjJkMGI4MDA1MzdkNzVjZjM1NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.vu4IZ5ObJWkshT1D14mcP70iKTRaF4PCsDSHL0kgitc',
      },
      queryParams: {
        'page': '1', // Example page number, you can modify it as needed
      },
    );

    // Call the API manager
    final result = await APIManager.instance.request<UpcomingMovieList>(
      endpoint,
          (data) => UpcomingMovieList.fromJson(data), // Convert the raw response into PopularMoviesList
    );

    // Handle the result
    if (result.data != null) {
      if (result.data?.results != null) {
        listOfUpcomingMovies.addAll(result.data!.results!);
      }
      print('upcoming success');
    } else {
      // Handle the error
      print('upcoming fail');
      print('Error: ${result.error?.message}');
    }
  }


  void fetchPopularMovies() async {
    // Define the endpoint with headers and query parameters
    final APIEndpoint endpoint = APIEndpoint(
      path: '/movie/popular', // Example path
      method: HTTPMethod.GET,
      headers: {
        'accept': 'application/json',
        'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZGMwN2RlNTA1ZTM0ZjIyY2FhYWZlNzI0ZDc1ZmVjNiIsIm5iZiI6MTcyOTA1NjE1NS43MTEwNjQsInN1YiI6IjY3MGU2YjJkMGI4MDA1MzdkNzVjZjM1NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.vu4IZ5ObJWkshT1D14mcP70iKTRaF4PCsDSHL0kgitc',
      },
      queryParams: {
        'page': '1', // Example page number, you can modify it as needed
      },
    );

    // Call the API manager
    final result = await APIManager.instance.request<PopularMovieList>(
      endpoint,
          (data) => PopularMovieList.fromJson(data), // Convert the raw response into PopularMoviesList
    );

    // Handle the result
    if (result.data != null) {
      if (result.data?.results != null) {
        listOfPopularMovies.addAll(result.data!.results!);
      }
      print('popular success');
    } else {
      // Handle the error
      print('popular fail');
      print('Error: ${result.error?.message}');
    }
  }

  void fetchTopRatedMovies() async {
    // Define the endpoint with headers and query parameters
    final APIEndpoint endpoint = APIEndpoint(
      path: '/movie/top_rated', // Example path
      method: HTTPMethod.GET,
      headers: {
        'accept': 'application/json',
        'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZGMwN2RlNTA1ZTM0ZjIyY2FhYWZlNzI0ZDc1ZmVjNiIsIm5iZiI6MTcyOTA1NjE1NS43MTEwNjQsInN1YiI6IjY3MGU2YjJkMGI4MDA1MzdkNzVjZjM1NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.vu4IZ5ObJWkshT1D14mcP70iKTRaF4PCsDSHL0kgitc',
      },
      queryParams: {
        'page': '1', // Example page number, you can modify it as needed
      },
    );

    // Call the API manager
    final result = await APIManager.instance.request<TopRatedMoviesList>(
      endpoint,
          (data) => TopRatedMoviesList.fromJson(data), // Convert the raw response into PopularMoviesList
    );

    // Handle the result
    if (result.data != null) {
      if (result.data?.results != null) {
        listOfTopRatedMovies.addAll(result.data!.results!);
      }
      print('top rated success');
    } else {
      // Handle the error
      print('top rated fail');
      print('Error: ${result.error?.message}');
    }
  }


  void fetchTrandingMoives() async {
    // Define the endpoint with headers and query parameters
    final APIEndpoint endpoint = APIEndpoint(
      path: '/movie/now_playing', // Example path
      method: HTTPMethod.GET,
      headers: {
        'accept': 'application/json',
        'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZGMwN2RlNTA1ZTM0ZjIyY2FhYWZlNzI0ZDc1ZmVjNiIsIm5iZiI6MTcyOTA1NjE1NS43MTEwNjQsInN1YiI6IjY3MGU2YjJkMGI4MDA1MzdkNzVjZjM1NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.vu4IZ5ObJWkshT1D14mcP70iKTRaF4PCsDSHL0kgitc',
      },
      queryParams: {
        'page': '1', // Example page number, you can modify it as needed
      },
    );

    // Call the API manager
    final result = await APIManager.instance.request<TrandingMoviesList>(
      endpoint,
          (data) => TrandingMoviesList.fromJson(data), // Convert the raw response into PopularMoviesList
    );

    // Handle the result
    if (result.data != null) {
      if (result.data?.results != null) {
        listOfTrandingMovies.addAll(result.data!.results!);
      }
      print('tranding success');
    } else {
      // Handle the error
      print('tranding fail');
      print('Error: ${result.error?.message}');
    }
  }

}



