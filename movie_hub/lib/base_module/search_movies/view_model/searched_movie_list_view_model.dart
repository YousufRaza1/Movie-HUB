import 'package:get/get.dart';
import 'package:movie_hub/base_module/search_movies/model/searched_movie_list.dart';
import '../../../network/api_manager.dart';
import '../../../network/api_end_point.dart';

class SearchedMoviesListViewModel extends GetxController {
  RxBool isLoading = false.obs;
  RxList<SearchedMovie> movies = RxList<SearchedMovie>([]);
  int currentPage = 1;
  bool hasMore = true;

  // Fetch movies based on the search query
  void getMoviesBySearch(String searchedText, int pageNumber) async {
    if (isLoading.value || !hasMore) return; // Prevent loading when already in progress or no more pages available

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
        'page': '$pageNumber',
        'language': 'en-US',
        'include_adult': 'false',
      },
    );

    isLoading.value = true;

    final result = await APIManager.instance.request<SearchedMovieList>(
      endpoint,
          (data) => SearchedMovieList.fromJson(data),
    );

    isLoading.value = false;

    if (result.data != null && result.data?.results != null) {
      if (pageNumber == 1) {
        // Clear list if fetching first page
        movies.value = result.data!.results!;
      } else {
        // Append the new results to the list
        movies.addAll(result.data!.results!);
      }

      currentPage = pageNumber;
      hasMore = result.data!.results!.isNotEmpty; // Check if more pages are available
    } else {
      hasMore = false;
      print('Error: ${result.error?.message}');
    }
  }

  // Load more movies
  void loadMoreMovies(String searchedText) {
    if (hasMore) {
      getMoviesBySearch(searchedText, currentPage + 1); // Increment page and fetch more
    }
  }
}
