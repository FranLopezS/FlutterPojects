import 'package:flutter/material.dart';
import 'package:peliculas/src/models/actores_model.dart';

import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class PeliculaDetalle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Container(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            _crearAppbar(pelicula),
            _posterPelicula(pelicula, context),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _descripcion(pelicula),
            _crearCasting( pelicula )
          ],
        )
      ),
    );
  }

  Widget _crearAppbar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar( // Widget que se va a adaptar al appbar.
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0)
        ),
        background: FadeInImage(
          placeholder: AssetImage('img/loading.gif'),
          image: NetworkImage(pelicula.getBackgroundImg()),
          fit: BoxFit.cover,
          //fadeInDuration: Duration(microseconds: 150),
        ),
      ), 
    );

  }

  Widget _posterPelicula(Pelicula pelicula, BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Row(
          children: [
            Hero(
              tag: pelicula.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(
                  image: NetworkImage(pelicula.getPosterImg()),
                  height: 150.0,
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pelicula.title,
                    style: Theme.of(context).textTheme.headline4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    pelicula.originalTitle,
                    style: Theme.of(context).textTheme.subtitle2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Icon(Icons.star_border),
                      Text(
                        pelicula.voteAverage.toString(),
                        style: Theme.of(context).textTheme.subtitle1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )
                ],
              )
            )
          ],
        ),
      ),
    );

  }

  Widget _descripcion(Pelicula pelicula) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0
        ),
        child: Text(
          pelicula.overview,
          textAlign: TextAlign.justify,
        ),
      )
    );
  }

  Widget _crearCasting(Pelicula pelicula) {
    final peliProvider = new PeliculasProvider();
    return SliverToBoxAdapter(
      child: Container(
        child: FutureBuilder(
          future: peliProvider.getCast(pelicula.id.toString()),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return _crearActoresPageView( snapshot.data );
            } else {
              return Center( child: CircularProgressIndicator() );
            }
          }
        )
      ),
    );
  }

  _crearActoresPageView( List<Actor> actores ) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        itemCount: actores.length,
        itemBuilder: (context, i) => _actorTarjeta(actores[i])
      ),
    );
  }

  Widget _actorTarjeta( Actor actor ) {
    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('img/no-image.jpg'),
              image: NetworkImage(actor.getFoto()),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

}