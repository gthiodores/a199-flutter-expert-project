part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();
}

class FetchWatchlistMovies extends WatchlistMovieEvent {
  final int triggerTime;

  const FetchWatchlistMovies(this.triggerTime);

  @override
  List<Object?> get props => [triggerTime];
}
