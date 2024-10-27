import 'package:flutter/material.dart';

class CardSlider extends StatelessWidget {
  final List<Map<String, dynamic>> movies;

  const CardSlider({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250, // Ajusta la altura según el diseño
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.35), // Para mostrar 3 tarjetas
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          String imageUrl = 'https://image.tmdb.org/t/p/w500${movie['poster_path']}';
          String movieTitle = movie['title'] ?? 'No title';

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  movieTitle,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis, // Para limitar el texto largo
                  maxLines: 1,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
