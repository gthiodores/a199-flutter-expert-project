import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'movie_top_rated_event.dart';

part 'movie_top_rated_state.dart';

class MovieTopRatedBloc extends Bloc<MovieTopRatedEvent, MovieTopRatedState> {
  final GetTopRatedMovies usecase;

  MovieTopRatedBloc(this.usecase) : super(MovieTopRatedEmpty()) {
    on<MovieTopRatedInit>((event, emit) async {
      emit(MovieTopRatedLoading());

      final result = await usecase.execute();

      result.fold(
        (failure) => emit(MovieTopRatedError(failure.message)),
        (data) => emit(MovieTopRatedHasData(data)),
      );
    });
  }
}
