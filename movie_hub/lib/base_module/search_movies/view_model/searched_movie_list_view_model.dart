import 'dart:ffi';

import 'package:get/get.dart';
import 'package:movie_hub/base_module/search_movies/model/searched_movie_list.dart';
import '../../../network/api_manager.dart';
import '../../../network/api_end_point.dart';
import '../../watch_list/view_model/watch_list_view_model.dart';

class SearchedMoviesListViewModel extends GetxController {
  RxBool isLoading = false.obs;
  RxList<SearchedMovie> movies = RxList<SearchedMovie>([]);


  void getMoviesBySearch(String searchedText, int pageNumber) async {
    String text = searchedText.isEmpty ? 'titanic' : searchedText;

    final APIEndpoint endpoint = APIEndpoint(
      path: '/search/movie', // Example path
      method: HTTPMethod.GET,
      headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZGMwN2RlNTA1ZTM0ZjIyY2FhYWZlNzI0ZDc1ZmVjNiIsIm5iZiI6MTcyOTA1NjE1NS43MTEwNjQsInN1YiI6IjY3MGU2YjJkMGI4MDA1MzdkNzVjZjM1NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.vu4IZ5ObJWkshT1D14mcP70iKTRaF4PCsDSHL0kgitc',

      },
      queryParams: {
        'query': text,
        'page': '${pageNumber}',
        'language': 'en-US',
        'include_adult': 'false'
      },
    );

    isLoading.value = true;

    // Clear the current list before fetching new movies
    movies.clear();

    final result = await APIManager.instance.request<SearchedMovieList>(
      endpoint,
          (data) => SearchedMovieList.fromJson(data),
    );

    isLoading.value = false;

    if (result.data != null && result.data?.results != null) {
      // Add all new movies to the existing list
      movies.addAll(result.data!.results!);
    } else {
      print('Error: ${result.error?.message}');
    }
  }
}
