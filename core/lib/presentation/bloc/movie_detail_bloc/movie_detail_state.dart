part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();
}

class MovieDetailLoading extends MovieDetailState {
  @override
  List<Object> get props => [];
}

class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError(this.message);

  @override
  List<Object?> get props => [message];
}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movie;
  final bool isFavorite;
  final List<Movie>? recommendations;
  final String? message;

  const MovieDetailLoaded(
    this.movie,
    this.isFavorite,
    this.recommendations,
    this.message,
  );

  MovieDetailLoaded copyWith({
    bool? isFavorite,
    List<Movie>? recommendations,
    String? message,
  }) =>
      MovieDetailLoaded(
        movie,
        isFavorite ?? this.isFavorite,
        recommendations,
        message,
      );

  @override
  List<Object?> get props => [movie, isFavorite, recommendations];
}
