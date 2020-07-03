import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {

  String seleccion;
  PeliculasProvider peliculasProvider = PeliculasProvider();

  final peliculas = [
    'Spiderman',
    'Aquaman',
    'Batman',
    'Superman',
    'Pepito',
    'Link',
    'Zelda',
    'Capitán América'
  ];

  final peliculasRecientes = [
    'Spiderman',
    'Capitán América'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
      // Las acciones de nuestro AppBar.
      return [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = ''; // Inicializar a vacío cuando se toca la 'X'.
          }
        )
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      // Icono a la izquierda del AppBar.
      return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation
        ),
        onPressed: () {
          close(context, null);
        }
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      // Crea los resultados que se van a mostrar.
      return Center(
        child: Container(
          height: 100.0,
          width: 100.0,
          color: Colors.blueAccent,
          child: Text(seleccion),
        ),
      );
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
      // Sugerencias que aparecen cuando la persona escribe.

      if( query.isEmpty ) {
        return Container();
      }

      return FutureBuilder(
        future: peliculasProvider.buscarPelicula(query),
        builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> data) {
          if(data.hasData) {
            final peliculas = data.data;
            return ListView(
              children: peliculas.map((pelicula) {
                return ListTile(
                  leading: FadeInImage(
                    placeholder: AssetImage('img/no-image.jpg'),
                    image: NetworkImage(pelicula.getPosterImg()),
                    width: 50.0,
                    fit: BoxFit.contain,
                  ),
                  title: Text(pelicula.title),
                  subtitle: Text(pelicula.originalTitle),
                  onTap: () {
                    close(context, null);
                    pelicula.uniqueId = ""; // Para que no de error ninguna animación.
                    Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                  },
                );
              }).toList()
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      );

    }

    /*
    @override
    Widget buildSuggestions(BuildContext context) {
      // Sugerencias que aparecen cuando la persona escribe.

      // Se crea la lista sugerida.
      final listaSugerida = (query.isEmpty)
                              ? peliculasRecientes
                              : peliculas.where((peli) => peli.toLowerCase().startsWith(query.toLowerCase())
                              ).toList();

      return ListView.builder(
        itemCount: listaSugerida.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: Icon(Icons.movie),
            title: Text(listaSugerida[i]),
            onTap: () {
              seleccion = listaSugerida[i];
              showResults(context);
            },
          );
        }
      );
    }
    
    */

}