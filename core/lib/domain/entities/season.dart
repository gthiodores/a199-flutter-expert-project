import 'package:equatable/equatable.dart';

class Season extends Equatable {
  final String name;
  final String overview;
  final String? posterPath;
  final int episodeCount;
  final String airDate;

  Season({
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.episodeCount,
    required this.airDate,
  });

  @override
  List<Object?> get props => [
        name,
        overview,
        posterPath,
        episodeCount,
        airDate,
      ];
}
