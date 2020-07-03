import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:componentes/src/pages/alert_page.dart';
import 'package:componentes/src/routes/routes.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('es', 'ES')
      ],
      debugShowCheckedModeBanner: false,
      title: 'Componentes APP',
      //home: HomePage(),
      initialRoute: '/',
      routes: getApplicationRoutes(),
      // Qué hacer cuando se recibe una ruta desconocida.
      onGenerateRoute: (settings) {
        // Hay que devolver una ruta de tipo dynamic.
        return MaterialPageRoute(
          builder: (BuildContext context) => AlertPage()
        );
      },
    );
  }
}