part of 'tv_popular_bloc.dart';

abstract class TvPopularState extends Equatable {
  const TvPopularState();
}

class TvPopularEmpty extends TvPopularState {
  @override
  List<Object> get props => [];
}

class TvPopularLoading extends TvPopularState {
  @override
  List<Object?> get props => [];
}

class TvPopularLoaded extends TvPopularState {
  final List<Movie> data;

  const TvPopularLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class TvPopularError extends TvPopularState {
  final String message;

  const TvPopularError(this.message);

  @override
  List<Object?> get props => [message];
}
