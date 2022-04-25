part of 'tv_top_rated_bloc.dart';

abstract class TvTopRatedState extends Equatable {
  const TvTopRatedState();
}

class TvTopRatedEmpty extends TvTopRatedState {
  @override
  List<Object> get props => [];
}

class TvTopRatedLoading extends TvTopRatedState {
  @override
  List<Object?> get props => [];
}

class TvTopRatedError extends TvTopRatedState {
  final String message;

  const TvTopRatedError(this.message);

  @override
  List<Object?> get props => [message];
}

class TvTopRatedLoaded extends TvTopRatedState {
  final List<Movie> data;

  const TvTopRatedLoaded(this.data);

  @override
  List<Object?> get props => [data];
}
