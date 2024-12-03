// abstract_repository.dart

import '../model/home_screen_models.dart';
import '../model/top_rated_movie_model.dart';
import '../model/popular_movies_model.dart';
import '../model/tranding_movie_list_model.dart';

abstract class MovieRepository {
  Future<List<UpcomingMovie>> fetchUpcomingMovies();
  Future<List<PopularMovie>> fetchPopularMovies();
  Future<List<TopRatedMovie>> fetchTopRatedMovies();
  Future<List<TrandingMovie>> fetchTrendingMovies();
}

