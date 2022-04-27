import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/presentation/pages/search_page.dart';

class MockSearchPageBloc extends MockBloc<SearchEvent, SearchState>
    implements SearchBloc {}

void main() {
  late SearchBloc searchBloc;

  setUp(() {
    searchBloc = MockSearchPageBloc();
  });

  Widget _createTestableWidget(Widget body) {
    return BlocProvider.value(
      value: searchBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tQuery = 'query';
  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
    isMovie: true,
  );
  final tMovieList = <Movie>[tMovieModel];

  testWidgets('page should start with an empty container and empty text field',
      (WidgetTester tester) async {
    when(() => searchBloc.state).thenReturn(SearchEmpty());

    await tester.pumpWidget(_createTestableWidget(SearchPage()));

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
    when(() => searchBloc.state).thenReturn(SearchHasData(tMovieList));

    await tester.pumpWidget(_createTestableWidget(SearchPage()));

    final findsList = find.byType(ListView);
    final findsMovieCart = find.byType(MovieCard);

    expect(findsList, findsOneWidget);
    expect(findsMovieCart, findsOneWidget);
  });

  testWidgets('page should have visible circular loading when state is loading',
      (WidgetTester tester) async {
    when(() => searchBloc.state).thenReturn(SearchLoading());

    await tester.pumpWidget(_createTestableWidget(SearchPage()));

    final findsLoading = find.byType(CircularProgressIndicator);

    expect(findsLoading, findsOneWidget);
  });

  testWidgets('page should send query event when text field is changed',
      (WidgetTester tester) async {
    when(() => searchBloc.state).thenReturn(SearchEmpty());

    await tester.pumpWidget(_createTestableWidget(SearchPage()));

    final findsTextField = find.byType(TextField);
    await tester.enterText(findsTextField, tQuery);
    await tester.pumpAndSettle();

    verify(() => searchBloc.add(OnQueryChanged(tQuery))).called(1);
  });
}
