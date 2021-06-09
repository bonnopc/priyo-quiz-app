part of 'quiz_list_cubit.dart';

@immutable
abstract class QuizListState {}

class QuizListInitial extends QuizListState {}
class QuizListLoading extends QuizListState {}
class QuizListLoadingMore extends QuizListState {}
class QuizListLoaded extends QuizListState {
  final List<Quiz> quizzes;

  QuizListLoaded(this.quizzes);

  List<dynamic> get props => [quizzes];
}
class QuizListError extends QuizListState {}
