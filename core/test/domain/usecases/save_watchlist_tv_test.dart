import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/save_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvRepository repository;
  late SaveWatchlistTv usecase;

  setUp(() {
    repository = MockTvRepository();
    usecase = SaveWatchlistTv(repository);
  });

  test('should save Movie to watchlist', () async {
    // arrange
    when(repository.saveWatchListTv(testTvDetail))
        .thenAnswer((_) async => Right('Added to watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    expect(result, equals(Right('Added to watchlist')));
  });
}
