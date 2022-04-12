import 'package:core/data/models/tv_model.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvModel = TvModel(
    posterPath: "/posterPath.jpg",
    popularity: 1,
    id: 1,
    backdropPath: "/backdropPath.jpg",
    voteAverage: 1,
    overview: "overview",
    firstAirDate: "",
    originCountry: ["originCountry"],
    genreIds: [1, 2, 3],
    originalLanguage: "originalLanguage",
    voteCount: 1,
    name: "name",
    originalName: "originalName",
  );

  final tvJson = {
    "poster_path": "/posterPath.jpg",
    "popularity": 1.0,
    "id": 1,
    "backdrop_path": "/backdropPath.jpg",
    "vote_average": 1.0,
    "overview": "overview",
    "first_air_date": "",
    "origin_country": ["originCountry"],
    "genre_ids": [1, 2, 3],
    "original_language": "originalLanguage",
    "vote_count": 1,
    "name": "name",
    "original_name": "originalName",
  };

  final tTv = Movie(
    adult: false,
    backdropPath: "/backdropPath.jpg",
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: "originalName",
    overview: "overview",
    popularity: 1,
    posterPath: "/posterPath.jpg",
    releaseDate: "",
    title: "name",
    video: false,
    voteAverage: 1,
    voteCount: 1,
    isMovie: false,
  );

  test('should be a subclass of Movie entity with false isMovie', () {
    // act
    final result = tTvModel.toEntity();

    // assert
    expect(result, tTv); // Is a subclass of Movie
    expect(result.isMovie, false); // isMovie field == false
  });

  test('should be a TvModel entity with matching fields', () {
    // act
    final result = TvModel.fromJson(tvJson);

    // assert
    expect(result, equals(tTvModel));
  });
}
