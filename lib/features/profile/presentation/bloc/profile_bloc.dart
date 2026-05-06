import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizhub/core/usecase/usecase.dart';
import 'package:quizhub/features/profile/domain/entities/profile_activity.dart';
import 'package:quizhub/features/profile/domain/usecases/change_password.dart';
import 'package:quizhub/features/profile/domain/usecases/get_profile_activity.dart';
import 'package:quizhub/features/profile/domain/usecases/update_profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileActivity _getProfileActivity;
  final UpdateProfile _updateProfile;
  final ChangePassword _changePassword;

  ProfileBloc({
    required GetProfileActivity getProfileActivity,
    required UpdateProfile updateProfile,
    required ChangePassword changePassword,
  }) : _getProfileActivity = getProfileActivity,
       _updateProfile = updateProfile,
       _changePassword = changePassword,
       super(ProfileInitial()) {
    on<ProfileActivityRequested>(_onActivityRequested);
    on<ProfileUpdated>(_onProfileUpdated);
    on<ProfilePasswordChanged>(_onPasswordChanged);
  }

  Future<void> _onActivityRequested(
    ProfileActivityRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());

    final result = await _getProfileActivity(NoParams());

    result.fold(
      (failure) => emit(ProfileFailure(failure.message)),
      (activity) => emit(ProfileLoadSuccess(activity: activity)),
    );
  }

  Future<void> _onProfileUpdated(
    ProfileUpdated event,
    Emitter<ProfileState> emit,
  ) async {
    final currentState = state;
    ProfileActivity? previousActivity;

    if (currentState is ProfileLoadSuccess) {
      previousActivity = currentState.activity;
      emit(currentState.copyWith(isSubmitting: true));
    }

    final result = await _updateProfile(
      UpdateProfileParams(name: event.name, email: event.email),
    );

    result.fold(
      (failure) {
        if (previousActivity == null) {
          emit(ProfileFailure(failure.message));
          return;
        }

        emit(
          ProfileLoadSuccess(
            activity: previousActivity,
            actionMessage: failure.message,
          ),
        );
      },
      (_) {
        final updatedActivity = previousActivity?.copyWith(name: event.name);

        if (updatedActivity == null) {
          add(ProfileActivityRequested());
          return;
        }

        emit(
          ProfileLoadSuccess(
            activity: updatedActivity,
            actionMessage: 'Profile updated successfully',
          ),
        );
      },
    );
  }

  Future<void> _onPasswordChanged(
    ProfilePasswordChanged event,
    Emitter<ProfileState> emit,
  ) async {
    final currentState = state;
    ProfileActivity? previousActivity;

    if (currentState is ProfileLoadSuccess) {
      previousActivity = currentState.activity;
      emit(currentState.copyWith(isSubmitting: true));
    }

    final result = await _changePassword(
      ChangePasswordParams(
        userId: event.userId,
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
      ),
    );

    result.fold(
      (failure) {
        if (previousActivity == null) {
          emit(ProfileFailure(failure.message));
          return;
        }

        emit(
          ProfileLoadSuccess(
            activity: previousActivity,
            actionMessage: failure.message,
          ),
        );
      },
      (_) {
        if (previousActivity == null) {
          add(ProfileActivityRequested());
          return;
        }

        emit(
          ProfileLoadSuccess(
            activity: previousActivity,
            actionMessage: 'Password updated successfully',
          ),
        );
      },
    );
  }
}
