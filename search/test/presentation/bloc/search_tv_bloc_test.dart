import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/presentation/bloc/search_tv_bloc.dart';
import 'package:search/search.dart';

import 'search_tv_bloc_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late SearchTvBloc bloc;
  late MockSearchTv useCase;

  setUp(() {
    useCase = MockSearchTv();
    bloc = SearchTvBloc(useCase);
  });

  final tQuery = 'query';
  final tTv = Movie(
      id: 1,
      title: 'Supernatural',
      posterPath: 'poster',
      overview: 'overview',
      isMovie: false,
      adult: false,
      backdropPath: 'backdrop',
      genreIds: [1],
      originalTitle: 'Supernatural',
      popularity: 1.0,
      releaseDate: '2007-01-01',
      video: false,
      voteAverage: 1,
      voteCount: 1);
  final tTvList = [tTv];
  final debounceTime = Duration(milliseconds: 500);

  test('initial data should be empty', () {
    expect(bloc.state, SearchTvEmpty());
  });

  blocTest<SearchTvBloc, SearchTvState>(
    'should emit [loading, hasData] when success',
    build: () => bloc,
    act: (bloc) {
      when(useCase.execute(tQuery)).thenAnswer((_) async => Right(tTvList));
      bloc.add(OnTvQueryChanged(tQuery));
    },
    expect: () => <SearchTvState>[
      SearchTvLoading(),
      SearchTvHasData(tTvList),
    ],
    verify: (bloc) => verify(useCase.execute(tQuery)),
    wait: debounceTime,
  );

  blocTest<SearchTvBloc, SearchTvState>(
    'should emit [loading, error] when fail',
    build: () => bloc,
    act: (bloc) {
      when(useCase.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Error')));
      bloc.add(OnTvQueryChanged(tQuery));
    },
    expect: () => <SearchTvState>[
      SearchTvLoading(),
      SearchTvError('Server Error'),
    ],
    verify: (bloc) => verify(useCase.execute(tQuery)),
    wait: debounceTime,
  );
}
