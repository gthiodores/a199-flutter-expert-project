import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies usecase;
  late MovieTopRatedBloc topRatedBloc;

  setUp(() {
    usecase = MockGetTopRatedMovies();
    topRatedBloc = MovieTopRatedBloc(usecase);
  });

  test('should start with empty state', () {
    expect(topRatedBloc.state, MovieTopRatedEmpty());
  });

  blocTest<MovieTopRatedBloc, MovieTopRatedState>(
    'should return [loading, has data] on init success',
    build: () => topRatedBloc,
    act: (bloc) {
      when(usecase.execute()).thenAnswer((_) async => Right(testMovieList));
      topRatedBloc.add(MovieTopRatedInit());
    },
    expect: () => <MovieTopRatedState>[
      MovieTopRatedLoading(),
      MovieTopRatedHasData(testMovieList),
    ],
    verify: (bloc) => verify(usecase.execute()),
  );

  blocTest<MovieTopRatedBloc, MovieTopRatedState>(
    'should return [loading, error] on init failed',
    build: () => topRatedBloc,
    act: (bloc) {
      when(usecase.execute())
          .thenAnswer((_) async => Left(ServerFailure('error')));
      topRatedBloc.add(MovieTopRatedInit());
    },
    expect: () => <MovieTopRatedState>[
      MovieTopRatedLoading(),
      MovieTopRatedError('error'),
    ],
    verify: (bloc) => verify(usecase.execute()),
  );
}
