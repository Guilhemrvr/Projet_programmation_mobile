import 'package:flutter/material.dart';

import 'like.dart';
import 'whishlist.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Details extends StatefulWidget {
  final int appId;

  Details({required this.appId});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String description = '';
  String publisher = '';
  String headerImage = '';
  String name = '';

  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  Future<void> fetchDetails() async {
    final response = await http.get(Uri.parse('https://store.steampowered.com/api/appdetails?appids=${widget.appId}'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final details = json['${widget.appId}']['data'];
      setState(() {
        description = details['detailed_description'];
        publisher = details['publishers'][0];
        headerImage = details['header_image'];
        name = details['name'];
      });
    } else {
      throw Exception('Failed to load details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color.fromRGBO(30, 38, 44, 1.0),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(30, 38, 44, 1.0),
        title: Text('Détails du jeu'),
        actions: [
          IconButton(
            icon: Image.asset('assets/like.png'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Like()),
              );
            },
          ),
          IconButton(
            icon: Image.asset('assets/whishlist.png'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Whishlist()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(headerImage),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(30, 38, 44, 1.0),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(

                children: [
                  Text(
                  'Nom: $name',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Editeur: $publisher',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(
                description,
                style: TextStyle(
                  color: Colors.white,
                  backgroundColor: Color.fromRGBO(30, 38, 44, 1.0),
                ),
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      )
    );
  }
}

