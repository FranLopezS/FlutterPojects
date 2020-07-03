import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {

  final List<Pelicula> peliculas;
  final int cardSwiperType;

  CardSwiper({@required this.peliculas, this.cardSwiperType});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 18.0),
      width: _screenSize.width,
      height:  _screenSize.height * 0.5,
      child: Swiper(
        itemWidth: 200, // 70% del ancho.
        itemHeight: 400,
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int index) {
          peliculas[index].uniqueId = '${peliculas[index].id}-card';
          
          return Hero(
            tag: peliculas[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: () {
                   Navigator.pushNamed(
                    context,
                    'detalle',
                    arguments: peliculas[index]
                  );
                },
                child: FadeInImage(
                  placeholder: AssetImage('img/loading.gif'),
                  image: NetworkImage(peliculas[index].getPosterImg()),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          );
        },
        itemCount: peliculas.length,
      ),
    );
    
  }

  /*
  
  
  
  */
  
}