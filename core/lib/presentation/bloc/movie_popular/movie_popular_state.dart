part of 'movie_popular_bloc.dart';

abstract class MoviePopularState extends Equatable {
  const MoviePopularState();
}

class MoviePopularEmpty extends MoviePopularState {
  @override
  List<Object> get props => [];
}

class MoviePopularLoading extends MoviePopularState {
  @override
  List<Object> get props => [];
}

class MoviePopularHasData extends MoviePopularState {
  final List<Movie> data;

  const MoviePopularHasData(this.data);

  @override
  List<Object> get props => [data];
}

class MoviePopularError extends MoviePopularState {
  final String message;

  const MoviePopularError(this.message);

  @override
  List<Object> get props => [message];
}
