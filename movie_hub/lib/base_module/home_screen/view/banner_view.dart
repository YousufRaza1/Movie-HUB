import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../model/home_screen_models.dart';

class BannerView extends StatelessWidget {
  final Result movieResult;

  const BannerView({required this.movieResult});

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height to make the banner responsive
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Adjust the height based on the screen size
    final bannerHeight = screenHeight * 0.3; // 30% of screen height

    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8
      ),
      child: Stack(
        children: [
          // Backdrop image (Poster Image)
          Container(
            width: double.infinity,
            height: bannerHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage('https://image.tmdb.org/t/p/w500${movieResult.backdropPath}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay for gradient effect
          Container(
            width: double.infinity,
            height: bannerHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          // Movie Title, Release Date, and Vote Average
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Movie Title
                SizedBox(
                  width: screenWidth * 0.8, // Text width limited to 80% of the screen
                  child: Text(
                    movieResult.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22, // Adjusted font size for better scaling
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 8),
                // Release Date
                Text(
                  'Release Date: ${movieResult.releaseDate.toLocal().toShortDateString()}',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                // Vote Average with Star Icon
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.yellow, size: 18),
                    SizedBox(width: 4),
                    Text(
                      movieResult.voteAverage.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension DateExtension on DateTime {
  String toShortDateString() {
    return "${this.year}-${this.month.toString().padLeft(2, '0')}-${this.day.toString().padLeft(2, '0')}";
  }
}
