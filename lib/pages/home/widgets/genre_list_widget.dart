import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_detail_model.dart';
import 'package:movie_app/services/api_services.dart';
import 'package:movie_app/pages/movies_by_genre_page.dart';

class GenreListWidget extends StatelessWidget {
  final ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GenreList>(
      future: apiServices.getGenres(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.genres.isEmpty) {
          return Center(child: Text('No genres available'));
        }

        final genres = snapshot.data!.genres;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Genres',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8.0,
                children: genres.map((genre) {
                  return ActionChip(
                    label: Text(genre.name),
                    backgroundColor: Colors.blueAccent.withOpacity(0.2),
                    onPressed: () {
                      _fetchMoviesByGenre(context, genre.id);
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  void _fetchMoviesByGenre(BuildContext context, int genreId) async {
    final apiServices = ApiServices();
    final movies = await apiServices.getPopularMoviesByGenre(genreId);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MoviesByGenrePage(movies: movies),
      ),
    );
  }
}
