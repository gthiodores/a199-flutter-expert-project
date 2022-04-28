import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/get_tv_top_rated.dart';
import 'package:core/presentation/bloc/tv_top_rated/tv_top_rated_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTvTopRated])
void main() {
  late MockGetTvTopRated usecase;
  late TvTopRatedBloc topRatedBloc;

  setUp(() {
    usecase = MockGetTvTopRated();
    topRatedBloc = TvTopRatedBloc(usecase);
  });

  test('initial state should be empty', () {
    expect(topRatedBloc.state, TvTopRatedEmpty());
  });

  blocTest<TvTopRatedBloc, TvTopRatedState>(
    'should return data when fetching is successful',
    build: () => topRatedBloc,
    act: (bloc) {
      when(usecase.execute()).thenAnswer((_) async => Right(testMovieList));
      topRatedBloc.add(TvTopRatedInit());
    },
    expect: () => <TvTopRatedState>[
      TvTopRatedLoading(),
      TvTopRatedLoaded(testMovieList),
    ],
    verify: (_) => verify(usecase.execute()),
  );

  blocTest<TvTopRatedBloc, TvTopRatedState>(
    'should return error when fetching failed',
    build: () => topRatedBloc,
    act: (bloc) {
      when(usecase.execute())
          .thenAnswer((_) async => Left(ServerFailure('failed')));
      topRatedBloc.add(TvTopRatedInit());
    },
    expect: () => <TvTopRatedState>[
      TvTopRatedLoading(),
      TvTopRatedError('failed'),
    ],
    verify: (_) => verify(usecase.execute()),
  );
}
