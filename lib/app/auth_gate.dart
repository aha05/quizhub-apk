import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizhub/core/common/cubits/app_user/cubit/app_user_cubit.dart';
import 'package:quizhub/core/common/widgets/loader.dart';
import 'package:quizhub/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:quizhub/features/auth/presentation/screens/login_screen.dart';
import 'package:quizhub/features/home/presentation/screens/home_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        if (authState is AuthInitial || authState is AuthLoading) {
          return const Scaffold(body: Loader());
        }

        if (authState is AuthSuccess) {
          return const HomeScreen();
        }

        if (authState is AuthFailure || authState is AuthLogoutSuccess) {
          return const LoginScreen();
        }

        // fallback using AppUserCubit
        return BlocSelector<AppUserCubit, AppUserState, bool>(
          selector: (state) => state is AppUserLoggedIn,
          builder: (context, isLoggedIn) {
            return isLoggedIn ? const HomeScreen() : const LoginScreen();
          },
        );
      },
    );
  }
}
