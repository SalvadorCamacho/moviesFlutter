import 'package:flutter/material.dart';
import 'package:movies/src/pages/home_page.dart';
import 'package:movies/src/pages/pelicula_detalle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Películas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'src/pages/home_page.dart',
      routes: {
         '/'       : (BuildContext context)  => HomePage(),
         'detalle' : (BuildContext context)  => peliculaDetalle(),

      },
    );
  }
}
