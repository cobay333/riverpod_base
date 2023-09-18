import 'package:base_riverpod/feature/home/home_controller.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/movie_model.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState{
 const factory HomeState({
   required List<MovieModel> movies,
   required FilterItem filter,
   required PageStatus status
}) = _HomeState;
}