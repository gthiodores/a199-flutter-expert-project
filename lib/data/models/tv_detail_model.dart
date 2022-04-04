import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvDetailResponse extends Equatable {
  final String? backdropPath;
  final String? firstAirDate;
  final String? lastAirDate;
  final List<GenreModel> genres;
  final int id;
  final List<SeasonModel> seasons;
  final String name;
  final String originalName;
  final String overview;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;

  TvDetailResponse({
    required this.backdropPath,
    required this.firstAirDate,
    required this.lastAirDate,
    required this.genres,
    required this.id,
    required this.seasons,
    required this.name,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvDetailResponse(
        backdropPath: json["backdrop_path"],
        firstAirDate: json["first_air_date"],
        lastAirDate: json["last_air_date"],
        genres: List<GenreModel>.from(
            json["genres"].map((element) => GenreModel.fromJson(element))),
        id: json["id"],
        seasons: List<SeasonModel>.from(
            json["seasons"].map((element) => SeasonModel.fromJson(element))),
        name: json["name"],
        originalName: json["original_name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
      );

  TvDetail toEntity() => TvDetail(
        backdropPath: backdropPath,
        firstAirDate: firstAirDate ?? "Not aired",
        lastAirDate: lastAirDate ?? "Not aired",
        genres: genres.map((element) => element.toEntity()).toList(),
        id: id,
        seasons: seasons.map((element) => element.toEntity()).toList(),
        name: name,
        originalName: originalName,
        overview: overview,
        posterPath: posterPath,
        voteAverage: voteAverage,
        voteCount: voteCount,
      );

  @override
  List<Object?> get props => [
        backdropPath,
        firstAirDate,
        lastAirDate,
        genres,
        id,
        seasons,
        name,
        originalName,
        overview,
        posterPath,
        voteAverage,
        voteCount,
      ];
}
