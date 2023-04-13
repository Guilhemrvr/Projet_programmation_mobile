import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'user_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'inscription.dart';
import 'accueil.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (_) => UserBloc(),
      child: BlocListener<UserBloc, UserState>(
        listener: (BuildContext context, UserState state) {
          if (state.connected) {
            _navigatorKey.currentState!.pushReplacement(
              MaterialPageRoute(
                builder: (context) => const Accueil(),
              ),
            );
            // Accueil
          } else {
            // Connexion
            _navigatorKey.currentState!.pushReplacement(
              MaterialPageRoute(
                builder: (context) => const Connexion(),
              ),
            );
          }
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: _navigatorKey,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const Connexion(),
        ),
      ),
    );
  }
}

class Connexion extends StatefulWidget {
  const Connexion({Key? key}) : super(key: key);

  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300], // Changed background color to light gray
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
                'Bienvenue !',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Veuillez vous connecter ou \ncréer un nouveau compte \npour utiliser l\'application',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _emailController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  filled: true,
                  fillColor: Color.fromRGBO(30, 38, 44, 1.0),
                  labelStyle: TextStyle(color: Colors.white),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  filled: true,
                  fillColor: Color.fromRGBO(30, 38, 44, 1.0),
                  labelStyle: TextStyle(color: Colors.white),
                  alignLabelWithHint: true,
                ),
                obscureText: true,
              ),
              const SizedBox(height: 32.0),
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Color.fromRGBO(99, 106, 245, 1.0)),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: Text('Se connecter'),
                onPressed: () {
                  final String mail = _emailController.text.trim();
                  final String mdp = _passwordController.text.trim();
                  BlocProvider.of<UserBloc>(context).add(ConnectUserEvent(mail, mdp));
                },
              ),
              TextButton(
                style: ButtonStyle(
                  side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(
                      color: Color.fromRGBO(99, 106, 245, 1.0),
                      width: 2.0,
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: Text('Créer un nouveau compte'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Inscription()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


