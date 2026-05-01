import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizhub/core/utils/show_snackbar.dart';
import 'package:quizhub/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:quizhub/features/profile/presentation/utils/profile_presentation_constants.dart';
import 'package:quizhub/features/profile/presentation/widgets/change_password_sheet.dart';
import 'package:quizhub/features/profile/presentation/widgets/edit_profile_sheet.dart';
import 'package:quizhub/features/profile/presentation/widgets/profile_content.dart';
import 'package:quizhub/features/profile/presentation/widgets/profile_error_view.dart';
import 'package:quizhub/init_dependencies.dart';

class ProfileScreen extends StatelessWidget {
  final int userId;
  final String email;

  const ProfileScreen({super.key, required this.userId, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          serviceLocator<ProfileBloc>()..add(ProfileActivityRequested()),
      child: _ProfileView(userId: userId, email: email),
    );
  }
}

class _ProfileView extends StatelessWidget {
  final int userId;
  final String email;

  const _ProfileView({required this.userId, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoadSuccess && state.actionMessage != null) {
          showSnackBar(context, state.actionMessage!);
          Navigator.of(context).maybePop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ProfilePresentationConstants.backgroundColor,
          appBar: AppBar(
            title: const Text(ProfilePresentationConstants.title),
            backgroundColor: ProfilePresentationConstants.surfaceColor,
            foregroundColor: Colors.black87,
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(color: Colors.grey.shade200, height: 1),
            ),
          ),
          body: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, ProfileState state) {
    if (state is ProfileLoading || state is ProfileInitial) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ProfileFailure) {
      return ProfileErrorView(
        message: state.message,
        onRetry: () {
          context.read<ProfileBloc>().add(ProfileActivityRequested());
        },
      );
    }

    final successState = state as ProfileLoadSuccess;

    return ProfileContent(
      activity: successState.activity,
      email: email,
      onRefresh: () async {
        context.read<ProfileBloc>().add(ProfileActivityRequested());
      },
      onEditProfile: () => _showEditProfileSheet(context, successState),
      onChangePassword: () => _showChangePasswordSheet(context, successState),
    );
  }

  void _showEditProfileSheet(BuildContext context, ProfileLoadSuccess state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<ProfileBloc>(),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, sheetState) {
              return EditProfileSheet(
                currentName: state.activity.name,
                currentEmail: email,
                isSaving:
                    sheetState is ProfileLoadSuccess && sheetState.isSubmitting,
                onSaved: (name, email) {
                  context.read<ProfileBloc>().add(
                    ProfileUpdated(name: name, email: email),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  void _showChangePasswordSheet(
    BuildContext context,
    ProfileLoadSuccess state,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BlocProvider.value(
          value: context.read<ProfileBloc>(),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, sheetState) {
              return ChangePasswordSheet(
                isSaving:
                    sheetState is ProfileLoadSuccess && sheetState.isSubmitting,
                onSaved: (currentPassword, newPassword) {
                  context.read<ProfileBloc>().add(
                    ProfilePasswordChanged(
                      userId: userId,
                      currentPassword: currentPassword,
                      newPassword: newPassword,
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}
