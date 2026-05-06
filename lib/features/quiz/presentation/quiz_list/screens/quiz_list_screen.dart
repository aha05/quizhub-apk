import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizhub/features/home/domain/entities/category.dart';
import 'package:quizhub/features/quiz/presentation/quiz_list/bloc/quiz_list_bloc.dart';
import 'package:quizhub/features/quiz/presentation/quiz_list/widgets/quiz_list_content.dart';
import 'package:quizhub/core/di/service_locator.dart';

class QuizListScreen extends StatelessWidget {
  final Category category;

  const QuizListScreen({super.key, required this.category});

  static Route route(Category category) {
    return MaterialPageRoute(
      builder: (_) => QuizListScreen(category: category),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          serviceLocator<QuizListBloc>()..add(QuizListRequested(category.id)),
      child: QuizListContent(category: category),
    );
  }
}
