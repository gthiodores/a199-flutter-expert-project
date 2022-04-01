import 'package:ditonton/data/models/tv_model.dart';
import 'package:equatable/equatable.dart';

// API Response for Now playing, Popular, Search and Top Rated TVs
class TvResponse extends Equatable {
  final List<TvModel> tvList;

  TvResponse({required this.tvList});

  factory TvResponse.fromJson(Map<String, dynamic> json) => TvResponse(
        tvList: List<TvModel>.from((json["results"] as List)
            .map((element) => TvModel.fromJson(element))
            .where((element) => element.posterPath != null)),
      );

  @override
  List<Object?> get props => [tvList];
}
