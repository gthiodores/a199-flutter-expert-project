import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tv_now_playing_event.dart';
part 'tv_now_playing_state.dart';

class TvNowPlayingBloc extends Bloc<TvNowPlayingEvent, TvNowPlayingState> {
  TvNowPlayingBloc() : super(TvNowPlayingInitial()) {
    on<TvNowPlayingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
