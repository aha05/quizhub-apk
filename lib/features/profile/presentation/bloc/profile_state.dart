part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileFailure extends ProfileState {
  final String message;

  const ProfileFailure(this.message);

  @override
  List<Object> get props => [message];
}

final class ProfileLoadSuccess extends ProfileState {
  final ProfileActivity activity;
  final bool isSubmitting;
  final String? actionMessage;

  const ProfileLoadSuccess({
    required this.activity,
    this.isSubmitting = false,
    this.actionMessage,
  });

  ProfileLoadSuccess copyWith({
    ProfileActivity? activity,
    bool? isSubmitting,
    String? actionMessage,
  }) {
    return ProfileLoadSuccess(
      activity: activity ?? this.activity,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      actionMessage: actionMessage,
    );
  }

  @override
  List<Object?> get props => [activity, isSubmitting, actionMessage];
}
