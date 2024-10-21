import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view_model/watch_list_view_model.dart';
import '../../movie_details/view/movie_details_screen.dart';
import '../model/favorite_movie_List.dart';

class WatchListScreen extends StatefulWidget {
  @override
  _WatchListScreenState createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  final WatchListViewModel _viewModel = Get.find();

  @override
  void initState() {
    super.initState();
    _viewModel.fetchFavoriteMovies();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Movies'),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: _viewModel.listOfFavoriteMovies.length,
          itemBuilder: (context, index) {
            final movie = _viewModel.listOfFavoriteMovies[index];

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  print('movie id ${movie.id}');
                  // Mark the API call as not completed
                  _viewModel.isApiCalled.value = false;

                  // Navigate to the movie details screen and wait for the result
                  final result = await Get.to(MovieDetailsScreen(
                    movieId: movie.id,
                    fromWatchlist: true,
                  ));

                  // If the result is true, refresh the watchlist (fetch the movies again)
                  if (result == true) {
                    _viewModel.fetchFavoriteMovies();
                  }
                },
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        // Movie poster
                        Container(
                          width: 100,
                          height: 150,
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 10),
                        // Movie details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                movie.title,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Release Date: ${movie.releaseDate != null ? movie.releaseDate.toString().split(' ')[0] : 'Unknown'}',
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(height: 8),
                              Text(
                                movie.overview,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            );
          },
        );
      }),
    );
  }



  @override
  void dispose() {
    // Clean up resources if needed
    super.dispose();
  }
}

