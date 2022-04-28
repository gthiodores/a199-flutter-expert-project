import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/get_tv_popular.dart';
import 'package:core/presentation/bloc/tv_popular/tv_popular_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_popular_bloc_test.mocks.dart';

@GenerateMocks([GetTvPopular])
void main() {
  late MockGetTvPopular usecase;
  late TvPopularBloc popularBloc;

  setUp(() {
    usecase = MockGetTvPopular();
    popularBloc = TvPopularBloc(usecase);
  });

  test('initial state should be empty', () {});

  blocTest<TvPopularBloc, TvPopularState>(
    'should return data when loading successful',
    build: () => popularBloc,
    act: (bloc) {
      when(usecase.execute()).thenAnswer((_) async => Right(testMovieList));
      popularBloc.add(TvPopularInit());
    },
    expect: () => <TvPopularState>[
      TvPopularLoading(),
      TvPopularLoaded(testMovieList),
    ],
    verify: (_) => verify(usecase.execute()),
  );

  blocTest<TvPopularBloc, TvPopularState>(
    'should return error when loading failed',
    build: () => popularBloc,
    act: (bloc) {
      when(usecase.execute())
          .thenAnswer((_) async => Left(ServerFailure('error')));
      popularBloc.add(TvPopularInit());
    },
    expect: () => <TvPopularState>[
      TvPopularLoading(),
      TvPopularError('error'),
    ],
    verify: (_) => verify(usecase.execute()),
  );
}
