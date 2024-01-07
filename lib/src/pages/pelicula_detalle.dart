
import 'package:flutter/material.dart';
import 'package:movies/src/models/actores_model.dart';
import 'package:movies/src/models/pelicula_model.dart';
import 'package:movies/src/providers/peliculas_provider.dart';

class peliculaDetalle extends StatelessWidget {
  peliculaDetalle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula =
        ModalRoute.of(context)!.settings.arguments as Pelicula;

    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        _crearAppbar(pelicula),
        SliverList(
          delegate: SliverChildListDelegate([
            const SizedBox(height: 10.0),
            _posterTitulo(pelicula, context),
            _descripcion(pelicula),
            _crearCasting(pelicula),
          ]),
        ),
      ],
    ));
  }

  Widget _crearAppbar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: const TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('lib/assets/img/loading.gif'),
          image: NetworkImage(pelicula.getBackgroundImg()),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitulo(Pelicula pelicula, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(
                    image: NetworkImage(pelicula.getPosterImg()),
                    height: 150.0)),
          ),
          const SizedBox(
            width: 20.0,
          ),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                pelicula.title,
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                pelicula.originalTitle,
                style: Theme.of(context).textTheme.subtitle1,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: <Widget>[
                  const Icon(Icons.star_border),
                  Text(pelicula.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subtitle1,
                      overflow: TextOverflow.ellipsis)
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _crearCasting(Pelicula pelicula) {
    final peliProvider = PeliculasProvider();

    return FutureBuilder(
        future: peliProvider.getCast(pelicula.id.toString()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return _crearActoresPageView(snapshot.data);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _crearActoresPageView(List<Actor> actores) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        itemCount: actores.length,
        itemBuilder: (context, i) => _actorTarjeta(actores[i]),
        ),
        );
  }

  Widget _actorTarjeta(Actor actor){
    return Column(
      children: <Widget>[
        ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: FadeInImage(
          placeholder:  const AssetImage('lib/assets/img/no-image.jpg'),
          image: NetworkImage(actor.getFoto(),),
          height: 150.0,
          fit: BoxFit.cover,
        ),
        ),
        Text(
          actor.name!,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}
