import 'package:flutter/material.dart';
import 'package:movies/src/pages/card_swiper.dart';
import 'package:movies/src/pages/movie_horizontal.dart';
import 'package:movies/src/providers/peliculas_provider.dart';
import 'package:movies/src/serch/search_delegate.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final peliculasProvider = PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();
    peliculasProvider.getNext();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Películas de cine"),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
              icon: const Icon(Icons.search)),
        ],
      ),
      body: ListView(
        children: [
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          _swiperTarjetas(),
          _footer(context),
          _next(context),
        ],
      ),
    );
  }

  Widget _swiperTarjetas() {
    return FutureBuilder(
        future: peliculasProvider.getEnCines(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return CardSwiper(
              peliculas: snapshot.data,
            );
          } else {
            return Container(
                height: 200.0,
                child: const Center(child: CircularProgressIndicator()));
          }
        });
  }

  Widget _footer(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Populares',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          )
        ],
      ),
    );
  }

  Widget _next(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Próximas',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          StreamBuilder(
            stream: peliculasProvider.proximasStream,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot2) {
              if (snapshot2.hasData) {
                return MovieHorizontal(
                  peliculas: snapshot2.data,
                  siguientePagina: peliculasProvider.getNext,
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          )
        ],
      ),
    );
  }
}
