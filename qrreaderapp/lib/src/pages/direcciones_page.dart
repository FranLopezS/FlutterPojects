import 'package:flutter/material.dart';

import 'package:qrreaderapp/src/providers/db_provider.dart';
import 'package:qrreaderapp/src/bloc/scans_bloc.dart';
import 'package:qrreaderapp/src/utils/utils.dart';

class DireccionesPage extends StatelessWidget {

  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    scansBloc.obtenerScans();

    return StreamBuilder(
      stream: scansBloc.scansStreamHttp,
      builder: (context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if(!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final scans = snapshot.data;

        if(scans.length == 0) {
          return Center(
            child: Text('No hay información.'),
          );
        }
        
        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, i) {
            return Dismissible( // Para poder deslizar un elemento.
              key: UniqueKey(), // Clave única.
              background: Container(
                color: Colors.red,
              ),
              onDismissed: (direccion) => scansBloc.borrarScan(scans[i].id),
              child: ListTile(
                onTap: () => abrirScan(context, scans[i]),
                leading: Icon(Icons.cloud_queue, color: Theme.of(context).primaryColor),
                title: Text( scans[i].valor ),
                subtitle: Text(scans[i].id.toString()),
                trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey)
              ),
            );
          },
        );

      },
    );
  }

}