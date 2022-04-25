part of 'tv_now_playing_bloc.dart';

abstract class TvNowPlayingState extends Equatable {
  const TvNowPlayingState();
}

class TvNowPlayingLoading extends TvNowPlayingState {
  @override
  List<Object> get props => [];
}

class TvNowPlayingLoaded extends TvNowPlayingState {
  final List<Movie> data;

  const TvNowPlayingLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class TvNowPlayingEmpty extends TvNowPlayingState {
  @override
  List<Object?> get props => [];
}

class TvNowPlayingError extends TvNowPlayingState {
  final String message;

  const TvNowPlayingError(this.message);

  @override
  List<Object?> get props => [message];
}
