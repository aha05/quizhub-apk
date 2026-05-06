import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizhub/core/common/cubits/app_user/cubit/app_user_cubit.dart';
import 'package:quizhub/core/utils/show_snackbar.dart';
import 'package:quizhub/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:quizhub/features/auth/presentation/screens/login_screen.dart';
import 'package:quizhub/features/home/presentation/bloc/home_bloc.dart';
import 'package:quizhub/features/home/presentation/widgets/home_content.dart';
import 'package:quizhub/features/home/presentation/widgets/home_error_view.dart';
import 'package:quizhub/features/home/presentation/widgets/home_loading_view.dart';
import 'package:quizhub/features/quiz/presentation/quiz_list/screens/quiz_list_screen.dart';

class HomeScreen extends StatefulWidget {
  static Route<HomeScreen> route() {
    return MaterialPageRoute(builder: (context) => const HomeScreen());
  }

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeDataRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        _handleAuthState(context, state);
      },
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          _handleHomeState(context, state);
        },
        builder: (context, state) {
          if (state is HomeLoading || state is HomeInitial) {
            return const HomeLoadingView();
          }

          if (state is HomeFailure) {
            return HomeErrorView(
              onRetry: () => context.read<HomeBloc>().add(HomeDataRequested()),
            );
          }

          final homeData = (state as HomeLoadSuccess).homeData;
          final appUserState = context.watch<AppUserCubit>().state;
          final user = appUserState is AppUserLoggedIn
              ? appUserState.user
              : null;

          return HomeContent(
            homeData: homeData,
            user: user,
            onCategorySelected: (category) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => QuizListScreen(category: category),
                ),
              );
            },
            onLogout: () {
              Navigator.pop(context);
              context.read<AuthBloc>().add(AuthLogout());
            },
          );
        },
      ),
    );
  }

  void _handleAuthState(BuildContext context, AuthState state) {
    if (state is AuthLogoutSuccess) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }

    if (state is AuthFailure) {
      showSnackBar(context, state.message);
    }
  }

  void _handleHomeState(BuildContext context, HomeState state) {
    if (state is HomeFailure) {
      showSnackBar(context, state.message);
    }
  }
}
