import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'details.dart';

Future<List<Rank>> fetchGames() async {
  try {
    final response = await http.get(
      Uri.https(
          'api.steampowered.com', '/ISteamChartsService/GetMostPlayedGames/v1'),
      headers: {
        "Access-Control-Allow-Origin": "*", // Required for CORS support to work
        "Access-Control-Allow-Credentials":
        'true', // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "GET, OPTIONS",
      },
    );

    if (response.statusCode == 200) {
      return await _getGameDetails(
          Games.fromJson(jsonDecode(response.body)).ranks);
    } else {
      throw Exception('Failed to load games: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load games: $e');
  }
}

Future<List<Rank>> _getGameDetails(List<Rank> ranks) async {
  List<Rank> updatedRanks = [];
  for (var rank in ranks) {
    final response = await http.get(
      Uri.parse(
          'https://store.steampowered.com/api/appdetails?appids=${rank.appId}'),
    );
    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      if (jsonBody[rank.appId.toString()]['success']) {
        rank.name = jsonBody[rank.appId.toString()]['data']['name'];
        rank.publisher = jsonBody[rank.appId.toString()]['data']['publishers'][0];
        rank.headerImage = jsonBody[rank.appId.toString()]['data']['header_image'];
      }
    }
    updatedRanks.add(rank);
  }
  return updatedRanks;
}

class Games {
  final int rollupDate;
  final List<Rank> ranks;

  Games({
    required this.rollupDate,
    required this.ranks,
  });

  factory Games.fromJson(Map<String, dynamic> json) {
    return Games(
      rollupDate: json['response']['rollup_date'],
      ranks: List<Rank>.from(
        json['response']['ranks'].map(
              (rankJson) => Rank.fromJson(rankJson),
        ),
      ),
    );
  }
}

class Rank {
  final int rank;
  final int appId;
  String? publisher;
  String? name;
  String? headerImage;


  Rank({
    required this.rank,
    required this.appId,
    this.publisher,
    this.name,
    this.headerImage,

  });

  factory Rank.fromJson(Map<String, dynamic> json) {
    return Rank(
        rank: json['rank'],
        appId: json['appid'],
        publisher: json['publisher'],
        name: json['name'],
        headerImage: json['headerImage'],
    );
  }
}

class Api extends StatefulWidget {
  const Api({Key? key}) : super(key: key);

  @override
  State<Api> createState() => _ApiState();
}

class _ApiState extends State<Api> {
  late Future<List<Rank>> futureGames;

  @override
  void initState() {
    super.initState();
    futureGames = fetchGames();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /*routes: {
        '/details': (context) => Details(),
      },*/
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(30, 38, 44, 1.0),
        body: Center(
          child: FutureBuilder<List<Rank>>(
            future: futureGames,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final ranks = snapshot.data!;
                return ListView.builder(
                  itemCount: ranks.length,
                  itemBuilder: (context, index) {
                    final rank = ranks[index];
                    return ListTile(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.network(
                            rank.headerImage.toString(),
                            height: 80,
                            width: 50,
                          ),
                        ],
                      ),
                        title: Text(
                          '${rank.rank}. ${rank.name}',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Arial',
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          'Publisher: ${rank.publisher}}',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Arial',
                            color: Colors.white,
                          ),
                        ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          /*Navigator.pushNamed(
                            context,
                            '/details',
                            arguments: {'name': rank.name, 'appid': rank.appId},
                          );*/
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Details(appId: rank.appId)),
                          );
                        },
                        child: Text('En savoir plus'),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}