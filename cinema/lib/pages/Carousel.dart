import 'package:flutter/material.dart';

class MovieCarousel extends StatefulWidget {
  final List<Map<String, dynamic>> trendinglist; // Recibe la lista de películas

  const MovieCarousel({Key? key, required this.trendinglist}) : super(key: key);

  @override
  _MovieCarouselState createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousel> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Ajustamos la altura para que sea como un banner
        SizedBox(
          height: 400, // Ajusta el tamaño del banner (puedes cambiar el valor según prefieras)
          child: PageView.builder(
            itemCount: widget.trendinglist.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final item = widget.trendinglist[index];
              String imageUrl = 'https://image.tmdb.org/t/p/original${item['poster_path']}';

              return GestureDetector(
                onTap: () {
                  // Acción al tocar un elemento
                },
                child: Container(
                  // Ajustamos el tamaño y estilo del contenedor
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5),
                        BlendMode.darken,
                      ),
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        // Indicadores de página
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.trendinglist.length,
                (index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentIndex == index ? Colors.yellow : Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}