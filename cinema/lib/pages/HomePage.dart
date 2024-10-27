import 'dart:convert';
import 'package:cinema/pages/CardSlider.dart';
import 'package:cinema/pages/Carousel.dart';
import 'package:cinema/apilinks/allapi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> trendinglist = [];
  List<Map<String, dynamic>> topRatedMovies = [];

  // Función para obtener las películas populares
  Future<void> trendinglisthome() async {
    var trendingweekresponse = await http.get(Uri.parse(popularMovies));
    if (trendingweekresponse.statusCode == 200) {
      var tempdata = jsonDecode(trendingweekresponse.body);
      var trendingweekJson = tempdata['results'];
      setState(() {
        trendinglist = List<Map<String, dynamic>>.from(trendingweekJson.map((movie) {
          return {
            'id': movie['id'],
            'poster_path': movie['poster_path'],
            'vote_average': movie['vote_average'],
            'media_type': movie['media_type'],
          };
        }));
      });
    }
  }

  // Función para obtener las películas mejor calificadas
  Future<void> fetchTopRatedMovies() async {
    var response = await http.get(Uri.parse(topRated));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var moviesJson = data['results'];
      setState(() {
        topRatedMovies = List<Map<String, dynamic>>.from(moviesJson.map((movie) {
          return {
            'id': movie['id'],
            'poster_path': movie['poster_path'],
            'title': movie['title'],
          };
        }));
      });
    } else {
      throw Exception('Error al cargar las películas');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTopRatedMovies();
    trendinglisthome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            toolbarHeight: 60,
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.5,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: trendinglist.isNotEmpty
                  ? MovieCarousel(trendinglist: trendinglist)
                  : Center(
                child: CircularProgressIndicator(color: Colors.yellow),
              ),
            ),
            title: Text(
              'Trending',
              style: TextStyle(color: Colors.yellow, fontSize: 16),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: topRatedMovies.isNotEmpty
                    ? CardSlider(movies: topRatedMovies) // Slider para las top-rated
                    : Center(
                  child: CircularProgressIndicator(
                    color: Colors.yellow,
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}