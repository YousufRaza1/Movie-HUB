import '../model/favorite_movie_List.dart';
import 'package:get/get.dart';
import '../../../network/api_end_point.dart';
import '../../../network/api_manager.dart';

class WatchListViewModel extends GetxController {
  RxBool isApiCalled = true.obs;

  RxList<FavoriteMovie> listOfFavoriteMovies = <FavoriteMovie>[].obs;
  void fetchFavoriteMovies() async {
    // Define the endpoint with headers and query parameters
    listOfFavoriteMovies.clear();
    final APIEndpoint endpoint = APIEndpoint(
      path: '/account/21572778/favorite/movies?language=en-US&page=1&session_id=7f54d9be5fb4c228621bd97367ae3f420c962f22',
      method: HTTPMethod.GET,
      headers: {
        'accept': 'application/json',
        'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxZGMwN2RlNTA1ZTM0ZjIyY2FhYWZlNzI0ZDc1ZmVjNiIsIm5iZiI6MTcyOTA1NjE1NS43MTEwNjQsInN1YiI6IjY3MGU2YjJkMGI4MDA1MzdkNzVjZjM1NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.vu4IZ5ObJWkshT1D14mcP70iKTRaF4PCsDSHL0kgitc',
      },


    );

    // Call the API manager
    final result = await APIManager.instance.request<FavoriteMovieList>(
      endpoint,
          (data) => FavoriteMovieList.fromJson(data), // Convert the raw response into PopularMoviesList
    );

    // Handle the result
    if (result.data != null) {
      if (result.data?.results!= null) {
        listOfFavoriteMovies.addAll(result.data!.results!); // Add new items
      }
      print('fetching favorite movies success');
    } else {
      // Handle the error
      print('favorite fail');
      print('Error: ${result.error?.message}');
    }
  }
}