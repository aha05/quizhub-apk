part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoadSuccess extends HomeState {
  final HomeData homeData;

  const HomeLoadSuccess(this.homeData);

  @override
  List<Object> get props => [homeData];
}

final class HomeFailure extends HomeState {
  final String message;

  const HomeFailure(this.message);

  @override
  List<Object> get props => [message];
}
