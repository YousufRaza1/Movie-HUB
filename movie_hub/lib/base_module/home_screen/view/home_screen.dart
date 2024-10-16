import 'package:flutter/material.dart';
import '../../../network/api_manager.dart';
import '../../../network/api_end_point.dart';
import 'package:get/get.dart';
import 'banner_view.dart';
import 'dart:async';
import 'horizontal_movie_list.dart';
import '../model/home_screen_models.dart';
import '../view_model/home_view_model.dart';
import 'top_rated_movie_horizontal_card_view.dart';
import 'tranding_horizontal_card_view.dart';

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
                  ? Text('${viewModel.listOfUpcomingMovies.length}')
                  : BannerView(movieResult: viewModel.listOfUpcomingMovies[currentIndex]),

              MovieTypeTitle(title: 'Popular movies'),
              SizedBox(height: 5),
              HorizontalMovieList(movies: viewModel.listOfPopularMovies),

              MovieTypeTitle(title: 'Top rated movies'),
              SizedBox(height: 5),
              TopRatedHorizontalMovieList(movies: viewModel.listOfTopRatedMovies),

              MovieTypeTitle(title: 'Top rated movies'),
              SizedBox(height: 5),
              TrandingHorizontalMovieList(movies: viewModel.listOfTrandingMovies),


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



