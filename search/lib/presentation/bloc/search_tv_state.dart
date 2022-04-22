part of 'search_tv_bloc.dart';

abstract class SearchTvState extends Equatable {
  const SearchTvState();
}

class SearchTvLoading extends SearchTvState {
  @override
  List<Object> get props => [];
}

class SearchTvEmpty extends SearchTvState {
  @override
  List<Object?> get props => [];
}

class SearchTvError extends SearchTvState {
  final String message;

  const SearchTvError(this.message);

  @override
  List<Object?> get props => [message];
}

class SearchTvHasData extends SearchTvState {
  final List<Movie> data;

  const SearchTvHasData(this.data);

  @override
  List<Object?> get props => [data];
}
