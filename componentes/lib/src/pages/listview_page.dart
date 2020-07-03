import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListaPage extends StatefulWidget {
  _ListaPageState createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  
  // Para controlar el scroll de la lista.
  ScrollController _scrollController = ScrollController();

  List<int> _listaNumeros = new List();
  int _ultimoItem = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _agregar10Imagenes();

    _scrollController.addListener(() {
      // Si el scroll llega al final, agregar 10.
      if(_scrollController.position.pixels == 
      _scrollController.position.maxScrollExtent) {
        //_agregar10Imagenes();
        _fetchData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listas'),
      ),
      body: Stack( // Stack es como Column o Row, pero apila todo junto.
        children: <Widget>[
          _crearLoading(),
          _crearLista(),
        ],
      )
    );
  }

  Widget _crearLista() {
    // Renderiza elementos según son necesarios.
    // Útil para ahorrar recursos y que no se cargue la lista entera de golpe.
    // Es como el RecyclerView de Android.
    return RefreshIndicator(
        child: ListView.builder(
        controller: _scrollController,
        itemCount: _listaNumeros.length, // cantidad de elementos de la lista.
        itemBuilder: (context, index) {

          final imagen = _listaNumeros[index];

          return FadeInImage(
            placeholder: AssetImage('assets/original.gif'),
            image: NetworkImage('https://i.picsum.photos/id/$imagen/500/300.jpg')
          );
        }
      ),
      onRefresh: _obtenerPagina1,
    );
  }

  Future<Null> _obtenerPagina1() async {
    final duration = new Duration(seconds: 2);
    new Timer(duration, () {
      _listaNumeros.clear();
      _ultimoItem++;
      _agregar10Imagenes();
      
    });
    return Future.delayed(duration);
  }

  void _agregar10Imagenes() {
    for (var i = 0; i < 10; i++) {
      _ultimoItem++;
      _listaNumeros.add(_ultimoItem);
    }
    setState(() {
      
    });
  }

  // Devolverá un Future para simular un delay de llamar a fotos httml.
  Future<Null> _fetchData() async {
    _isLoading = true;
    setState(() {});

    final duration = new Duration(seconds: 2);
    return new Timer(duration, respuestaHTTP);
  }

  void respuestaHTTP() {
    _isLoading = false;
    _scrollController.animateTo(
      _scrollController.position.pixels + 100, //mueve el scroll hacia abajo al cargar.
      duration: Duration(milliseconds: 250),
      curve: Curves.fastOutSlowIn
    );
    _agregar10Imagenes();
  }

  // SE EJECUTA CUANDO LA PÁGINA DEJA DE EXISTIR.
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Widget _crearLoading() {
    if(_isLoading) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator()
            ],
          ),
          SizedBox(height: 20.0)
        ],
      );
    } else {
      return Container();
    }
  }

}