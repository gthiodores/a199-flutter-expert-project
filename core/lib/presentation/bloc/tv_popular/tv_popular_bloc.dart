import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_tv_popular.dart';
import 'package:equatable/equatable.dart';

part 'tv_popular_event.dart';

part 'tv_popular_state.dart';

class TvPopularBloc extends Bloc<TvPopularEvent, TvPopularState> {
  final GetTvPopular usecase;

  TvPopularBloc(this.usecase) : super(TvPopularEmpty()) {
    on<TvPopularInit>((event, emit) async {
      emit(TvPopularLoading());

      final result = await usecase.execute();
      result.fold(
        (failure) => emit(TvPopularError(failure.message)),
        (data) => emit(TvPopularLoaded(data)),
      );
    });
  }
}
