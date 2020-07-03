import 'dart:io';

import 'package:flutter/material.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:qrreaderapp/src/pages/direcciones_page.dart';
import 'package:qrreaderapp/src/pages/mapas_page.dart';
import 'package:qrreaderapp/src/providers/db_provider.dart';
import 'package:qrreaderapp/src/bloc/scans_bloc.dart';
import 'package:qrreaderapp/src/utils/utils.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scansBloc = new ScansBloc();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: scansBloc.borrarScanTodos
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: () => _scanQR(context), // Sin (), para que no se ejecute solo.
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _scanQR(BuildContext context) async {
    //https://www.pkmnstats.com/dex/septima/pokemon/301/301-delcatty/
    //geo:39.51026449811164,-5.4388941808594105

    String futureString ='';
    
    try {
      ScanResult result = await BarcodeScanner.scan();
      futureString = result.rawContent;
    } catch(e) {
      futureString=e.toString();
    }

    if(futureString != null) {
      final scan = ScanModel(valor: futureString);
      scansBloc.agregarScan(scan);

      if(Platform.isIOS) {
        Future.delayed(Duration(milliseconds: 750), () {
          abrirScan(context, scan);
        });
      } else {
        abrirScan(context, scan);
      }
      
    }
  }

  Widget _callPage(int paginaActual) {
    switch(paginaActual) {
      case 0: return MapasPage(); break;
      case 1: return DireccionesPage(); break;
      default: return MapasPage(); break;
    }
  }

  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (i) { // i: tab al que se hace click.
        setState(() {
          currentIndex = i;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          title: Text('Mapas')
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.directions),
          title: Text('Direcciones')
        )
      ]
    );
  }
}