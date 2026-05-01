part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class ProfileActivityRequested extends ProfileEvent {}

final class ProfileUpdated extends ProfileEvent {
  final String name;
  final String email;

  const ProfileUpdated({required this.name, required this.email});

  @override
  List<Object> get props => [name, email];
}

final class ProfilePasswordChanged extends ProfileEvent {
  final int userId;
  final String currentPassword;
  final String newPassword;

  const ProfilePasswordChanged({
    required this.userId,
    required this.currentPassword,
    required this.newPassword,
  });

  @override
  List<Object> get props => [userId, currentPassword, newPassword];
}
