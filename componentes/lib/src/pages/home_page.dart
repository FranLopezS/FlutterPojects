import 'package:flutter/material.dart';

import 'package:componentes/src/providers/menu_provider.dart';
import 'package:componentes/src/utils/icono_string_util.dart';

import 'alert_page.dart';
 
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Componentes'),
      ),
      body: _lista()
    );
  }

  Widget _lista() {
    //print(menuProvider.opciones);

    // un futurebuilder es un widget que permite dibujarse a si mismo
    // basandose en la información...
    return FutureBuilder(
      future: menuProvider.cargarData(), //lo acepta pq devuelve un future.
      builder: (context, AsyncSnapshot<List<dynamic>> snap) { // el builder debe devolver un WIDGET.
        return ListView(
          children: _listaItems(snap.data, context)
        );
      }, //recibe una funcion de buildcontext y un asyncsnapshot del tipo del future (en este caso, List<dynamic>)
      initialData: [], //valor por defecto. No es necesario ponerlo.
    );

    
  }

  List<Widget> _listaItems(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];

    data.forEach((i) {
      final wTemp = ListTile(
        title: Text(i['texto']),
        leading: getIcon(i['icon']),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
        onTap: () {
          Navigator.pushNamed(context, i['ruta']);
        },
      );
      // Agregar a opciones.
      opciones..add(wTemp)
              ..add(Divider());
    });

    return opciones;
  }

}