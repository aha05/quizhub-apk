import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizhub/core/usecase/usecase.dart';
import 'package:quizhub/features/home/domain/entities/home_data.dart';
import 'package:quizhub/features/home/domain/usecases/fetch_home_data.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchHomeData _fetchHomeData;

  HomeBloc({required FetchHomeData fetchHomeData})
    : _fetchHomeData = fetchHomeData,
      super(HomeInitial()) {
    on<HomeDataRequested>(_onHomeDataRequested);
  }

  void _onHomeDataRequested(
    HomeDataRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    final result = await _fetchHomeData(NoParams());

    result.fold(
      (failure) => emit(HomeFailure(failure.message)),
      (homeData) => emit(HomeLoadSuccess(homeData)),
    );
  }
}
