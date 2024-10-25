import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../model/movie_details_model.dart';
import '../../../network/api_manager.dart';
import '../../../network/api_end_point.dart';
import '../../watch_list/view_model/watch_list_view_model.dart';
import 'dart:math';

class MovieDetailsViewModel extends GetxController {
  Rxn<MovieDetailsModel> movieDetails = Rxn<MovieDetailsModel>();

  RxBool isLoading = false.obs;
  WatchListViewModel watchListViewModel = Get.find();

  List<String> movieLink = [];
  var singleton1 = MovieProvider();

  String getRandomMovieLink() {
    return singleton1.getARandomMovieLink();
  }

  void addToFavorite(int movieId, BuildContext context) async {
    final APIEndpoint endpoint = APIEndpoint(
        path:
            '/account/21572778/favorite?session_id=7f54d9be5fb4c228621bd97367ae3f420c962f22',
        method: HTTPMethod.POST,
        headers: {
          'accept': 'application/json',
          'content-type': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZGMwN2RlNTA1ZTM0ZjIyY2FhYWZlNzI0ZDc1ZmVjNiIsIm5iZiI6MTcyOTA1NjE1NS43MTEwNjQsInN1YiI6IjY3MGU2YjJkMGI4MDA1MzdkNzVjZjM1NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.vu4IZ5ObJWkshT1D14mcP70iKTRaF4PCsDSHL0kgitc',
        },
        queryParams: {
          'session_id': '7f54d9be5fb4c228621bd97367ae3f420c962f22',
        },
        body: {
          'media_id': movieId,
          'media_type': 'movie',
          'favorite': true,
        });
    isLoading.value = true;

    final result = await APIManager.instance.request<AddFavoriteSuccess>(
      endpoint,
      (data) => AddFavoriteSuccess.fromJson(
          data), // Convert the raw response into MovieDetailsModel
    );

    // Handle the result
    isLoading.value = false;
    if (result.data != null) {
      print('add to favorite success');
      showToast(context, '${result.data!.statusMessage}');
      print(result.data!);
      watchListViewModel.fetchFavoriteMovies();
    } else {
      // Handle the error
      print('${result.error?.message}');
      // showToast(context, 'Add to watchlist fail');
      print('Error: ${result.error?.message}');
    }
  }

  void removeFromWatchList(int movieId, BuildContext context) async {
    final APIEndpoint endpoint = APIEndpoint(
        path:
            '/account/21572778/favorite?session_id=7f54d9be5fb4c228621bd97367ae3f420c962f22',
        method: HTTPMethod.POST,
        headers: {
          'accept': 'application/json',
          'content-type': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZGMwN2RlNTA1ZTM0ZjIyY2FhYWZlNzI0ZDc1ZmVjNiIsIm5iZiI6MTcyOTA1NjE1NS43MTEwNjQsInN1YiI6IjY3MGU2YjJkMGI4MDA1MzdkNzVjZjM1NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.vu4IZ5ObJWkshT1D14mcP70iKTRaF4PCsDSHL0kgitc',
        },
        queryParams: {
          'session_id': '7f54d9be5fb4c228621bd97367ae3f420c962f22',
        },
        body: {
          'media_id': movieId,
          'media_type': 'movie',
          'favorite': false,
        });

    isLoading.value = true;

    final result = await APIManager.instance.request<AddFavoriteSuccess>(
      endpoint,
      (data) => AddFavoriteSuccess.fromJson(
          data), // Convert the raw response into MovieDetailsModel
    );

    // Handle the result
    isLoading.value = false;

    if (result.data != null) {
      print('Remove form watchlist success');
      showToast(context, '${result.data!.statusMessage}');
      print(result.data!);
      watchListViewModel.fetchFavoriteMovies();
    } else {
      print('add to favorite fail');
      showToast(context, '${result.error?.message}');
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
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZGMwN2RlNTA1ZTM0ZjIyY2FhYWZlNzI0ZDc1ZmVjNiIsIm5iZiI6MTcyOTA1NjE1NS43MTEwNjQsInN1YiI6IjY3MGU2YjJkMGI4MDA1MzdkNzVjZjM1NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.vu4IZ5ObJWkshT1D14mcP70iKTRaF4PCsDSHL0kgitc',
        });

    // Call the API manager
    final result = await APIManager.instance.request<MovieDetailsModel>(
      endpoint,
      (data) => MovieDetailsModel.fromJson(
          data), // Convert the raw response into MovieDetailsModel
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

  void showToast(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class MovieProvider {
// Private constructor
  MovieProvider._privateConstructor();

// Static instance of the class, only one instance will be created
  static final MovieProvider _instance = MovieProvider._privateConstructor();

// Factory constructor to return the same instance every time
  factory MovieProvider() {
    return _instance;
  }

// Example method to demonstrate functionality
  List<String> listOfmovieLink = [
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4'
  ];

  String getARandomMovieLink() {
    var random = Random();
    int randomIndex = random.nextInt(listOfmovieLink.length);
    return listOfmovieLink[randomIndex];
  }
}
