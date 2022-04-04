import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:ditonton/presentation/provider/tv_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late MockSearchTv usecase;
  late int listenerCount;
  late TvSearchNotifier notifier;

  setUp(() {
    listenerCount = 0;
    usecase = MockSearchTv();
    notifier = TvSearchNotifier(usecase)
      ..addListener(() {
        listenerCount += 1;
      });
  });

  final searchQuery = '';

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(usecase.execute(searchQuery))
        .thenAnswer((_) async => Right(testMovieList));
    // act
    notifier.fetchTvSearch(searchQuery);
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(usecase.execute(searchQuery))
        .thenAnswer((_) async => Right(testMovieList));
    // act
    await notifier.fetchTvSearch(searchQuery);
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.searchResult, testMovieList);
    expect(listenerCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(usecase.execute(searchQuery))
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTvSearch(searchQuery);
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCount, 2);
  });
}
