import 'package:core/data/models/movie_table.dart';
import 'package:core/data/models/tv_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/entities/season.dart';
import 'package:core/domain/entities/tv_detail.dart';

final testMovie = Movie(
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

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testTv = TvModel(
  posterPath: "posterPath",
  popularity: 1.0,
  id: 1,
  backdropPath: "backdropPath",
  voteAverage: 1.0,
  overview: "overview",
  firstAirDate: "firstAirDate",
  originCountry: ["originCountry"],
  genreIds: [1, 2, 3],
  originalLanguage: "originalLanguage",
  voteCount: 1,
  name: "name",
  originalName: "originalName",
);

final testTvList = [testTv];

final testTvDetail = TvDetail(
  backdropPath: "backdropPath",
  firstAirDate: "firstAirDate",
  lastAirDate: "lastAirDate",
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  seasons: [
    Season(
      name: "name",
      overview: "overview",
      posterPath: "posterPath",
      episodeCount: 1,
      airDate: "airDate",
    )
  ],
  name: "name",
  originalName: "originalName",
  overview: "overview",
  posterPath: "posterPath",
  voteAverage: 1.0,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
  isMovie: true,
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
  isMovie: true,
);

final testMovieTableTv = MovieTable(
  id: 1,
  title: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
  isMovie: false,
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'isMovie': 1,
};
