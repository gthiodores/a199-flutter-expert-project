import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

void main() {
  late MovieDetailBloc movieDetailBloc;

  setUp(() {
    movieDetailBloc = MockMovieDetailBloc();
  });

  tearDown(() {
    movieDetailBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider.value(
      value: movieDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    final initialState =
        MovieDetailLoaded(testMovieDetail, false, [], null, null);

    whenListen<MovieDetailState>(
      movieDetailBloc,
      Stream.fromIterable([initialState]),
      initialState: initialState,
    );

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    final initialState =
        MovieDetailLoaded(testMovieDetail, true, [], null, null);

    whenListen(
      movieDetailBloc,
      Stream.fromIterable([initialState]),
      initialState: initialState,
    );

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    final initialState =
        MovieDetailLoaded(testMovieDetail, false, [], null, null);

    whenListen(
      movieDetailBloc,
      Stream.fromIterable([
        initialState,
        initialState.copyWith(
          message: 'Added to Watchlist',
          isFavorite: true,
        ),
      ]),
      initialState: initialState,
    );

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    final initialState =
        MovieDetailLoaded(testMovieDetail, false, [], null, null);

    whenListen(
      movieDetailBloc,
      Stream.fromIterable([
        initialState,
        initialState.copyWith(
          watchlistMessage: 'Failed',
          isFavorite: true,
        ),
      ]),
      initialState: initialState,
    );

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
