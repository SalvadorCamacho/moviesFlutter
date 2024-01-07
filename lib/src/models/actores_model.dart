class Cast {
  List<Actor> actores = [];
  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final actor = Actor.fromJsonMap(item);
      actores.add(actor);
    }
  }
}

class Actor {
  Actor({
    required this.adult,
    required this.gender,
    required this.id,
    // this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
    // this.department,
    required this.job,
  });

  bool? adult;
  int? gender;
  int? id;
  // Department knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  int? castId;
  String? character;
  String? creditId;
  int? order;
  // Department department;
  String? job;

//enum Department { ACTING, EDITING, SOUND, PRODUCTION, ART, COSTUME_MAKE_UP, VISUAL_EFFECTS, CAMERA, WRITING, DIRECTING, LIGHTING, CREW }

  Actor.fromJsonMap(Map<String, dynamic> json) {
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['credit_id'];
    gender = json['credit:gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }

  getFoto() {
    if (profilePath == null) {
      return 'http://forum.spaceengine.org/styles/se/theme/images/no_avatar.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}
