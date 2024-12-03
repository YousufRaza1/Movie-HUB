import 'package:flutter/foundation.dart';
import '../repository/movie_repository.dart';
import '../model/home_screen_models.dart';
import '../model/popular_movies_model.dart';
import '../model/top_rated_movie_model.dart';
import '../model/tranding_movie_list_model.dart';
import '../../watch_list/model/favorite_movie_List.dart';
import '../repository/movie_repository_impl.dart';


class HomeViewModel extends ChangeNotifier {
  final MovieRepository _repository;

  HomeViewModel({MovieRepository? repository})
      : _repository = repository ?? MovieRepositoryImpl();

  // State variables
  List<UpcomingMovie> _listOfUpcomingMovies = [];
  List<PopularMovie> _listOfPopularMovies = [];
  List<TopRatedMovie> _listOfTopRatedMovies = [];
  List<TrandingMovie> _listOfTrendingMovies = [];
  List<FavoriteMovie> _listOfFavoriteMovies = [];

  // Loading states
  bool _isLoading = false;
  String? _error;

  // Getters
  List<UpcomingMovie> get listOfUpcomingMovies => _listOfUpcomingMovies;
  List<PopularMovie> get listOfPopularMovies => _listOfPopularMovies;
  List<TopRatedMovie> get listOfTopRatedMovies => _listOfTopRatedMovies;
  List<TrandingMovie> get listOfTrendingMovies => _listOfTrendingMovies;
  List<FavoriteMovie> get listOfFavoriteMovies => _listOfFavoriteMovies;

  bool get isLoading => _isLoading;
  String? get error => _error;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _error = message;
    notifyListeners();
  }

  // Fetch methods
  Future<void> fetchUpcomingMovies() async {
    _setLoading(true);
    _setError(null);
    try {
      _listOfUpcomingMovies = await _repository.fetchUpcomingMovies();
      notifyListeners();
    } catch (e) {
      _setError('Failed to fetch upcoming movies');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchPopularMovies() async {
    _setLoading(true);
    _setError(null);
    try {
      _listOfPopularMovies = await _repository.fetchPopularMovies();
      notifyListeners();
    } catch (e) {
      _setError('Failed to fetch popular movies');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchTopRatedMovies() async {
    _setLoading(true);
    _setError(null);
    try {
      _listOfTopRatedMovies = await _repository.fetchTopRatedMovies();
      notifyListeners();
    } catch (e) {
      _setError('Failed to fetch top-rated movies');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchTrendingMovies() async {
    _setLoading(true);
    _setError(null);
    try {
      _listOfTrendingMovies = await _repository.fetchTrendingMovies();
      notifyListeners();
    } catch (e) {
      _setError('Failed to fetch trending movies');
    } finally {
      _setLoading(false);
    }
  }
}
