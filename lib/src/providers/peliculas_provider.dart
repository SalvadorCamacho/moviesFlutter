import 'dart:async';

import 'package:movies/src/models/actores_model.dart';
import 'package:movies/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PeliculasProvider {
  String _apikey = '23b9dc38f973121e76afbedb30990895';
  String _url = 'api.themoviedb.org';
  String _language = "es-ES";

  int _popularesPage = 0;
  int _nextPage = 0;
  int _nextPage2 = 0;
  bool _cargando = false;
  bool _cargandoNext = false;

  List<Pelicula> _populares = [];
  List<Pelicula> _proximas = [];

  //Stream populares
  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  //Para introducir nuevas películas
  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  //Para obtener las películas
  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  //Stream próximas
  final _proximasStreamController =
      StreamController<List<Pelicula>>.broadcast();

//Ingresar Películas próximas
  Function(List<Pelicula>) get proximasSink =>
      _proximasStreamController.sink.add;

//Para obtener las películas próximas
  Stream<List<Pelicula>> get proximasStream =>
  _proximasStreamController.stream;

  void disposeStreams() {
    _popularesStreamController.close();
    _proximasStreamController.close();
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];
    _cargando = true;

    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      ' ': _popularesPage.toString()
    });

    final resp = await _procesarRespuesta(url);
    _populares.addAll(resp);
    popularesSink(_populares);

    _cargando = false;
    return resp;
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    final peliculas = Peliculas.fromJsonList(decodeData['results']);

    return peliculas.items;
  }

  Future<List<Actor>> getCast(String peliId) async {
    final url = Uri.https(_url, '3/movie/$peliId/credits', {
      'api_key': _apikey,
      'language': _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final cast = Cast.fromJsonList(decodedData['cast']);

    return cast.actores;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apikey,
      'language': _language,
      'query': query,
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getNext() async {
    if (_cargandoNext) return [];
    _cargandoNext = true;

    _nextPage2++;

    final url = Uri.https(_url, '3/movie/upcoming',
        {'api_key': _apikey,
        'language': _language, ' ': _nextPage2.toString()});

    final resp2 = await _procesarRespuesta(url);
    _proximas.addAll(resp2);
    proximasSink(_proximas);

    _cargandoNext = false;
    return resp2;
  }
}
