import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/presentation/bloc/search_tv_bloc.dart';
import 'package:search/presentation/pages/search_tv_page.dart';

class MockSearchTvBloc extends MockBloc<SearchTvEvent, SearchTvState>
    implements SearchTvBloc {}

void main() {
  late SearchTvBloc searchBloc;

  setUp(() {
    searchBloc = MockSearchTvBloc();
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
    voteCount: 1,
  );
  final tTvList = [tTv];

  Widget _createTestableWidget(Widget body) {
    return BlocProvider.value(
      value: searchBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('page should start with an empty container and empty text field',
      (WidgetTester tester) async {
    when(() => searchBloc.state).thenReturn(SearchTvEmpty());

    await tester.pumpWidget(_createTestableWidget(SearchTvPage()));

    final findsEmptyContainer = find.byType(Container);
    final findsTextField = find.byType(TextField);
    final findsScaffold = find.byType(Scaffold);
    final findsAppbar = find.byType(AppBar);
    final findsEmptyText = find.widgetWithText(TextField, '');

    expect(findsEmptyContainer, findsOneWidget);
    expect(findsTextField, findsOneWidget);
    expect(findsScaffold, findsOneWidget);
    expect(findsAppbar, findsOneWidget);
    expect(findsEmptyText, findsOneWidget);
  });

  testWidgets('page should have a list of items when state has data',
      (WidgetTester tester) async {
    when(() => searchBloc.state).thenReturn(SearchTvHasData(tTvList));

    await tester.pumpWidget(_createTestableWidget(SearchTvPage()));

    final findsList = find.byType(ListView);
    final findsMovieCart = find.byType(MovieCard);

    expect(findsList, findsOneWidget);
    expect(findsMovieCart, findsOneWidget);
  });

  testWidgets('page should have visible circular loading when state is loading',
      (WidgetTester tester) async {
    when(() => searchBloc.state).thenReturn(SearchTvLoading());

    await tester.pumpWidget(_createTestableWidget(SearchTvPage()));

    final findsLoading = find.byType(CircularProgressIndicator);

    expect(findsLoading, findsOneWidget);
  });

  testWidgets('page should send query event when text field is changed',
      (WidgetTester tester) async {
    when(() => searchBloc.state).thenReturn(SearchTvEmpty());

    await tester.pumpWidget(_createTestableWidget(SearchTvPage()));

    final findsTextField = find.byType(TextField);
    await tester.enterText(findsTextField, tQuery);
    await tester.pumpAndSettle();

    verify(() => searchBloc.add(OnTvQueryChanged(tQuery))).called(1);
  });
}
