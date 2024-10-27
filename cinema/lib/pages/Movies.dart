import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cinema/apilinks/allapi.dart';
import 'package:cinema/pages/CardSlider.dart';
import 'package:http/http.dart' as http;


class Movies extends StatefulWidget {
  const Movies({Key? key}) : super(key: key);

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  List<Map<String, dynamic>> popMovies = [];
  List<Map<String, dynamic>> ratedMovies = [];
  List<Map<String, dynamic>> trendingMovies = [];

  Future<void> fetchPopularMovies() async {
    var response = await http.get(Uri.parse(popularMovies));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var moviesJson = data['results'];
      setState(() {
        popMovies = List<Map<String, dynamic>>.from(moviesJson.map((movie) {
          return {
            'id': movie['id'],
            'poster_path': movie['poster_path'],
            'title': movie['title'],
          };
        }));
      });
    } else {
      throw Exception('Error al cargar películas populares');
    }
  }

  Future<void> fetchRatedMovies() async {
    var response = await http.get(Uri.parse(topRated));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var moviesJson = data['results'];
      setState(() {
        ratedMovies = List<Map<String, dynamic>>.from(moviesJson.map((movie) {
          return {
            'id': movie['id'],
            'poster_path': movie['poster_path'],
            'title': movie['title'],
          };
        }));
      });
    } else {
      throw Exception('Error al cargar películas mejor calificadas');
    }
  }

  Future<void> fetchTrendingMovies() async {
    var response = await http.get(Uri.parse(trendingMovie));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var moviesJson = data['results'];
      setState(() {
        trendingMovies = List<Map<String, dynamic>>.from(moviesJson.map((movie) {
          return {
            'id': movie['id'],
            'poster_path': movie['poster_path'],
            'title': movie['title'], // Cambiar 'name' a 'title' para películas
          };
        }));
      });
    } else {
      throw Exception('Error al cargar películas en tendencia');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPopularMovies();
    fetchRatedMovies();
    fetchTrendingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Popular Movies',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            CardSlider(movies: popMovies),
            const SizedBox(height: 20), // Espacio entre componentes

            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Top Rated Movies',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            CardSlider(movies: ratedMovies),
            const SizedBox(height: 20), // Espacio entre componentes

            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Trending Movies',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            CardSlider(movies: trendingMovies),
          ],
        ),
      ),
    );
  }
}