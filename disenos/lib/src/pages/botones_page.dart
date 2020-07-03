import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class BotonesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _crearApp(),
          SingleChildScrollView(
            child: Column(
              children: [
                _titulos(),
                _botonesRedondeados()
              ],
            )
          )
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(context)
    );
  }

  Widget _crearApp() {
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: FractionalOffset(0.0, 0.6),
          end: FractionalOffset(0.0, 1.0),
          colors: [
            Color.fromRGBO(52, 54, 101, 1.0),
            Color.fromRGBO(35, 37, 57, 1.0)
          ]
        )
      ),
    );

    final cajaRosa = Transform.rotate(
      angle: -pi / 5.0,
      child: Container(
        height: 360.0,
        width: 360.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80.0),
          color: Colors.pink,
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(236, 98, 188, 1.0),
              Color.fromRGBO(241, 142, 172, 1.0)
            ]
          )
        ),
      ),
    );

    return Stack(
      children: [
        gradiente,
        Positioned( // Para posicionar en pantalla algo que ya existe.
          child: cajaRosa,
          top: -100.0,
          right: 60.0,
        )
      ],
    );
  }
  
  Widget _titulos() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Diseño de botones', style: TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold)),
            Text('Este diseño tiene el efecto \'blur\'', style: TextStyle(color: Colors.white, fontSize: 18.0)),
          ],
        ),
      )
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        // propiedades q quiero cambiar del tema.
        // ponemos color al BottomNavigationBar.
        canvasColor: Color.fromRGBO(55, 57, 84, 1.0),
        primaryColor: Colors.pinkAccent,
        textTheme: Theme.of(context).textTheme
          .copyWith(caption: TextStyle(color: Color.fromRGBO(116, 117, 153, 1.0)))
      ),
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            title: Container(),
            icon: Icon(Icons.calendar_today, size: 30.0)
          ),
          BottomNavigationBarItem(
            title: Container(),
            icon: Icon(Icons.bubble_chart, size: 30.0)
          ),
          BottomNavigationBarItem(
            title: Container(),
            icon: Icon(Icons.supervised_user_circle, size: 30.0)
          )
        ]
      ),
    );

  }

  Widget _botonesRedondeados() {
    return Table(
      children: [
        TableRow(
          children: [
            _crearBotonRedondeado(Colors.blue, Icons.border_all, 'General'),
            _crearBotonRedondeado(Colors.purpleAccent, Icons.directions_boat, 'Menú')
          ]
        ),
        TableRow(
          children: [
            _crearBotonRedondeado(Colors.greenAccent, Icons.trending_down, 'Tendencias'),
            _crearBotonRedondeado(Colors.lime, Icons.tv, 'En línea')
          ]
        ),
        TableRow(
          children: [
            _crearBotonRedondeado(Colors.redAccent, Icons.unfold_more, 'Opciones'),
            _crearBotonRedondeado(Colors.yellow, Icons.cloud, 'Cloud')
          ]
        ),
        TableRow(
          children: [
            _crearBotonRedondeado(Colors.indigo, Icons.crop, 'Crear'),
            _crearBotonRedondeado(Colors.tealAccent, Icons.crop_square, 'Salir')
          ]
        )
      ],
    );
  }

  Widget _crearBotonRedondeado(Color color, IconData icon, String nombre) {
    return ClipRect(
      child: BackdropFilter( //Para poner un filtro. Pondremos un blur.
        filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
        child: Container(
          height: 150.0,
          margin: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Color.fromRGBO(62, 66, 107, 0.7),
            borderRadius: BorderRadius.circular(20.0)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 5.0),
              CircleAvatar(
                backgroundColor: color,
                radius: 35.0,
                child: Icon(icon, color: Colors.white, size: 30.0),
              ),
              Text('$nombre', style: TextStyle(color: Colors.pinkAccent)),
              SizedBox(height: 5.0)
            ],
          ),
        ),
      ),
    );
  }

}