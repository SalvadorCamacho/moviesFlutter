class Peliculas {
  List<Pelicula> items = [];

  Peliculas();


  Peliculas.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final pelicula = Pelicula.fromJsonMap(item);
      items.add(pelicula);
    }
  }
}

class Pelicula {
  String uniqueId = '';
  int voteCount = 0;
  int id = 0;
  bool video = false;
  double voteAverage = 0.0;
  String title = '';
  double popularity = 0.0;
  String posterPath = '';
  String originalLanguage = '';
  String originalTitle = '';
  List<int> genreIds = [];
  String backdropPath = '';
  bool adult = false;
  String overview = '';
  String releaseDate = '';

  Pelicula({
    required this.voteCount,
    required this.id,
    required this.video,
    required this.voteAverage,
    required this.title,
    required this.popularity,
    required this.posterPath,
    required this.originalLanguage,
    required this.originalTitle,
    required this.genreIds,
    required this.backdropPath,
    required this.adult,
    required this.overview,
    required this.releaseDate,
  });

  Pelicula.fromJsonMap(Map<String, dynamic> json) {
    voteCount = json['vote_count'];
    id = json['id'];
    video = json['video'];
    voteAverage = json['vote_average'] / 1;
    title = json['title'];
    popularity = json['popularity'] / 1;
    posterPath = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    backdropPath = json['backdrop_path'];
    adult = json['adult'];
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  getPosterImg() {
    if (posterPath == null) {
      return 'https://www.seekpng.com/png/detail/423-4235598_no-image-for-noimage-icon.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }

  getBackgroundImg() {
    if (posterPath == null) {
      return 'https://www.seekpng.com/png/detail/423-4235598_no-image-for-noimage-icon.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }


  


}
