import 'package:core/presentation/bloc/tv_popular/tv_popular_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/movie_card_list.dart';

class PopularTvPage extends StatelessWidget {
  const PopularTvPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvPopularBloc, TvPopularState>(
          builder: (context, state) {
            if (state is TvPopularLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvPopularLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.data[index];
                  return MovieCard(movie);
                },
                itemCount: state.data.length,
              );
            } else if (state is TvPopularError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                key: Key('error_message'),
                child: Text('unknown error'),
              );
            }
          },
        ),
      ),
    );
  }
}
