import 'package:about/about.dart';
import 'package:core/common/utils.dart';
import 'package:core/core.dart';
import 'package:core/presentation/bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:core/presentation/bloc/movie_now_playing/movie_now_playing_bloc.dart';
import 'package:core/presentation/bloc/movie_popular/movie_popular_bloc.dart';
import 'package:core/presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';
import 'package:core/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:core/presentation/bloc/tv_now_playing/tv_now_playing_bloc.dart';
import 'package:core/presentation/bloc/tv_popular/tv_popular_bloc.dart';
import 'package:core/presentation/bloc/tv_top_rated/tv_top_rated_bloc.dart';
import 'package:core/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:core/presentation/pages/home_movie_page.dart';
import 'package:core/presentation/pages/home_tv_page.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:core/presentation/pages/popular_movies_page.dart';
import 'package:core/presentation/pages/popular_tv_page.dart';
import 'package:core/presentation/pages/top_rated_movies_page.dart';
import 'package:core/presentation/pages/top_rated_tv_page.dart';
import 'package:core/presentation/pages/tv_detail_page.dart';
import 'package:core/presentation/pages/watchlist_movies_page.dart';
import 'package:core/utils/routes.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:search/presentation/bloc/search_bloc.dart';
import 'package:search/presentation/bloc/search_tv_bloc.dart';
import 'package:search/search.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  di.init();
  await di.locator.allReady();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTvBloc>(),
        ),
        BlocProvider(
          create: (_) =>
              di.locator<MovieNowPlayingBloc>()..add(MovieNowPlayingInit()),
        ),
        BlocProvider(
          create: (_) =>
              di.locator<MoviePopularBloc>()..add(MoviePopularInit()),
        ),
        BlocProvider(
          create: (_) =>
              di.locator<MovieTopRatedBloc>()..add(MovieTopRatedInit()),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) =>
              di.locator<TvNowPlayingBloc>()..add(TvNowPlayingInit()),
        ),
        BlocProvider(
          create: (_) => di.locator<TvPopularBloc>()..add(TvPopularInit()),
        ),
        BlocProvider(
          create: (_) => di.locator<TvTopRatedBloc>()..add(TvTopRatedInit()),
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistMovieBloc>()
            ..add(
              FetchWatchlistMovies(DateTime.now().millisecondsSinceEpoch),
            ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HOME_ROUTE:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case HOME_TV_ROUTE:
              return MaterialPageRoute(builder: (_) => HomeTvPage());
            case POPULAR_MOVIE_ROUTE:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case POPULAR_TV_ROUTE:
              return CupertinoPageRoute(builder: (_) => PopularTvPage());
            case TOP_RATED_MOVIE_ROUTE:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case TOP_RATED_TV_ROUTE:
              return CupertinoPageRoute(builder: (_) => TopRatedTvPage());
            case MOVIE_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TV_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case SEARCH_MOVIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case SEARCH_TV_ROUTE:
              return CupertinoPageRoute(builder: (_) => SearchTvPage());
            case WATCH_LIST_ROTUE:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case ABOUT_ROUTE:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
