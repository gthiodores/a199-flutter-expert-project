import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/get_tv_now_playing.dart';
import 'package:core/presentation/bloc/tv_now_playing/tv_now_playing_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetTvNowPlaying])
void main() {
  late MockGetTvNowPlaying usecase;
  late TvNowPlayingBloc nowPlayingBloc;

  setUp(() {
    usecase = MockGetTvNowPlaying();
    nowPlayingBloc = TvNowPlayingBloc(usecase);
  });

  test('initial state should be mepty', () {
    expect(nowPlayingBloc.state, TvNowPlayingEmpty());
  });

  blocTest<TvNowPlayingBloc, TvNowPlayingState>(
    'should return data when usecase successful',
    build: () => nowPlayingBloc,
    act: (bloc) {
      when(usecase.execute()).thenAnswer((_) async => Right(testMovieList));
      nowPlayingBloc.add(TvNowPlayingInit());
    },
    expect: () => <TvNowPlayingState>[
      TvNowPlayingLoading(),
      TvNowPlayingLoaded(testMovieList),
    ],
    verify: (_) => verify(usecase.execute()),
  );

  blocTest<TvNowPlayingBloc, TvNowPlayingState>(
    'should return error when usecase failed',
    build: () => nowPlayingBloc,
    act: (bloc) {
      when(usecase.execute())
          .thenAnswer((_) async => Left(ServerFailure('failed')));
      nowPlayingBloc.add(TvNowPlayingInit());
    },
    expect: () => <TvNowPlayingState>[
      TvNowPlayingLoading(),
      TvNowPlayingError('failed'),
    ],
    verify: (_) => verify(usecase.execute()),
  );
}
