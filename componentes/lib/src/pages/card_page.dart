import 'package:flutter/material.dart';
 
class CardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cards'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.adjust
        )
      ),
      body: ListView(
        //padding: EdgeInsets.symmetric(horizontal: 50.0), // Padding solo a los lados. Si fuese vertical, sería arriba y abajo.
        padding: EdgeInsets.all(20.0), // Padding en todas las direcciones.
        children: <Widget>[
          _cardTipo1(),
          SizedBox(height: 30.0),
          _cardTipo2(),
          SizedBox(height: 30.0),
           _cardTipo1(),
          SizedBox(height: 30.0),
          _cardTipo2(),
          SizedBox(height: 30.0),
           _cardTipo1(),
          SizedBox(height: 30.0),
          _cardTipo2(),
          SizedBox(height: 30.0),
           _cardTipo1(),
          SizedBox(height: 30.0),
          _cardTipo2(),
          SizedBox(height: 30.0),
           _cardTipo1(),
          SizedBox(height: 30.0),
          _cardTipo2(),
          SizedBox(height: 30.0)
        ]
      ),
    );
  }

  Widget _cardTipo1() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0)
      ),
      elevation: 10.0, // sombra
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.photo_album, color: Colors.blue),
            title: Text('Título de esta tarjeta'),
            subtitle: Text('Descripción de la tarjeta de prueba que se está mostrando en este mismo momento.'),
          ),
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () {},
                child: Text('Cancelar')
              ),
              FlatButton(
                onPressed: () {},
                child: Text('OK')
              )
            ],
            mainAxisAlignment: MainAxisAlignment.end, // Alinear al final.
          )
        ],
      ),
    );
  }

  Widget _cardTipo2() {
    final card = Container(
      child: Column(
        children: <Widget>[
          FadeInImage( // Imagen que lleva placeholder. Mejor que Image.
            placeholder: AssetImage('assets/original.gif'), // Img que sale hasta que carga la normal.
            image: NetworkImage('https://iso.500px.com/wp-content/uploads/2017/10/PhotographingTwilight_TannerWendellStewart-218136823.jpg'),
            fadeInDuration: Duration(milliseconds: 200), //tiempo que tarda en salir la img.
            height: 300,
            fit: BoxFit.cover,
          ),
          /*Image(
            image: NetworkImage('https://iso.500px.com/wp-content/uploads/2017/10/PhotographingTwilight_TannerWendellStewart-218136823.jpg')
          ),*/
          Container(
            padding: EdgeInsets.all(10.0),
            child:  Text('No tengo idea de qué poner.')
          )
        ],
      ),
    );

    // Metemos la card en un container para que la img
    // respete los bordes.
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(0.0, 5.0)//posición
          )
        ],
        borderRadius: BorderRadius.circular(30.0)
      ),
      child: ClipRRect( // Widget que corta cualquier cosa fuera del container.
        child: card,
        borderRadius: BorderRadius.circular(30.0),
      )
    );
  }

}
