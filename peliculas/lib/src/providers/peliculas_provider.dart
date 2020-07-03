import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/actores_model.dart';

import 'dart:convert';
import 'dart:async';

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {
  
  String _apikey   = '45b6f68e37c6400606acd279b24c1859';
  String _url      = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0; // Para controlar la página a la que pido info.
  bool _cargando = false;

  // Esta lista se usará como argumento para dar un valor al Stream.
  List<Pelicula> _populares = new List(); // Contenedor de películas populares.

  // Si no se pone el broadcast, solo una persona (widget) puede escuchar el Stream.
  // Este StreamController manejará una lista de películas.
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  // Se definen get y set para meter y coger info. del Stream.
  // Hay que pasar una lista de películas para que funcione.

  // Esta función agrega información al Stream.
  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  // Esta función coge información del Stream.
  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get( url );
    final decodedData = json.decode(resp.body);

    final peliculas = Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key'   : _apikey,
      'language'  : _language
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if(_cargando) return [];

    _cargando = true;

    _popularesPage ++;

    print('*#* Cargando siguientes... *#*');

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key'   : _apikey,
      'language'  : _language,
      'page'      : _popularesPage.toString()
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);

    _cargando = false;
    return resp;
  }

  Future<List<Actor>> getCast( String peliId ) async {
    final url = Uri.https(_url, '3/movie/$peliId/credits', {
      'api_key'   : _apikey,
      'language'  : _language
    });

    final resp = await http.get(url); //ejecutamos el http.get de url
    final decodedData = json.decode(resp.body);
    final cast = new Cast.fromJsonList(decodedData['cast']);
    return cast.actores;
  }

  Future<List<Pelicula>> buscarPelicula( String query ) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key'   : _apikey,
      'language'  : _language,
      'query'     : query
    });

    return await _procesarRespuesta(url);
  }

}