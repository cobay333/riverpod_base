import 'dart:async';

import 'package:base_riverpod/model/movie_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../repository/movie_repository.dart';
import 'home_state.dart';


enum FilterItem {
  asc,
  desc
}
enum PageStatus { initial, loading, success, failure }


class HomeController extends StateNotifier<HomeState> {
  final MovieRepository repository;
  HomeController({required this.repository}) : super(const HomeState(movies: [],
      filter: FilterItem.asc, status: PageStatus.initial));

  fetchData() async {
    state = state.copyWith(status: PageStatus.loading);
    final data = await fetchMovies();
    List<MovieModel> temp = List.from(data);
    temp.sort((a, b) {
      return a.title.compareTo(b.title);
    },);
    Future.delayed(const Duration(seconds: 60));
    state = state.copyWith(status: PageStatus.success, movies: temp);

  }

  sortByAsc(){
    List<MovieModel> temp = List.from(state.movies);
    temp.sort((a, b) {
      return a.title.compareTo(b.title);
    },);
    state = state.copyWith(filter: FilterItem.asc, movies: temp);
  }

  sortByDesc(){
    List<MovieModel> temp = List.from(state.movies);
    temp.sort((a, b) {
      return b.title.compareTo(a.title);
    },);
    state = state.copyWith(filter: FilterItem.desc, movies: temp);
  }

  Future<List<MovieModel>> fetchMovies() async {
    final cancelToken = CancelToken();
    return repository.nowPlayingMovies(
      cancelToken: cancelToken,
    );
  }
}


final homePageStateProvider =
StateNotifierProvider<HomeController, HomeState>(
      (ref) => HomeController(
    repository: ref.read(moviesRepositoryProvider),
  ),
);
