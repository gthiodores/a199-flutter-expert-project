import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/remove_watchlist_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTvRepository repository;
  late RemoveWatchlistTv usecase;

  setUp(() {
    repository = MockTvRepository();
    usecase = RemoveWatchlistTv(repository);
  });

  test('should remove watchlist tv from repository', () async {
    // arrange
    when(repository.removeWatchListTv(testTvDetail))
        .thenAnswer((_) async => Right("Removed from watchlist"));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    expect(result, equals(Right("Removed from watchlist")));
  });
}
