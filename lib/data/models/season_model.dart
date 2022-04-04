import 'package:ditonton/domain/entities/season.dart';
import 'package:equatable/equatable.dart';

class SeasonModel extends Equatable {
  final String? airDate;
  final int id;
  final int episodeCount;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;

  SeasonModel({
    required this.airDate,
    required this.id,
    required this.episodeCount,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        airDate: json["air_date"],
        id: json["id"],
        episodeCount: json["episode_count"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );

  Season toEntity() => Season(
        airDate: airDate ?? "Not aired",
        episodeCount: episodeCount,
        name: name,
        overview: overview,
        posterPath: posterPath,
      );

  @override
  List<Object?> get props => [
        airDate,
        id,
        episodeCount,
        name,
        overview,
        posterPath,
        seasonNumber,
      ];
}
