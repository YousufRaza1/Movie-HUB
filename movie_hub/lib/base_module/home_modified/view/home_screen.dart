import 'package:flutter/material.dart';
import 'dart:async';
import 'banner_view.dart';
import 'horizontal_movie_list.dart';
import 'top_rated_movie_horizontal_card_view.dart';
import 'tranding_horizontal_card_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../common/network_connectivity_status.dart';
import '../../../common/offline_message_view.dart';
import '../view_model/home_view_model.dart';

class HomeScreenNew extends StatefulWidget {
  const HomeScreenNew({super.key});

  @override
  State<HomeScreenNew> createState() => _HomeScreenNewState();
}

class _HomeScreenNewState extends State<HomeScreenNew> {
  late HomeViewModel viewModel;
  int currentIndex = 0;
  Timer? _timer;
  final NetworkStatusController _controller = NetworkStatusController();

  @override
  void initState() {
    super.initState();
    viewModel = HomeViewModel(); // Initialize the ViewModel
    fetchMovies();

    // Start a periodic timer that increments currentIndex every 3 seconds
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        currentIndex++;
        int listLength = viewModel.listOfUpcomingMovies.length;
        if (currentIndex >= listLength) {
          currentIndex = 0;
        }
      });
    });
  }

  void fetchMovies() async {
    await viewModel.fetchUpcomingMovies();
    await viewModel.fetchPopularMovies();
    await viewModel.fetchTopRatedMovies();
    await viewModel.fetchTrendingMovies();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) => SingleChildScrollView(
            child: Column(
              children: [
                // Show offline message if the network is offline
                // _controller.networkStatus == NetworkStatus.Online
                //     ? Container()
                //     : OfflineMessageWidget(),

                // Display banner or loader if no upcoming movies
                viewModel.listOfUpcomingMovies.isEmpty
                    ? BannerViewLoader()
                    : AnimatedSwitcher(
                        duration: Duration(seconds: 1),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return FadeTransition(
                              opacity: animation, child: child);
                        },
                        child: BannerView(
                          key: ValueKey<int>(currentIndex),
                          movieResult:
                              viewModel.listOfUpcomingMovies[currentIndex],
                        ),
                      ),

                MovieTypeTitle(
                    title: AppLocalizations.of(context)!.popularMovies),
                SizedBox(height: 5),
                viewModel.listOfPopularMovies.isNotEmpty
                    ? HorizontalMovieList(movies: viewModel.listOfPopularMovies)
                    : HorizontalMovieListLoader(),

                MovieTypeTitle(
                    title: AppLocalizations.of(context)!.topRatedMoviesTitle),
                SizedBox(height: 5),
                viewModel.listOfTopRatedMovies.isNotEmpty
                    ? TopRatedHorizontalMovieList(
                        movies: viewModel.listOfTopRatedMovies)
                    : HorizontalMovieListLoader(),

                MovieTypeTitle(
                    title: AppLocalizations.of(context)!.trendingMovies),
                SizedBox(height: 5),
                viewModel.listOfTrendingMovies.isNotEmpty
                    ? TrandingHorizontalMovieList(
                        movies: viewModel.listOfTrendingMovies)
                    : HorizontalMovieListLoader(),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MovieTypeTitle extends StatelessWidget {
  final String title;

  MovieTypeTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
      child: Row(
        children: [
          Text(
            '$title',
            style: TextStyle(fontSize: 25),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
