part of 'movie_top_rated_bloc.dart';

abstract class MovieTopRatedState extends Equatable {
  const MovieTopRatedState();
}

class MovieTopRatedEmpty extends MovieTopRatedState {
  @override
  List<Object> get props => [];
}

class MovieTopRatedLoading extends MovieTopRatedState {
  @override
  List<Object> get props => [];
}

class MovieTopRatedHasData extends MovieTopRatedState {
  final List<Movie> data;

  const MovieTopRatedHasData(this.data);

  @override
  List<Object> get props => [data];
}

class MovieTopRatedError extends MovieTopRatedState {
  final String message;

  const MovieTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}