import 'package:base_riverpod/flavors/flavor_values.dart';
import 'package:base_riverpod/model/movie_model.dart';
import 'package:base_riverpod/model/movie_response_model.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../providers/dio_provider.dart';
part 'movie_repository.g.dart';

class MovieRepository {
  MovieRepository({required this.client, required this.apiKey, required this.baseUrl});
  final Dio client;
  final String apiKey;
  final String baseUrl;

  Future<List<MovieModel>> nowPlayingMovies(
      {CancelToken? cancelToken}) async {
    final url = Uri(
      scheme: 'https',
      host: 'api.themoviedb.org',
      path: '3/movie/now_playing',
      queryParameters: {
        'api_key': apiKey,
        'include_adult': 'false',
        'page': '1',
      },
    ).toString();
    final response = await client.get(url, cancelToken: cancelToken);
    final movies = MovieResponseModel.fromJson(response.data);
    return movies.results;
  }

  Future<MovieModel> movie(
      {required int movieId, CancelToken? cancelToken}) async {
    final url = Uri(
      scheme: 'https',
      host: 'api.themoviedb.org',
      path: '3/movie/$movieId',
      queryParameters: {
        'api_key': apiKey,
        'include_adult': 'false',
      },
    ).toString();
    final response = await client.get(url, cancelToken: cancelToken);
    return MovieModel.fromJson(response.data);
  }
}

@riverpod
MovieRepository moviesRepository(MoviesRepositoryRef ref) => MovieRepository(
  client: ref.watch(dioProvider),
  apiKey: FlavorValues.fromEnvironment().apiKey,
  baseUrl: FlavorValues.fromEnvironment().apiBaseUrl
);