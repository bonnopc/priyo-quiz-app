import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:priyo_quiz/ui/quiz_list/data/models/response.dart';
import 'package:priyo_quiz/ui/quiz_list/data/provider.dart';

part 'quiz_list_state.dart';

class QuizListCubit extends Cubit<QuizListState> {
  final _provider = QuizListDataProvider();

  QuizListCubit() : super(QuizListInitial()){
    getQuizList(0);
  }

  Future<void> getQuizList(int pageCount) async {
    try {
      print("pageCount from Cubit $pageCount");
      if(pageCount != 0) emit(QuizListLoadingMore());
      else emit(QuizListLoading());
      final quizzes = await _provider.getQuizList(pageCount: pageCount);

      print(quizzes?.length);
      if(quizzes != null && quizzes.length > 0){
        emit(QuizListLoaded(quizzes));
      } else {
        emit(QuizListError());
      }
    } catch (e) {
      emit(QuizListError());
      print("Error on getQuizList in QuizListCubit $e");
    }
  }
}
