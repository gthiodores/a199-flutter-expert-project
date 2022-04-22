import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tv_top_rated_event.dart';
part 'tv_top_rated_state.dart';

class TvTopRatedBloc extends Bloc<TvTopRatedEvent, TvTopRatedState> {
  TvTopRatedBloc() : super(TvTopRatedInitial()) {
    on<TvTopRatedEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
