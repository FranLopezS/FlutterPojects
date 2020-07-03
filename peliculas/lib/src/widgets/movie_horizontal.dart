import 'package:flutter/material.dart';

import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {

  final List<Pelicula> peliculas;
  final Function siguientePagina;
  final _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.1
  );

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      // Si se acerca el final del scroll (final-200), cargar más pelis.
      if(_pageController.position.pixels >= 
      _pageController.position.maxScrollExtent - 200) {
        print('Cargar más pelis.');
        siguientePagina();
      }

    });

    return Container(
      height: 80,
      // El PageView.builder crea las pelis según se necesiten.
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (context, i) => _tarjeta(context, peliculas[i]),
      )
    );

  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    pelicula.uniqueId = '${pelicula.id}-poster';

    final peliculaTarjeta = Container(
      margin: EdgeInsets.only(right: 10.0),
      child: Column(
        children: [
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: FadeInImage(
                placeholder: AssetImage('img/loading.gif'),
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: 65.0,
              ),
            ),
          ),
          SizedBox(),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption
          )
        ],
      ),
    );

    return GestureDetector(
      child: peliculaTarjeta,
      onTap: () {
        Navigator.pushNamed(
          context,
          'detalle',
          arguments: pelicula
        );
      },
    );
  }

  List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
                child: FadeInImage(
                  placeholder: AssetImage('img/loading.gif'),
                  image: NetworkImage(pelicula.getPosterImg()),
                  fit: BoxFit.cover,
                  height: 90.0,
                ),
            ),
            SizedBox(),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption
            )
          ],
        ),
      );

    }).toList();
  }

}