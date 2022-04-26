part of 'tv_detail_bloc.dart';

class TvDetailState extends Equatable {
  final String? message;
  final String? watchlistMessage;
  final TvDetail? detail;
  final List<Movie>? recommendations;
  final bool isWatchlist;

  const TvDetailState({
    this.message,
    this.watchlistMessage,
    this.detail,
    this.recommendations,
    required this.isWatchlist,
  });

  const TvDetailState.initial()
      : message = null,
        watchlistMessage = null,
        detail = null,
        recommendations = null,
        isWatchlist = false;

  TvDetailState copyWith({
    String? message,
    String? watchlistMessage,
    TvDetail? detail,
    List<Movie>? recommendations,
    bool? isWatchlist,
  }) =>
      TvDetailState(
        message: message,
        detail: detail ?? this.detail,
        recommendations: recommendations ?? this.recommendations,
        isWatchlist: isWatchlist ?? this.isWatchlist,
        watchlistMessage: watchlistMessage,
      );

  @override
  List<Object?> get props =>
      [message, detail, recommendations, isWatchlist, watchlistMessage];
}
