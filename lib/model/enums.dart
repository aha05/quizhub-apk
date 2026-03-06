enum Difficulty { EASY, MEDIUM, HARD }

enum QuizStatus { ACTIVE, INACTIVE }

extension DifficultyExtension on Difficulty {
  static Difficulty fromString(String? value) {
    switch (value?.toUpperCase()) {
      case 'EASY':
        return Difficulty.EASY;
      case 'MEDIUM':
        return Difficulty.MEDIUM;
      case 'HARD':
        return Difficulty.HARD;
      default:
        return Difficulty.EASY;
    }
  }

  String get label {
    switch (this) {
      case Difficulty.EASY:
        return 'Easy';
      case Difficulty.MEDIUM:
        return 'Medium';
      case Difficulty.HARD:
        return 'Hard';
    }
  }
}

extension QuizStatusExtension on QuizStatus {
  static QuizStatus fromString(String? value) {
    switch (value?.toUpperCase()) {
      case 'ACTIVE':
        return QuizStatus.ACTIVE;
      case 'INACTIVE':
        return QuizStatus.INACTIVE;
      default:
        return QuizStatus.INACTIVE;
    }
  }
}

enum QuestionType { SINGLE, MULTIPLE }

extension QuestionTypeExtension on QuestionType {
  static QuestionType fromString(String? value) {
    switch (value?.toUpperCase()) {
      case 'SINGLE':
        return QuestionType.SINGLE;
      case 'MULTIPLE':
        return QuestionType.MULTIPLE;
      default:
        return QuestionType.SINGLE;
    }
  }
}