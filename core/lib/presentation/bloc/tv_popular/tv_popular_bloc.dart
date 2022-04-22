import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tv_popular_event.dart';
part 'tv_popular_state.dart';

class TvPopularBloc extends Bloc<TvPopularEvent, TvPopularState> {
  TvPopularBloc() : super(TvPopularInitial()) {
    on<TvPopularEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
