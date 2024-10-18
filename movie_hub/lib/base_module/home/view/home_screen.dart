import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'banner_view.dart';
import 'dart:async';
import 'horizontal_movie_list.dart';
import '../view_model/home_view_model.dart';
import 'top_rated_movie_horizontal_card_view.dart';
import 'top_rated_movie_horizontal_card_view.dart';
import 'tranding_horizontal_card_view.dart';
import '../../../video_player/video_player.dart';
import 'favorite_movie_list_horizontal_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final viewModel = HomeViewController();
  int currentIndex = 0;
  Timer? _timer;


  @override
  void initState() {
    super.initState();
    viewModel.fetchIncomingMovies();
    viewModel.fetchPopularMovies();
    viewModel.fetchTopRatedMovies();
    viewModel.fetchTrandingMoives();
    // Start a periodic timer that increments currentIndex every 3 seconds
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        currentIndex++;
        int listLength = viewModel.listOfUpcomingMovies.length; // Replace with actual length of your list
        if (currentIndex >= listLength) {
          currentIndex = 0;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Obx(
          () => Column(
            children: [

              viewModel.listOfUpcomingMovies.length == 0
                  ? BannerViewLoader()
                  : AnimatedSwitcher(
                duration: Duration(seconds: 1),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: BannerView(
                    key: ValueKey<int>(currentIndex),
                    movieResult: viewModel.listOfUpcomingMovies[currentIndex]
                ),
              ),

              MovieTypeTitle(title: 'Popular movies'),
              SizedBox(height: 5),
              viewModel.listOfPopularMovies.length > 0 ? HorizontalMovieList(movies: viewModel.listOfPopularMovies): HorizontalMovieListLoader(),

              MovieTypeTitle(title: 'Top rated movies'),
              SizedBox(height: 5),
              viewModel.listOfTopRatedMovies.length > 0 ? TopRatedHorizontalMovieList(movies: viewModel.listOfTopRatedMovies):HorizontalMovieListLoader(),

              MovieTypeTitle(title: 'Trading movies'),
              SizedBox(height: 5),
              viewModel.listOfTrandingMovies.length > 0 ? TrandingHorizontalMovieList(movies: viewModel.listOfTrandingMovies):HorizontalMovieListLoader(),
              // MovieTypeTitle(title: 'Favorite movies'),
              // SizedBox(height: 5),
              // viewModel.listOfFavoriteMovies.length > 0 ? HorizontalFavoriteMovieList(movies: viewModel.listOfFavoriteMovies): HorizontalMovieListLoader(),


            ],
          ),
        )),
      ),
    );
  }
}

class MovieTypeTitle extends StatelessWidget {
  MovieTypeTitle({required this.title});

  String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 10
      ),
      child: Row(
        children: [
          Text('${title}',style:TextStyle(fontSize: 25) ),
          Spacer()
        ],
      ),
    );
  }
}



