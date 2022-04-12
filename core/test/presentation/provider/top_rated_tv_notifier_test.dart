import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/domain/usecases/get_tv_top_rated.dart';
import 'package:core/presentation/provider/top_rated_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_notifier_test.mocks.dart';

@GenerateMocks([GetTvTopRated])
void main() {
  late GetTvTopRated usecase;
  late int listenerCount;
  late TopRatedTvNotifier notifier;

  setUp(() {
    listenerCount = 0;
    usecase = MockGetTvTopRated();
    notifier = TopRatedTvNotifier(usecase)
      ..addListener(() {
        listenerCount += 1;
      });
  });

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(usecase.execute()).thenAnswer((_) async => Right(testMovieList));
    // act
    notifier.fetchTopRatedTv();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(usecase.execute()).thenAnswer((_) async => Right(testMovieList));
    // act
    await notifier.fetchTopRatedTv();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.movieList, testMovieList);
    expect(listenerCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(usecase.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTopRatedTv();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCount, 2);
  });
}
