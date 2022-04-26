part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();
}

class TvDetailInit extends TvDetailEvent {
  final int id;

  const TvDetailInit(this.id);

  @override
  List<Object?> get props => [id];
}

class TvDetailSaveWatchlist extends TvDetailEvent {
  final TvDetail detail;

  const TvDetailSaveWatchlist(this.detail);

  @override
  List<Object?> get props => [detail];
}

class TvDetailRemoveWatchlist extends TvDetailEvent {
  final TvDetail detail;

  const TvDetailRemoveWatchlist(this.detail);

  @override
  List<Object?> get props => [detail];
}
