part of 'movie_popular_bloc.dart';

abstract class MoviePopularEvent extends Equatable {
  const MoviePopularEvent();
}

class MoviePopularInit extends MoviePopularEvent {
  const MoviePopularInit();

  @override
  List<Object?> get props => [];
}
