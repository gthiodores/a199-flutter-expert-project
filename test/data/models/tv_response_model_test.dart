import 'dart:convert';

import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  test('should return correct model from JSON', () {
    // arrange
    final Map<String, dynamic> jsonMap =
        jsonDecode(readJson('dummy_data/tv_now_playing.json'));
    final TvModel expectation = TvModel(
      posterPath: "/path.jpg",
      popularity: 1.0,
      id: 31917,
      backdropPath: "/path.jpg",
      voteAverage: 1.0,
      overview: "Overview",
      firstAirDate: "2010-06-08",
      originCountry: ["US"],
      genreIds: [1, 2, 3],
      originalLanguage: "en",
      voteCount: 1,
      name: "name",
      originalName: "original name",
    );
    // act
    final result = TvResponse.fromJson(jsonMap);
    // assert
    expect(result, equals(TvResponse(tvList: [expectation])));
  });
}
