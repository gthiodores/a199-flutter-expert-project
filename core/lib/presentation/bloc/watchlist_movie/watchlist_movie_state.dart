part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();
}

class WatchListMovieHasData extends WatchlistMovieState {
  final List<Movie> watchlist;

  const WatchListMovieHasData(this.watchlist);

  @override
  List<Object> get props => [watchlist];
}

class WatchListMovieError extends WatchlistMovieState {
  final String error;

  const WatchListMovieError(this.error);

  @override
  List<Object?> get props => [error];
}

class WatchListMovieLoading extends WatchlistMovieState {
  @override
  List<Object?> get props => [];
}
