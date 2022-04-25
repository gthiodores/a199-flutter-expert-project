import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_tv_now_playing.dart';
import 'package:equatable/equatable.dart';

part 'tv_now_playing_event.dart';

part 'tv_now_playing_state.dart';

class TvNowPlayingBloc extends Bloc<TvNowPlayingEvent, TvNowPlayingState> {
  final GetTvNowPlaying usecase;

  TvNowPlayingBloc(this.usecase) : super(TvNowPlayingEmpty()) {
    on<TvNowPlayingInit>((event, emit) async {
      emit(TvNowPlayingLoading());

      final result = await usecase.execute();

      result.fold(
        (failure) => emit(TvNowPlayingError(failure.message)),
        (data) => emit(TvNowPlayingLoaded(data)),
      );
    });
  }
}
