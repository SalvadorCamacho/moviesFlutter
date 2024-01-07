import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({Key? key, required this.peliculas}) : super(key: key);

  final List<Pelicula> peliculas;

  @override
  Widget build(BuildContext context) {
    //Obtener tamaño de pantalla
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      width: _screenSize.width * 0.7,
      height: _screenSize.height * 0.4,
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: 200.0,
        itemHeight: 300.0,
        itemBuilder: (BuildContext context, int index) {
          peliculas[index].uniqueId = '${peliculas[index].id}-tarjeta';

          return Hero(
            tag: peliculas[index].uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'detalle',
                    arguments: peliculas[index]),
                child: FadeInImage(
                  image: NetworkImage(peliculas[index].getPosterImg()),
                  placeholder: const AssetImage('lib/assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        itemCount: peliculas.length,
        //  pagination: SwiperPagination(),
        //  control: SwiperControl(),
      ),
    );
  }
}
