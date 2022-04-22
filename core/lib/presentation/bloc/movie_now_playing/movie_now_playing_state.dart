part of 'movie_now_playing_bloc.dart';

abstract class MovieNowPlayingState extends Equatable {
  const MovieNowPlayingState();
}

class MovieNowPlayingLoading extends MovieNowPlayingState {
  @override
  List<Object> get props => [];
}

class MovieNowPlayingHasData extends MovieNowPlayingState {
  final List<Movie> data;

  const MovieNowPlayingHasData(this.data);

  @override
  List<Object?> get props => [data];
}

class MovieNowPlayingEmpty extends MovieNowPlayingState {
  const MovieNowPlayingEmpty();

  @override
  List<Object?> get props => [];
}

class MovieNowPlayingError extends MovieNowPlayingState {
  final String message;

  const MovieNowPlayingError(this.message);

  @override
  List<Object?> get props => [message];
}
