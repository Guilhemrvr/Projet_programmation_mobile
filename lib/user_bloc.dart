import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


abstract class UserEvent {}

class ConnectUserEvent extends UserEvent {
  final String mail;
  final String mdp;

  ConnectUserEvent(this.mail, this.mdp);
}

class SignUpEvent extends UserEvent {
  final String mail;
  final String mdp;

  SignUpEvent(this.mail, this.mdp);
}

class DisconnectUserEvent extends UserEvent {}

// State
class UserState {
  final bool connected;

  UserState(this.connected);
}

// Bloc
class UserBloc extends Bloc<UserEvent, UserState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserBloc() : super(UserState(false)) {
    on<ConnectUserEvent>(_onConnect);
    on<SignUpEvent>(_signUp);
    on<DisconnectUserEvent>(_onDisconnect);
  }

  Future<void> _onConnect(ConnectUserEvent event, emit) async {
    try {
      UserCredential  credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.mail,//'admin@gmail.com', // //
          password: event.mdp//'flutte' // //
      );
      emit(UserState(true));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }

    //emit(UserState(true));
  }

  Future<void> _onDisconnect(event, emit) async {
    await FirebaseAuth.instance.signOut();
    emit(UserState(false));
  }

  Future<void> _signUp( SignUpEvent event, emit) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: event.mail,
        password: event.mdp,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

  }


}
