import 'package:bloc_test/bloc_test.dart';
import 'package:core/presentation/bloc/movie_popular/movie_popular_bloc.dart';
import 'package:core/presentation/pages/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

class MockPopularMovieBloc
    extends MockBloc<MoviePopularEvent, MoviePopularState>
    implements MoviePopularBloc {}

void main() {
  late MoviePopularBloc moviePopularBloc;

  setUp(() {
    moviePopularBloc = MockPopularMovieBloc();
  });

  tearDown(() {
    moviePopularBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MoviePopularBloc>(
      create: (context) => moviePopularBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    whenListen(
      moviePopularBloc,
      Stream.fromIterable([MoviePopularLoading()]),
      initialState: MoviePopularLoading(),
    );

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    whenListen(
      moviePopularBloc,
      Stream.fromIterable([MoviePopularHasData(testMovieList)]),
      initialState: MoviePopularHasData(testMovieList),
    );

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    whenListen(
      moviePopularBloc,
      Stream.fromIterable([MoviePopularError('error')]),
      initialState: MoviePopularError('error'),
    );

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
