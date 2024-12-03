import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../model/home_screen_models.dart';
import '../model/popular_movies_model.dart';
import '../model/tranding_movie_list_model.dart';
import '../../movie_details/view/movie_details_screen.dart';
import 'package:get/get.dart';


// Your Result class and related dependencies go here.

class TrandingHorizontalMovieList extends StatelessWidget {
  final List<TrandingMovie> movies;

  TrandingHorizontalMovieList({required this.movies});

  @override
  Widget build(BuildContext context) {
    // Get the screen height to calculate 0.2 of it
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: 200, // 20% of screen height
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Horizontal scrolling
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];

          return MovieCard(movie: movie);
        },
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final TrandingMovie movie;

  MovieCard({required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('movie id = ${movie.id}');
        Get.to(MovieDetailsScreen(movieId: movie.id,fromWatchlist: false));

      },
      child: Container(
        width: 150, // Set a fixed width for the movie card
        margin: EdgeInsets.symmetric(horizontal: 8), // Add some margin between cards
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.onSurface,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.surface,
              blurRadius: 6,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie poster image
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            // Movie title and rating
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.surface,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 14),
                      SizedBox(width: 4),
                      Text(
                        movie.voteAverage.toString(),
                        style: TextStyle(fontSize: 12,color: Theme.of(context).colorScheme.surface),
                      ),
                      Spacer(),
                      Icon(Icons.people, color: Colors.yellow, size: 14),
                      SizedBox(width: 4),
                      Text(
                        movie.popularity.toString(),
                        style: TextStyle(fontSize: 12,color: Theme.of(context).colorScheme.surface),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
