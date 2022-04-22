part of 'movie_now_playing_bloc.dart';

abstract class MovieNowPlayingEvent extends Equatable {
  const MovieNowPlayingEvent();
}

class MovieNowPlayingInit extends MovieNowPlayingEvent {
  @override
  List<Object?> get props => [];
}
