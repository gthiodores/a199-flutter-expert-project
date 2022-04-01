import 'dart:convert';

import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_remote_data_source.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get now playing tv', () {
    final tvList = TvResponse.fromJson(
            jsonDecode(readJson("dummy_data/tv_now_playing.json")))
        .tvList;

    test('should return list of TvModel when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson("dummy_data/tv_now_playing.json"), 200));
      // act
      final result = await dataSource.getNowPlayingTv();
      // assert
      expect(result, equals(tvList));
    });

    test('should return ServerException when the response code is not 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response("Not Found", 404));
      // act
      final call = dataSource.getNowPlayingTv();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get popular tv', () {
    final tvList =
        TvResponse.fromJson(jsonDecode(readJson("dummy_data/tv_popular.json")))
            .tvList;

    test('should return list of TvModel when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson("dummy_data/tv_popular.json"), 200));
      // act
      final result = await dataSource.getPopularTv();
      // assert
      expect(result, tvList);
    });

    test('should return ServerException when the response code is not 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response("Not Found", 404));
      // act
      final call = dataSource.getPopularTv();
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get top rated tv', () {
    final tvList = TvResponse.fromJson(
            jsonDecode(readJson('dummy_data/tv_top_rated.json')))
        .tvList;

    test('should return list of TvModel when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson("dummy_data/tv_top_rated.json"), 200));
      // act
      final result = await dataSource.getTopRatedTv();
      // assert
      expect(result, tvList);
    });

    test('should return ServerException when the response code is not 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response("Not Found", 404));
      // act
      final call = dataSource.getTopRatedTv();
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv detail', () {
    final tvDetail = TvDetailResponse.fromJson(
        jsonDecode(readJson('dummy_data/tv_detail.json')));

    test('should return TvDetailResponse when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/1?$API_KEY'))).thenAnswer(
          (_) async =>
              http.Response(readJson("dummy_data/tv_detail.json"), 200));
      // act
      final result = await dataSource.getTvDetail(1);
      // assert
      expect(result, equals(tvDetail));
    });

    test('should return ServerException when the response code is not 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/1?$API_KEY')))
          .thenAnswer((_) async => http.Response("Not Found", 404));
      // act
      final call = dataSource.getTvDetail(1);
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tv', () {
    final tvList = TvResponse.fromJson(
            jsonDecode(readJson('dummy_data/tv_search_simpson.json')))
        .tvList;
    final tQuery = "simpson";

    test('should return list of TvModel when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson("dummy_data/tv_search_simpson.json"), 200));
      // act
      final result = await dataSource.searchTv(tQuery);
      // assert
      expect(result, equals(tvList));
    });

    test('should return ServerException when the response code is not 200',
        () async {
      // arrange
      when(mockHttpClient.get(
        Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery'),
      )).thenAnswer((_) async => http.Response("Not Found", 404));
      // act
      final call = dataSource.searchTv(tQuery);
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv recommendations', () {
    final tvList = TvResponse.fromJson(
            jsonDecode(readJson('dummy_data/tv_recommendations.json')))
        .tvList;

    test('should return a list of TvModel when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/1/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_recommendations.json'), 200));
      // act
      final result = await dataSource.getTvRecommendations(1);
      //assert
      expect(result, equals(tvList));
    });

    test('should return ServerException when the response code is not 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/1/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response("Not Found", 404));
      // act
      final call = dataSource.getTvRecommendations(1);
      //assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
