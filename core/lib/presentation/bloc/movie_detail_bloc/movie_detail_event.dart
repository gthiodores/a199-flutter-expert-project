part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();
}

class MovieDetailInit extends MovieDetailEvent {
  final int movieId;

  const MovieDetailInit(this.movieId);

  @override
  List<Object?> get props => [movieId];
}

class MovieDetailWatchListTapped extends MovieDetailEvent {
  final bool isFavorite;

  const MovieDetailWatchListTapped(this.isFavorite);

  @override
  List<Object?> get props => [isFavorite];
}
