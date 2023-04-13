import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet_programmation_mobile/user_bloc.dart';
import 'details.dart';
import 'like.dart';
import 'whishlist.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'jeu.dart';

class Accueil extends StatelessWidget {
  const Accueil({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(30, 38, 44, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(30, 38, 44, 1.0),
        title: const Text('Accueil'),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Rechercher un jeu...',
                prefixIcon: Icon(Icons.search),
                prefixIconColor: Colors.blue,
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color.fromRGBO(30, 38, 44, 1.0),
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            height: 200, // Hauteur du conteneur
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/DarkestDungeon.png'), // Image de fond
                fit: BoxFit.cover, // Redimensionnement de l'image
                scale: 0.5,
              ),
            ),
            child: Row(
              children: [
                SizedBox(width: 16), // Espace à gauche
                Container(
                  height: 135,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Darkest Dungeon II', style: TextStyle(fontSize: 18, color: Colors.white)),
                      SizedBox(height: 8),
                      Text('Darkest Dungeon II est un voyage maudit.\nAssemblez un groupe, équipez votre diligence et\ntraversez un monde en ruines', style: TextStyle(fontSize: 12, color: Colors.white)),
                      SizedBox(height: 16),
                      ElevatedButton(
                        child: Text('En savoir plus'),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Details(appId: 1940340,)),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                //Spacer(), // Espace variable pour centrer l'image
              ],
            ),
          ),
          Text('Les meilleures ventes', style: TextStyle(fontSize: 16, color: Colors.white,decoration: TextDecoration.underline,
    decorationThickness: 2, // Optionnel : pour définir l'épaisseur de la ligne de soulignement
    decorationColor: Colors.white, // Optionnel : pour définir la couleur de la ligne de soulignement
     )),
          Container(
            height: 393, // Hauteur souhaitée
            child: Api(),
          ),
        ],
      ),

    );
  }
}