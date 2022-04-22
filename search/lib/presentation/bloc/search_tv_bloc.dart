import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/domain/usecase/search_tv.dart';

part 'search_tv_event.dart';

part 'search_tv_state.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTvState> {
  final SearchTv usecase;

  SearchTvBloc(this.usecase) : super(SearchTvEmpty()) {
    on<OnTvQueryChanged>(
      (event, emit) async {
        emit(SearchTvLoading());
        final data = await usecase.execute(event.query);
        data.fold(
          (failure) => emit(SearchTvError(failure.message)),
          (success) => emit(SearchTvHasData(success)),
        );
      },
      transformer: ((events, mapper) {
        return events
            .debounceTime(const Duration(milliseconds: 500))
            .flatMap(mapper);
      }),
    );
  }
}
