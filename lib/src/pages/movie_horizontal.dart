import 'package:flutter/material.dart';
import 'package:movies/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  MovieHorizontal(
      {Key? key, required this.peliculas, required this.siguientePagina})
      : super(key: key);

  final List<Pelicula> peliculas;
  final _pageController = PageController(initialPage: 1, viewportFraction: 0.3);
  final Function siguientePagina;

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        siguientePagina();
      }
    });

    return SizedBox(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
          pageSnapping: false,
          controller: _pageController,
          // children: _tarjetas(context),
          itemCount: peliculas.length,
          itemBuilder: (context, i) => _tarjeta(context, peliculas[i])),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
       pelicula.uniqueId = '${pelicula.id}-poster';

    final tarjeta = Container(
      margin: const EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  placeholder: const AssetImage('lib/assets/img/no-image.jpg'),
                  image: NetworkImage(pelicula.getPosterImg()),
                  fit: BoxFit.cover,
                  height: 130.0,
                )),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
    );
  }

  List<Widget> _tarjetas(BuildContext context) {
    return peliculas.map((pelicula) {
      return _tarjeta(context, pelicula);
    }).toList();
  }
}
