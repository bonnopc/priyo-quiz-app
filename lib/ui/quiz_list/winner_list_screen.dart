import 'package:flutter/material.dart';
import 'package:priyo_quiz/constants/colors.dart';
import 'package:priyo_quiz/constants/objects.dart';
import 'package:priyo_quiz/constants/resources.dart';
import 'package:priyo_quiz/ui/quiz_list/data/models/response.dart';
import 'package:priyo_quiz/utils/appbar.dart';
import 'package:priyo_quiz/utils/load_image.dart';
import 'package:priyo_quiz/utils/text.dart';

class WinnerListScreenArgs {
  final String? name;
  final List<QuizWinner>? winners;

  WinnerListScreenArgs({
    this.name,
    this.winners
  });
}

class WinnerListScreen extends StatelessWidget {
  static const routeName = "/winners-list";

  const WinnerListScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as WinnerListScreenArgs;

    return Scaffold(
      appBar: pqAppbar(context, args.name ?? "Winners", true),
      body: args.winners!.length > 0 ? _buildWinnerList(args.winners ?? []) : Center(
        child: xText(
          text: "Sorry, we can't find any winners right now",
          fontSize: scale.size(12)
        ),
      )
    );
  }

  Widget _buildWinnerList(List<QuizWinner> winners){
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 1.25,
      ), 
      itemCount: winners.length,
      itemBuilder: (_,index) {
        return _buildWinnerCard(winners[index]);
      });
  }

  Widget _buildWinnerCard(QuizWinner winner){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(blocks.size(7)),
      ),
      child: Stack(
          children: [
            loadImage(
              height: double.infinity, 
              width: double.infinity, 
              url: winner.image ?? Res.img_dummy_url
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.black.withAlpha(0),
                    Colors.black12,
                    Colors.black45
                  ],
                ),
              ),
              child: xText(
                text: winner.name,
                textAlign: TextAlign.center,
                fontSize: scale.size(12),
                color: ColorsX.white
              ),
            ),
          ],
        ),
      );
  }
}