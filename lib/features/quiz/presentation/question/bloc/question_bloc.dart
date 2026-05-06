import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizhub/features/quiz/data/models/answer_payload.dart';
import 'package:quizhub/features/quiz/data/models/submit_answer_payload.dart';
import 'package:quizhub/features/quiz/domain/entities/enums.dart';
import 'package:quizhub/features/quiz/domain/entities/question.dart';
import 'package:quizhub/features/quiz/domain/entities/quiz_result.dart';
import 'package:quizhub/features/quiz/domain/usecases/questions.dart';
import 'package:quizhub/features/quiz/domain/usecases/submit_quiz_answers.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, QuestionState> {
  final Questions _questions;
  final SubmitQuizAnswers _submitQuizAnswers;
  Timer? _timer;

  QuestionBloc({
    required Questions questions,
    required SubmitQuizAnswers submitQuizAnswers,
  }) : _questions = questions,
       _submitQuizAnswers = submitQuizAnswers,
       super(const QuestionState.initial()) {
    on<QuestionsRequested>(_onQuestionsRequested);
    on<QuestionAnswerToggled>(_onAnswerToggled);
    on<QuestionPrevious>(_onPrevious);
    on<QuestionNext>(_onNext);
    on<QuestionSubmitted>(_onSubmitted);
    on<QuestionTimerTicked>(_onTimerTicked);
  }

  Future<void> _onQuestionsRequested(
    QuestionsRequested event,
    Emitter<QuestionState> emit,
  ) async {
    emit(const QuestionState.loading());

    try {
      final result = await _questions.call(
        QuestionsParams(quizId: event.quizId),
      );
      result.fold(
        (failure) =>
            emit(QuestionState.failure('Failed to load questions: $failure')),
        (questions) {
          final initial = QuestionState.loaded(
            quizId: event.quizId,
            userId: event.userId,
            timeLimitSeconds: event.timeLimit * 60,
            questions: questions,
          );
          emit(initial);
          _startTimer(initial.remainingSeconds);
        },
      );
    } catch (e) {
      emit(QuestionState.failure('Failed to load questions: $e'));
    }
  }

  void _startTimer(int seconds) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      add(const QuestionTimerTicked());
    });
  }

  Future<void> _onTimerTicked(
    QuestionTimerTicked event,
    Emitter<QuestionState> emit,
  ) async {
    final state = this.state;
    if (state.status != QuestionStatus.loaded) return;

    if (state.remainingSeconds <= 1) {
      _timer?.cancel();
      add(const QuestionSubmitted(autoSubmit: true));
      return;
    }

    emit(state.copyWith(remainingSeconds: state.remainingSeconds - 1));
  }

  Future<void> _onAnswerToggled(
    QuestionAnswerToggled event,
    Emitter<QuestionState> emit,
  ) async {
    final state = this.state;
    if (state.status != QuestionStatus.loaded) return;

    final answers = Map<int, List<int>>.from(state.answers);
    final current = List<int>.from(answers[event.questionId] ?? []);

    if (state.currentQuestion.type == QuestionType.SINGLE) {
      answers[event.questionId] = [event.optionId];
    } else {
      if (current.contains(event.optionId)) {
        current.remove(event.optionId);
      } else {
        current.add(event.optionId);
      }
      answers[event.questionId] = current;
    }

    emit(state.copyWith(answers: answers));
  }

  Future<void> _onPrevious(
    QuestionPrevious event,
    Emitter<QuestionState> emit,
  ) async {
    final state = this.state;
    if (state.status != QuestionStatus.loaded) return;
    if (state.currentIndex == 0) return;
    emit(state.copyWith(currentIndex: state.currentIndex - 1));
  }

  Future<void> _onNext(QuestionNext event, Emitter<QuestionState> emit) async {
    final state = this.state;
    if (state.status != QuestionStatus.loaded) return;
    if (state.currentIndex >= state.questions.length - 1) return;
    emit(state.copyWith(currentIndex: state.currentIndex + 1));
  }

  Future<void> _onSubmitted(
    QuestionSubmitted event,
    Emitter<QuestionState> emit,
  ) async {
    final state = this.state;
    if (state.status != QuestionStatus.loaded) return;

    emit(state.copyWith(status: QuestionStatus.submitting));
    _timer?.cancel();

    try {
      final payload = SubmitAnswerPayload(
        userId: state.userId,
        timeTaken: (state.timeLimitSeconds - state.remainingSeconds),
        answers: state.answers.entries
            .map(
              (entry) => AnswerPayload(
                questionId: entry.key,
                selectedOptionIds: entry.value,
              ),
            )
            .toList(),
      );

      final result = await _submitQuizAnswers.call(
        SubmitQuizAnswersParams(quizId: state.quizId, payload: payload),
      );

      result.fold(
        (failure) => emit(
          state.copyWith(
            status: QuestionStatus.loaded,
            errorMessage: 'Failed to submit: $failure',
          ),
        ),
        (quizResult) => emit(
          state.copyWith(
            status: QuestionStatus.submissionSuccess,
            submissionResult: quizResult,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: QuestionStatus.loaded,
          errorMessage: 'Failed to submit: $e',
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
