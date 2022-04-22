import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/presentation/bloc/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies usecase;
  late MovieNowPlayingBloc bloc;

  setUp(() {
    usecase = MockGetNowPlayingMovies();
    bloc = MovieNowPlayingBloc(usecase);
  });

  test('should start with empty state', () {
    expect(bloc.state, MovieNowPlayingEmpty());
  });

  blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
    'should return [loading, has data] on init success',
    build: () => bloc,
    act: (bloc) {
      when(usecase.execute()).thenAnswer((_) async => Right(testMovieList));
      bloc.add(MovieNowPlayingInit());
    },
    expect: () => <MovieNowPlayingState>[
      MovieNowPlayingLoading(),
      MovieNowPlayingHasData(testMovieList),
    ],
    verify: (bloc) => verify(usecase.execute()),
  );

  blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
    'should return [loading, error] on init failed',
    build: () => bloc,
    act: (bloc) {
      when(usecase.execute())
          .thenAnswer((_) async => Left(ServerFailure('Error')));
      bloc.add(MovieNowPlayingInit());
    },
    expect: () => <MovieNowPlayingState>[
      MovieNowPlayingLoading(),
      MovieNowPlayingError('Error'),
    ],
    verify: (bloc) => verify(usecase.execute()),
  );
}
