import 'package:flutter/material.dart';
import '../view_model/searched_movie_list_view_model.dart';
import 'package:get/get.dart';

class SearchMoviesScreen extends StatefulWidget {
  const SearchMoviesScreen({super.key});

  @override
  State<SearchMoviesScreen> createState() => _SearchMoviesScreenState();
}

class _SearchMoviesScreenState extends State<SearchMoviesScreen> {
  final TextEditingController _searchController = TextEditingController();
   SearchedMoviesListViewModel viewModel = Get.put(SearchedMoviesListViewModel());

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      print('changed');  // Print 'changed' whenever the text is updated
    });
  }


  @override
  Widget build(BuildContext context) {
    viewModel.getMoviesBySearch('');
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
                  fillColor: Colors.grey[200],
                  prefixIcon: Icon(Icons.search),

                ),
              ),
              Text('${viewModel.movies.length}'),
              
            ],
          )),
        ),
      ),
    );
  }
}
