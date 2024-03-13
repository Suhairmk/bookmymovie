import 'package:dio/dio.dart';
import 'package:jobdemo/data%20models/allMovie.dart';
import 'package:jobdemo/data%20models/castModel.dart';

final dio = Dio();

Future<List<Movie>> fetchMovies() async {
  try {
    final response = await dio.get('https://api.tvmaze.com/shows');

    List<Movie> movies = [];
    if (response.statusCode == 200) {
      List<dynamic> responseData = response.data;
      print(responseData);
      movies = responseData.map((json) => Movie.fromJson(json)).toList();
    } else {
      print('Failed to load movies');
    }

    return movies;
  } catch (e) {
    print('Error fetching movies: $e');
    return [];
  }
}

Future<List<Cast>> fetchCast(id) async {
  try {
    final response = await dio.get('https://api.tvmaze.com/shows/$id/cast');

    List<Cast> cast = [];
    if (response.statusCode == 200) {
      List<dynamic> responseData = response.data;
      print(responseData);
      cast = responseData.map((json) => Cast.fromJson(json)).toList();
    } else {
      print('Failed ');
    }

    return cast;
  } catch (e) {
    print('Error : $e');
    return [];
  }
}
