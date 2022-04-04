import 'package:ditonton/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';

class TvModel extends Equatable {
  // Fields
  final String? posterPath;
  final double popularity;
  final int id;
  final String? backdropPath;
  final double voteAverage;
  final String overview;
  final String? firstAirDate;
  final List<String> originCountry;
  final List<int> genreIds;
  final String originalLanguage;
  final int voteCount;
  final String name;
  final String originalName;

  // Constructor
  TvModel({
    required this.posterPath,
    required this.popularity,
    required this.id,
    required this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.firstAirDate,
    required this.originCountry,
    required this.genreIds,
    required this.originalLanguage,
    required this.voteCount,
    required this.name,
    required this.originalName,
  });

  // Factory constructor
  factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
        posterPath: json["poster_path"],
        popularity: json["popularity"].toDouble(),
        id: json["id"],
        backdropPath: json["backdrop_path"],
        voteAverage: json["vote_average"].toDouble(),
        overview: json["overview"],
        firstAirDate: json["first_air_date"],
        originCountry: List<String>.from(json["origin_country"].map((e) => e)),
        genreIds: List<int>.from(json["genre_ids"].map((e) => e)),
        originalLanguage: json["original_language"],
        voteCount: json["vote_count"],
        name: json["name"],
        originalName: json["original_name"],
      );

  Movie toEntity() => Movie(
        adult: false,
        backdropPath: backdropPath,
        genreIds: genreIds,
        id: id,
        originalTitle: originalName,
        overview: overview,
        popularity: popularity,
        posterPath: posterPath,
        releaseDate: firstAirDate,
        title: name,
        video: false,
        voteAverage: voteAverage,
        voteCount: voteCount,
        isMovie: false,
      );

  @override
  List<Object?> get props => [
        posterPath,
        popularity,
        id,
        backdropPath,
        voteAverage,
        overview,
        firstAirDate,
        originCountry,
        genreIds,
        originalLanguage,
        voteCount,
        name,
        originalName,
      ];
}
