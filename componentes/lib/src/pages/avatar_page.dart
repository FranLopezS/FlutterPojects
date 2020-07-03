import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AVATAR PAGE!'),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://www.hola.com/imagenes/actualidad/20200414165589/amaia-montero-despide-seguidores/0-810-892/amaia-montero-ig-t.jpg?filter=w600'),
              radius: 24.0,
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: CircleAvatar( //Círculo del avatar.
              child: Text('SL'),
              backgroundColor: Colors.brown,
            )
          )
        ]
      ),
      body: Center(
        child: FadeInImage(
          placeholder: AssetImage('assets/original.gif'),
          image: NetworkImage('https://lh3.googleusercontent.com/proxy/P2e4qBQlqDN7iRqHTOyD4su5SNsQyBW0F3AoEB4Pb8oyegn8MXRAjpH2T-vhMKeCAOk-gaXHGBtOizWy8UyTiuIOgLZdJYHn7Tek-lD6HZMneat17bh6vIacOCEjp9JNiICBmvpt-A'),
          fadeInDuration: Duration(milliseconds: 200),
        ),
      ),
    );
  }

}