import 'package:flutter/material.dart';

class Like extends StatefulWidget {
  const Like({Key? key}) : super(key: key);

  @override
  State<Like> createState() => _LikeState();
}

class _LikeState extends State<Like> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
        appBar: AppBar(backgroundColor: Color.fromRGBO(30, 38, 44, 1.0),
          /*actions: [
            IconButton(
              icon: Image.asset('assets/close.png'),
              onPressed: () {
                Navigator.pop(context);// do something
              },
            ),
          ],*/
          title: Text('Mes likes'),
        )
    );
  }
}
