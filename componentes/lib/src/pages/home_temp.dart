import 'package:flutter/material.dart';
 
class HomePageTemp extends StatelessWidget {
  final opciones = ['Uno', 'Dos', 'Tres'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: _getListView()
    );
  }

  AppBar _getAppBar() =>
    AppBar(title: Text('Componentes Temp'));
  
  ListView _getListView() {
    return ListView(
        children: _crearItemsCorta()
      );
  }

  // Devuelve una lista de widgets.
  List<Widget> _crearItems() {
    // Lista dinámica.
    List<Widget> lista = new List<Widget>();

    for (String i in opciones) {
      final tempWidget = ListTile(
        title: Text(i),
      );
      // Se inserta a la lista el ListTile.
      lista..add(tempWidget)
           ..add(Divider());
    }
    return lista;
  }

  List<Widget> _crearItemsCorta() {
    // se devuelve una lista de ListTiles.
    return opciones.map((item) { // para mapear opciones a una lista.
      return Column( // otro return pq es funcion dentro de funcion.
        children: <Widget>[
          new ListTile(
            title: Text(item),
            subtitle: Text('Subtitle...'),
            leading: Icon(Icons.account_balance_wallet),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
          Divider()
        ],
      );
    }).toList();
  }

}