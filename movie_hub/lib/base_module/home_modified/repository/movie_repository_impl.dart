

import 'movie_repository.dart';
import '../../../network/api_manager.dart';
import '../../../network/api_end_point.dart';
import '../model/home_screen_models.dart';
import '../model/popular_movies_model.dart';
import '../model/top_rated_movie_model.dart';
import '../model/tranding_movie_list_model.dart';


class MovieRepositoryImpl implements MovieRepository {
  @override
  Future<List<UpcomingMovie>> fetchUpcomingMovies() async {
    final endpoint = APIEndpoint(
      path: '/movie/upcoming',
      method: HTTPMethod.GET,
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZGMwN2RlNTA1ZTM0ZjIyY2FhYWZlNzI0ZDc1ZmVjNiIsIm5iZiI6MTcyOTA1NjE1NS43MTEwNjQsInN1YiI6IjY3MGU2YjJkMGI4MDA1MzdkNzVjZjM1NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.vu4IZ5ObJWkshT1D14mcP70iKTRaF4PCsDSHL0kgitc',
      },
      queryParams: {'page': '1'},
    );

    final result = await APIManager.instance.request<UpcomingMovieList>(
      endpoint,
          (data) => UpcomingMovieList.fromJson(data),
    );

    if (result.data != null && result.data!.results != null) {
      return result.data!.results!;
    } else {
      throw Exception('Failed to fetch upcoming movies: ${result.error?.message}');
    }
  }

  @override
  Future<List<PopularMovie>> fetchPopularMovies() async {
    final endpoint = APIEndpoint(
      path: '/movie/popular',
      method: HTTPMethod.GET,
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZGMwN2RlNTA1ZTM0ZjIyY2FhYWZlNzI0ZDc1ZmVjNiIsIm5iZiI6MTcyOTA1NjE1NS43MTEwNjQsInN1YiI6IjY3MGU2YjJkMGI4MDA1MzdkNzVjZjM1NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.vu4IZ5ObJWkshT1D14mcP70iKTRaF4PCsDSHL0kgitc',
      },
      queryParams: {'page': '1'},
    );

    final result = await APIManager.instance.request<PopularMovieList>(
      endpoint,
          (data) => PopularMovieList.fromJson(data),
    );

    if (result.data != null && result.data!.results != null) {
      return result.data!.results!;
    } else {
      throw Exception('Failed to fetch popular movies: ${result.error?.message}');
    }
  }

  @override
  Future<List<TopRatedMovie>> fetchTopRatedMovies() async {
    final endpoint = APIEndpoint(
      path: '/movie/top_rated',
      method: HTTPMethod.GET,
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZGMwN2RlNTA1ZTM0ZjIyY2FhYWZlNzI0ZDc1ZmVjNiIsIm5iZiI6MTcyOTA1NjE1NS43MTEwNjQsInN1YiI6IjY3MGU2YjJkMGI4MDA1MzdkNzVjZjM1NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.vu4IZ5ObJWkshT1D14mcP70iKTRaF4PCsDSHL0kgitc',
      },
      queryParams: {'page': '1'},
    );

    final result = await APIManager.instance.request<TopRatedMoviesList>(
      endpoint,
          (data) => TopRatedMoviesList.fromJson(data),
    );

    if (result.data != null && result.data!.results != null) {
      return result.data!.results!;
    } else {
      throw Exception('Failed to fetch top-rated movies: ${result.error?.message}');
    }
  }

  @override
  Future<List<TrandingMovie>> fetchTrendingMovies() async {
    final endpoint = APIEndpoint(
      path: '/movie/now_playing',
      method: HTTPMethod.GET,
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZGMwN2RlNTA1ZTM0ZjIyY2FhYWZlNzI0ZDc1ZmVjNiIsIm5iZiI6MTcyOTA1NjE1NS43MTEwNjQsInN1YiI6IjY3MGU2YjJkMGI4MDA1MzdkNzVjZjM1NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.vu4IZ5ObJWkshT1D14mcP70iKTRaF4PCsDSHL0kgitc',
      },
      queryParams: {'page': '1'},
    );

    final result = await APIManager.instance.request<TrandingMoviesList>(
      endpoint,
          (data) => TrandingMoviesList.fromJson(data),
    );

    if (result.data != null && result.data!.results != null) {
      return result.data!.results!;
    } else {
      throw Exception('Failed to fetch trending movies: ${result.error?.message}');
    }
  }
}