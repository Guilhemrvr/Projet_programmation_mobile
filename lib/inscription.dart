import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projet_programmation_mobile/user_bloc.dart';

class Inscription extends StatefulWidget {
  const Inscription({Key? key}) : super(key: key);

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  TextEditingController _utilisateurController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _password2Controller = TextEditingController();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // changer la couleur de fond en gris clair
        body: DecoratedBox(
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage('assets/fond.png'),
        fit: BoxFit.cover,
      ),
    ),
    child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Inscription !',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: Colors.white),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Veuillez saisir ces différentes informations,\nafin que vos listes soient sauvegardées.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _utilisateurController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: 'Nom d\'utilisateur',
                filled: true, // activer le remplissage
                fillColor: Color.fromRGBO(30, 38, 44, 1.0),// couleur de fond
                labelStyle: TextStyle(color: Colors.white),
                alignLabelWithHint: true, // aligner le titre avec le texte d'entrée
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: 'E-mail',
                filled: true, // activer le remplissage
                fillColor: Color.fromRGBO(30, 38, 44, 1.0),// couleur de fond
                labelStyle: TextStyle(color: Colors.white),
                alignLabelWithHint: true, // aligner le titre avec le texte d'entrée
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                filled: true, // activer le remplissage
                fillColor: Color.fromRGBO(30, 38, 44, 1.0),// couleur de fond
                labelStyle: TextStyle(color: Colors.white),
                alignLabelWithHint: true, // aligner le titre avec le texte d'entrée
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _password2Controller,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: 'Vérification du mot de passe',
                filled: true, // activer le remplissage
                fillColor: Color.fromRGBO(30, 38, 44, 1.0),// couleur de fond
                labelStyle: TextStyle(color: Colors.white),
                alignLabelWithHint: true, // aligner le titre avec le texte d'entrée
              ),
              obscureText: true,
            ),
            const SizedBox(height: 32.0),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(
                    99, 106, 245, 1.0)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Text('S\'inscrire'),
              onPressed: () {
                final String mail = _emailController.text.trim();
                final String mdp = _passwordController.text.trim();
                BlocProvider.of<UserBloc>(context).add(SignUpEvent(mail, mdp));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
        ),
    );
  }
}
