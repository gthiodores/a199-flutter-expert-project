import 'package:core/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/utils.dart';
import '../widgets/movie_card_list.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistMovieBloc>()
      ..add(FetchWatchlistMovies(DateTime.now().millisecondsSinceEpoch));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistMovieBloc>()
      ..add(FetchWatchlistMovies(DateTime.now().millisecondsSinceEpoch));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
          builder: (context, state) {
            if (state is WatchListMovieLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchListMovieHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.watchlist[index];
                  return MovieCard(movie);
                },
                itemCount: state.watchlist.length,
              );
            } else if (state is WatchListMovieError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.error),
              );
            } else {
              return Center(
                key: Key('unknown_err'),
                child: Text('Unknown Error'),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
