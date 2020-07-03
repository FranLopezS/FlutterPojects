class Peliculas {

  List<Pelicula> items = new List();

  Peliculas(); // CONSTRUCTOR VACÍO.

  Peliculas.fromJsonList( List<dynamic> jsonList ) {
    if(jsonList == null) return;

    for(var item in jsonList) {
      final pelicula = Pelicula.fromJsonMap(item);
      items.add(pelicula);
    }
  }

}

class Pelicula {
  String uniqueId;
  String posterPath;
  bool adult;
  String overview;
  String releaseDate;
  List<dynamic> genreIds;
  int id;
  String originalTitle;
  String originalLanguage;
  String title;
  String backdropPath;
  double popularity;
  int voteCount;
  bool video;
  double voteAverage;

  Pelicula({
    this.posterPath,
    this.adult,
    this.overview,
    this.releaseDate,
    this.genreIds,
    this.id,
    this.originalTitle,
    this.originalLanguage,
    this.title,
    this.backdropPath,
    this.popularity,
    this.voteCount,
    this.video,
    this.voteAverage,
  });

  Pelicula.fromJsonMap(Map<String, dynamic>json) {
    posterPath        = json['poster_path'];
    adult             = json['adult'];
    overview          = json['overview'];
    releaseDate       = json['release_date'];
    genreIds          = json['genre_ids'];
    id                = json['id'];
    originalTitle     = json['original_title'];
    originalLanguage  = json['original_language'];
    title             = json['title'];
    backdropPath      = json['backdrop_path'];
    popularity        = json['popularity'] / 1;
    voteCount         = json['vote_count'];
    video             = json['video'];
    voteAverage       = json['vote_average'] / 1; //Para pasarlo a double.
  }

  getPosterImg() {
    if(posterPath == null) {
      return 'https://image.shutterstock.com/image-vector/picture-vector-icon-no-image-260nw-1350441335.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w600_and_h900_bestv2/$posterPath';
    }
  }

  getBackgroundImg() {
    if(posterPath == null) {
      return 'https://image.shutterstock.com/image-vector/picture-vector-icon-no-image-260nw-1350441335.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w600_and_h900_bestv2/$backdropPath';
    }
  }

}

