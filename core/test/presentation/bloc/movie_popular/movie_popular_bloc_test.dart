import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/presentation/bloc/movie_popular/movie_popular_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies usecase;
  late MoviePopularBloc movieBloc;

  setUp(() {
    usecase = MockGetPopularMovies();
    movieBloc = MoviePopularBloc(usecase);
  });

  test('should start with empty state', () {
    expect(movieBloc.state, MoviePopularEmpty());
  });

  blocTest<MoviePopularBloc, MoviePopularState>(
    'should return [loading, has data] on init success',
    build: () => movieBloc,
    act: (bloc) {
      when(usecase.execute()).thenAnswer((_) async => Right(testMovieList));
      movieBloc.add(MoviePopularInit());
    },
    expect: () => <MoviePopularState>[
      MoviePopularLoading(),
      MoviePopularHasData(testMovieList),
    ],
    verify: (bloc) => verify(usecase.execute()),
  );

  blocTest<MoviePopularBloc, MoviePopularState>(
    'should return [loading, error] on init failed',
    build: () => movieBloc,
    act: (bloc) {
      when(usecase.execute())
          .thenAnswer((_) async => Left(ServerFailure('error')));
      movieBloc.add(MoviePopularInit());
    },
    expect: () => <MoviePopularState>[
      MoviePopularLoading(),
      MoviePopularError('error'),
    ],
    verify: (bloc) => verify(usecase.execute()),
  );
}
