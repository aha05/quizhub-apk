import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:quizhub/core/common/cubits/app_user/cubit/app_user_cubit.dart';
import 'package:quizhub/core/network/api_service.dart';
import 'package:quizhub/core/network/connection_checker.dart';
import 'package:quizhub/core/storage/secure_storage.dart';
import 'package:quizhub/core/storage/token_manager.dart';
import 'package:quizhub/core/storage/token_manager_impl.dart';
import 'package:quizhub/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:quizhub/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:quizhub/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:quizhub/features/auth/domain/repositories/auth_repository.dart';
import 'package:quizhub/features/auth/domain/usecases/auth_login.dart';
import 'package:quizhub/features/auth/domain/usecases/auth_signup.dart';
import 'package:quizhub/features/auth/domain/usecases/current_user.dart';
import 'package:quizhub/features/auth/presentation/bloc/auth_bloc.dart';

part 'init_dependencies.main.dart';