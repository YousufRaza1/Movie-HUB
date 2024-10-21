import 'package:flutter/material.dart';
import '../view_model/searched_movie_list_view_model.dart';
import 'package:get/get.dart';
import '../../movie_details/view/movie_details_screen.dart';

class SearchMoviesScreen extends StatefulWidget {
  const SearchMoviesScreen({super.key});

  @override
  State<SearchMoviesScreen> createState() => _SearchMoviesScreenState();
}

class _SearchMoviesScreenState extends State<SearchMoviesScreen> {
  final TextEditingController _searchController = TextEditingController();
  final SearchedMoviesListViewModel viewModel = Get.put(SearchedMoviesListViewModel());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Search for movies when text in the search field changes
    _searchController.addListener(() {
      if (!viewModel.isLoading.value) {
        viewModel.getMoviesBySearch(_searchController.text, 1);
      }
    });

    // Load default movies
    viewModel.getMoviesBySearch('', 1);

    // Add scroll listener for pagination
    _scrollController.addListener(() {

      if (_scrollController.position.extentAfter <= 2000.0 &&
          !viewModel.isLoading.value) {
        viewModel.loadMoreMovies(_searchController.text);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SafeArea(
          child: Obx(() => Column(
            children: [
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search movies...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.secondary,
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              SizedBox(height: 16),
              Text('Movies found: ${viewModel.movies.length}'),
              SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  controller: _scrollController, // Attach scroll controller for pagination
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: viewModel.movies.length,
                  itemBuilder: (context, index) {
                    final movie = viewModel.movies[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(MovieDetailsScreen(movieId: movie.id, fromWatchlist: false));
                      },
                      child: Card(
                        color: Theme.of(context).colorScheme.onSurface,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie.title,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).colorScheme.surface,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Rating: ${movie.voteAverage}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Theme.of(context).colorScheme.surface,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (viewModel.isLoading.value) // Show loading indicator when fetching new data
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
            ],
          )),
        ),
      ),
    );
  }
}
