import 'package:flutter/services.dart' show rootBundle; // para poder leer el json.

import 'dart:convert';

class _MenuProvider {
  List<dynamic> opciones = [];

  _MenuProvider() {
    cargarData();
  }
  
  // El future devuelve la info. (la lista dinámica)
  // en x tiempo.
  Future<List<dynamic>> cargarData() async {
    // Esto devuelve un Future.
    // Carga el string del archivo apuntado.
    final data = await rootBundle.loadString('data/menu_opts.json');
    //print(data); --> el string
    Map dataMap = json.decode(data);
    //print(dataMap['rutas']);
    opciones = dataMap['rutas'];
    return opciones;
  }
}

final menuProvider = _MenuProvider();