import 'package:bloc/bloc.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/movie.dart';

part 'movie_popular_event.dart';

part 'movie_popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final GetPopularMovies usecase;

  MoviePopularBloc(this.usecase) : super(MoviePopularEmpty()) {
    on<MoviePopularInit>((event, emit) async {
      emit(MoviePopularLoading());

      final result = await usecase.execute();

      result.fold(
        (failure) {
          emit(MoviePopularError(failure.message));
        },
        (data) {
          emit(MoviePopularHasData(data));
        },
      );
    });
  }
}
