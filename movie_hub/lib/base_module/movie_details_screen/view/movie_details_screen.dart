import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view_model/movie_details_view_model.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;

  MovieDetailsScreen({required this.movieId});

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final MovieDetailsViewModel movieDetailsVM = MovieDetailsViewModel();

  @override
  void initState() {
    super.initState();
    movieDetailsVM.getDetailsOfMovie(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        title: Text('Movie Details'),
      ),
      body: Obx(() {
        // Check if movie details are still loading or null
        if (movieDetailsVM.movieDetails.value == null) {
          return Center(child: CircularProgressIndicator());
        }

        final movie = movieDetailsVM.movieDetails.value!;

        // Build the UI
        return SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Movie poster and backdrop
                Center(
                  child: Column(
                    children: [
                      Image.network(
                        'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 16),
                      Text(
                        movie.title,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),

                // Overview
                Text(
                  'Overview',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(movie.overview),

                SizedBox(height: 16),

                // Release Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Release Date',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text('${movie.releaseDate.toLocal()}'.split(' ')[0]),
                  ],
                ),

                SizedBox(height: 16),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50, // Set the height
                        child: FilledButton(
                          onPressed: () {

                          },
                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Corner radius of 10
                            ),
                          ),
                          child: Text('Add to Favorite'),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        height: 50, // Set the height
                        child: FilledButton(
                          onPressed: () {},
                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Corner radius of 10
                            ),
                          ),
                          child: Text('Add to Watchlist'),
                        ),
                      ),
                    )
                  ],
                ),

                SizedBox(height: 16),

                // Genres
                Text(
                  'Genres',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  children: movie.genres
                      .map((genre) => Chip(label: Text(genre.name)))
                      .toList(),
                ),

                SizedBox(height: 16),

                // Runtime
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Runtime',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text('${movie.runtime} min'),
                  ],
                ),

                SizedBox(height: 16),

                // Rating and Vote Count
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Rating',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text('${movie.voteAverage} (${movie.voteCount} votes)'),
                  ],
                ),

                SizedBox(height: 16),

                // Production Companies
                Text(
                  'Production Companies',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: movie.productionCompanies
                      .map((company) => Text(company.name))
                      .toList(),
                ),

                SizedBox(height: 16),

                // Spoken Languages
                Text(
                  'Spoken Languages',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  children: movie.spokenLanguages
                      .map(
                          (language) => Chip(label: Text(language.englishName)))
                      .toList(),
                ),

                SizedBox(height: 32),

                // Buttons: Add to Favorite and Add to Watchlist
              ],
            ),
          ),
        );
      }),
    );
  }
}
