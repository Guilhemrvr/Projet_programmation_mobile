import 'package:flutter/material.dart';

class Whishlist extends StatefulWidget {
  const Whishlist({Key? key}) : super(key: key);

  @override
  State<Whishlist> createState() => _WhishlistState();
}

class _WhishlistState extends State<Whishlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
        appBar: AppBar(backgroundColor: Color.fromRGBO(30, 38, 44, 1.0),
          title: Text('Ma liste de souhaits'),
        )
    );
  }
}
