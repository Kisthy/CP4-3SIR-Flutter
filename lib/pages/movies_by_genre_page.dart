import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/home/widgets/movies_horizontal_list.dart';

class MoviesByGenrePage extends StatelessWidget {
  final Result movies;

  const MoviesByGenrePage({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies by Genre'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            MoviesHorizontalList(result: movies),
          ],
        ),
      ),
    );
  }
}
