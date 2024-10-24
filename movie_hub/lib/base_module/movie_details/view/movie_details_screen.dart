import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view_model/movie_details_view_model.dart';
import '../../watch_list/view_model/watch_list_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../common/network_connectivity_status.dart';
import '../../../common/offline_message_view.dart';
import '../../../video_player/video_player.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
  final bool fromWatchlist;

  MovieDetailsScreen({required this.movieId, required this.fromWatchlist});

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final MovieDetailsViewModel movieDetailsVM = MovieDetailsViewModel();

  final WatchListViewModel _viewModel = Get.find();
  final NetworkStatusController _controller = Get.find();
  bool buttonPressed = false;

  @override
  void initState() {
    super.initState();
    movieDetailsVM.getDetailsOfMovie(widget.movieId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        title: Text(AppLocalizations.of(context)!.movieDetails),
      ),
      body: Obx(() {


        if (_controller.networkStatus == NetworkStatus.Online) {
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
                        // Image.network(
                        //   'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                        //   fit: BoxFit.cover,
                        // ),
                        if (MediaQuery.of(context).orientation !=
                            Orientation.landscape)
                          SizedBox(
                            height: MediaQuery.of(context).size.width * 0.6,
                            width: MediaQuery.of(context)
                                .size
                                .width, // Set width to fill the available space
                            child:
                                MyVideoPlayer(), // Directly use the MyVideoPlayer widget without Expanded
                          ),

                        if (MediaQuery.of(context).orientation ==
                            Orientation.landscape)
                          SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.height * 1.5,
                            // Set width to fill the available space
                            child:
                                MyVideoPlayer(), // Directly use the MyVideoPlayer widget without Expanded
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
                    AppLocalizations.of(context)!.overview,
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
                        AppLocalizations.of(context)!.releaseDate,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text('${movie.releaseDate.toLocal()}'.split(' ')[0]),
                    ],
                  ),

                  SizedBox(height: 16),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 50, // Set the height
                          child: FilledButton(
                            onPressed: this.buttonPressed == false
                                ? () {
                                    if (widget.fromWatchlist) {
                                      movieDetailsVM.removeFromWatchList(
                                          movie.id, context);
                                    } else {
                                      movieDetailsVM.addToFavorite(
                                          movie.id, context);
                                    }
                                    setState(() {
                                      buttonPressed = true;
                                    });
                                  }
                                : () {
                                    if (widget.fromWatchlist) {
                                      movieDetailsVM.addToFavorite(
                                          movie.id, context);
                                    } else {
                                      movieDetailsVM.removeFromWatchList(
                                          movie.id, context);
                                    }
                                    setState(() {
                                      buttonPressed = true;
                                    });
                                  },
                            style: FilledButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10), // Corner radius of 10
                              ),
                            ),
                            child: movieDetailsVM.isLoading == true
                                ? Text(AppLocalizations.of(context)!.loading)
                                : widget.fromWatchlist
                                    ? this.buttonPressed
                                        ? Text(AppLocalizations.of(context)!
                                            .addToWatchlist)
                                        : Text(AppLocalizations.of(context)!
                                            .removeFromWatchlist)
                                    : this.buttonPressed
                                        ? Text(AppLocalizations.of(context)!
                                            .removeFromWatchlist)
                                        : Text(AppLocalizations.of(context)!
                                            .addToWatchlist),
                          ),
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 16),

                  // Genres
                  Text(
                    AppLocalizations.of(context)!.genres,
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
                        AppLocalizations.of(context)!.runtime,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
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
                        AppLocalizations.of(context)!.rating,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text('${movie.voteAverage} (${movie.voteCount} votes)'),
                    ],
                  ),

                  SizedBox(height: 16),

                  // Production Companies
                  Text(
                    AppLocalizations.of(context)!.productionCompanies,
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
                    AppLocalizations.of(context)!.spokenLanguages,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    children: movie.spokenLanguages
                        .map((language) =>
                            Chip(label: Text(language.englishName)))
                        .toList(),
                  ),

                  SizedBox(height: 32),

                  // Buttons: Add to Favorite and Add to Watchlist
                ],
              ),
            ),
          );
        } else {
          return Center(child: OfflineMessageWidget());
        }
      }),
    );
  }
}
