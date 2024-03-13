import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jobdemo/data%20models/allMovie.dart';
import 'package:jobdemo/data%20models/castModel.dart';
import 'package:jobdemo/screens/castScreen.dart';
import 'package:jobdemo/utlils/api.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  MovieDetailScreen({required this.movie});
  ValueNotifier<bool> favorate = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 400,
                    width: double.infinity,
                    child: Image.network(
                      movie.image.original,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        movie.name,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Spacer(),
                      ValueListenableBuilder(
                        valueListenable: favorate,
                        builder: (context, value, child) {
                          return IconButton(
                            icon: favorate.value
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                  ),
                            onPressed: () {
                              favorate.value = !favorate.value;
                            },
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${movie.schedule.days} ${movie.schedule.time} '
                          .replaceFirst('[', '')
                          .replaceAll(']', ''),
                      style: TextStyle(fontSize: 10),
                    ),
                    SizedBox(height: 8.0),
                    SizedBox(height: 16.0),
                    Text(
                      'Type: ${movie.type.toString().split('.').last}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Language: ${movie.language.name}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Genres: ${movie.genres.map((genre) => genre.toString().split('.').last).join(', ')}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Status: ${movie.status.toString().split('.').last}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Runtime: ${movie.runtime} minutes',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Average Runtime: ${movie.averageRuntime} minutes',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Premiered: ${movie.premiered}'.substring(0, 20),
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8.0),
                    Text('Official Site:',
                        style: TextStyle(
                          fontSize: 18,
                        )),
                    Text(
                      '${movie.officialSite ?? 'Not available'}',
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Summary:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      movie.summary
                          .replaceAll(
                              RegExp(r'<\/?p>', caseSensitive: false), '')
                          .replaceAll(
                              RegExp(r'<\/?b>', caseSensitive: false), ''),
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8.0),
                    Text('Next Episode',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                    Text(
                      '${movie.links.nextepisode ?? 'Not available'}',
                      style: TextStyle(fontSize: 14, color: Colors.blue),
                    ),
                    SizedBox(height: 8.0),
                    Text('Previos Episode',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                    Text(
                      '${movie.links.previousepisode.href ?? 'Not available'}',
                      style: TextStyle(fontSize: 14, color: Colors.blue),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: () async {
                          List<Cast> castList = await fetchCast(
                            movie.id,
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CastScreen(
                                        title: movie.name,
                                        castList: castList,
                                      )));
                        },
                        child: Text('Show Cast'),
                        style:
                            ElevatedButton.styleFrom(minimumSize: Size(00, 40)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
