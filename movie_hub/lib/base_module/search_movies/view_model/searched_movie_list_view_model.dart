import 'package:get/get.dart';
import 'package:movie_hub/base_module/search_movies/model/searched_movie_list.dart';
import '../../../network/api_manager.dart';
import '../../../network/api_end_point.dart';


class SearchedMoviesListViewModel extends GetxController {
  RxList<SearchedMovie> movies = RxList<SearchedMovie>([]);
  void getMoviesBySearch(String searchedText) async {
    movies = RxList<SearchedMovie>([]);
    String text = '';
    if(searchedText == '')
      {
        text = 'love';
      }
    final APIEndpoint endpoint = APIEndpoint(
      path: '/search/movie', // Example path
      method: HTTPMethod.GET,
      headers: {
        'accept': 'application/json',
        'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZGMwN2RlNTA1ZTM0ZjIyY2FhYWZlNzI0ZDc1ZmVjNiIsIm5iZiI6MTcyOTA1NjE1NS43MTEwNjQsInN1YiI6IjY3MGU2YjJkMGI4MDA1MzdkNzVjZjM1NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.vu4IZ5ObJWkshT1D14mcP70iKTRaF4PCsDSHL0kgitc',
      },
      queryParams: {
        'query': '${text}',
        'page': '1',
        'language': 'en-US',
        'include_adult': 'false'
      },
    );

    // Call the API manager
    final result = await APIManager.instance.request<SearchedMovieList>(
      endpoint,
          (data) => SearchedMovieList.fromJson(data), // Convert the raw response into PopularMoviesList
    );

    // Handle the result
    if (result.data != null) {
      if (result.data?.results != null) {
        movies.addAll(result.data!.results!);
      }
      print('upcoming success');
    } else {
      // Handle the error
      print('upcoming fail');
      print('Error: ${result.error?.message}');
    }

  }

}