import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:priyo_quiz/constants/colors.dart';
import 'package:priyo_quiz/constants/objects.dart';
import 'package:priyo_quiz/constants/resources.dart';
import 'package:priyo_quiz/services/navigation/navigation_service.dart';
import 'package:priyo_quiz/ui/quiz_list/cubit/quiz_list_cubit.dart';
import 'package:priyo_quiz/ui/quiz_list/data/models/response.dart';
import 'package:priyo_quiz/ui/quiz_list/winner_list_screen.dart';
import 'package:priyo_quiz/utils/appbar.dart';
import 'package:priyo_quiz/utils/button.dart';
import 'package:priyo_quiz/utils/load_image.dart';
import 'package:priyo_quiz/utils/loader.dart';
import 'package:priyo_quiz/utils/locator.dart';
import 'package:priyo_quiz/utils/margin.dart';
import 'package:priyo_quiz/utils/text.dart';

class QuizListScreen extends StatefulWidget {
  static const routeName = "/quiz-list";

  QuizListScreen({ Key? key }) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  _QuizListScreenState createState() => _QuizListScreenState();
}

class _QuizListScreenState extends State<QuizListScreen> {
  List<Quiz> _quizzes = [];
  bool _isListEnded = false;
  int _pageCount = 0;

  Widget _buildQuizQuestions(QuizQuestion question){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        margin(y: 10),
        loadImage(
          height: 180, 
          width: double.infinity, 
          url: question.questionImage ?? Res.img_dummy_url
        ),
        margin(y: 10),
        xText(
          text: question.questionText,
          textAlign: TextAlign.justify
        ),
        margin(y: 10),
        xText(
          text: "সঠিক উত্তর: ${question.correctAnswerText}",
          color: ColorsX.success
        )
      ],
    );
  }

  Widget _buildLoader() {
    return Container(
      height: blocks.size(100),
      child: Center(
        child: LoadingIndicator(),
      ),
    );
  }

  Widget _buildQuizCard(Quiz quiz,int index){
    return Card(
      margin: index != 0 ? EdgeInsets.only(top: blocks.size(14)) : null,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: blocks.size(20),
          vertical: blocks.size(20)
        ),
        child: Column(
          children: [
            xText(
              text: quiz.name,
              fontWeight: FontWeight.w700
            ),
            margin(y: 10),
            xText(
              text: quiz.prize,
              fontSize: scale.size(10),
              textAlign: TextAlign.justify
            ),
            ...quiz.questionList!.map((e) => _buildQuizQuestions(e)).toList(),
            quiz.resultPublished == true ?
            margin(y: 20) : SizedBox.shrink(),
            quiz.resultPublished == true ?
            xButton(
              label: "View Winners",
              height: blocks.size(40),
              width: double.infinity,
              onPressed: (){
                locator<NavigationService>()
                  .navigateToWithArgument(WinnerListScreen.routeName, arguments: WinnerListScreenArgs(
                    name: quiz.name,
                    winners: quiz.winnerList
                  ));
              }
            ) : SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuizListCubit>(
      create: (ctx) => QuizListCubit(),
      child: Scaffold(
        appBar: pqAppbar(context, "Previous Quizzes", true),
        body: BlocConsumer<QuizListCubit,QuizListState>(
          listener: (_,state) {
            if(state is QuizListLoaded){
              setState(() {
                _quizzes = new List.from(_quizzes)..addAll(state.quizzes);
                _pageCount++;
              });
            } else if(state is QuizListError){
              setState(() {
                _isListEnded = true;
              });
            }
          },
          builder: (ctx,state) {
            if(state is QuizListLoading){
              return Center(child: LoadingIndicator());
            }

            return ListView.builder(
              controller: widget._scrollController
                  ..addListener(() {
                    if (widget._scrollController.offset ==
                            widget._scrollController.position.maxScrollExtent &&
                        !_isListEnded && state is QuizListLoaded) {
                      ctx.read<QuizListCubit>().getQuizList(_pageCount);
                    }
                  }),
              itemCount: _quizzes.length,
              itemBuilder: (_,index) {
                if(index == _quizzes.length - 1 && !_isListEnded){
                  return Column(
                    children: [
                      _buildQuizCard(_quizzes[index],index),
                      _buildLoader()
                    ],
                  );
                }

                return _buildQuizCard(_quizzes[index],index);
              }
            );
          }
        ),
      ),
    );
  }
}