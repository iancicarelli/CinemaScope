import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:cinema/apilinks/allapi.dart';
import 'package:cinema/pages/CardSlider.dart';
import 'package:http/http.dart' as http;

class TvShows extends StatefulWidget  {
  const TvShows({Key? key}) : super(key: key);

  @override
  State<TvShows> createState() => _TvShowsState();
}

class _TvShowsState extends State<TvShows> {
  List<Map<String, dynamic>> popularTvshow = [];
  List<Map<String, dynamic>> ratedTv = [];
  List<Map<String, dynamic>> trendingTvShows = [];

  Future<void> fetchPopularTvShows() async {
    var response = await http.get(Uri.parse(TvPopular));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var tvJson = data['results'];
      setState(() {
        popularTvshow = List<Map<String, dynamic>>.from(tvJson.map((tv) {
          return {
            'id': tv['id'],
            'poster_path': tv['poster_path'],
            'title': tv['name'], // Cambia 'title' a 'name' si es para TV
          };
        }));
      });
    }
  }

  // Función para obtener programas de TV mejor calificados
  Future<void> fetchRatedTvShows() async {
    var response = await http.get(Uri.parse(TvRated));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var tvJson = data['results'];
      setState(() {
        ratedTv = List<Map<String, dynamic>>.from(tvJson.map((tv) {
          return {
            'id': tv['id'],
            'poster_path': tv['poster_path'],
            'title': tv['name'],
          };
        }));
      });
    }
  }

  // Función para obtener programas de TV en tendencia
  Future<void> fetchTrendingTvShows() async {
    var response = await http.get(Uri.parse(trendingTV));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var tvJson = data['results'];
      setState(() {
        trendingTvShows = List<Map<String, dynamic>>.from(tvJson.map((tv) {
          return {
            'id': tv['id'],
            'poster_path': tv['poster_path'],
            'title': tv['name'],
          };
        }));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPopularTvShows();
    fetchRatedTvShows();
    fetchTrendingTvShows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Shows'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'TV Popular',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            CardSlider(movies: popularTvshow),
            const SizedBox(height: 20), // Espacio entre componentes

            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Top Rated TV',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            CardSlider(movies: ratedTv),
            const SizedBox(height: 20), // Espacio entre componentes

            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Trending TV',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            CardSlider(movies: trendingTvShows),
          ],
        ),
      ),
    );
  }
}