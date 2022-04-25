import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_tv_top_rated.dart';
import 'package:equatable/equatable.dart';

part 'tv_top_rated_event.dart';

part 'tv_top_rated_state.dart';

class TvTopRatedBloc extends Bloc<TvTopRatedEvent, TvTopRatedState> {
  final GetTvTopRated usecase;

  TvTopRatedBloc(this.usecase) : super(TvTopRatedEmpty()) {
    on<TvTopRatedInit>((event, emit) async {
      emit(TvTopRatedLoading());

      final result = await usecase.execute();

      result.fold(
        (failure) => emit(TvTopRatedError(failure.message)),
        (data) => emit(TvTopRatedLoaded(data)),
      );
    });
  }
}
