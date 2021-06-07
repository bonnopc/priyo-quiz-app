import 'package:flutter_svg/svg.dart';
import 'package:priyo_quiz/constants/colors.dart';
import 'package:priyo_quiz/constants/objects.dart';
import 'package:flutter/material.dart';
import 'package:priyo_quiz/constants/resources.dart';
import 'package:priyo_quiz/utils/text.dart';

PreferredSizeWidget pqAppbar(BuildContext context, String title, bool showBack,
    {Widget? buildTitle,
    bool decoration = true}) {

  return PreferredSize(
    child: Container(
      decoration: decoration
          ? BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: ColorsX.appBarShadow,
                    offset: Offset(0, 2),
                    blurRadius: 2.0,
                    spreadRadius: 0),
              ],
              color: ColorsX.white,
            )
          : null,
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: showBack
            ? IconButton(
                icon: SvgPicture.asset(Res.ic_back,
                    width: scale.size(20), color: ColorsX.white),
                onPressed: () async {
                  var currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus &&
                      currentFocus.focusedChild != null) {
                    currentFocus.focusedChild!.unfocus();
                  }
                  Navigator.pop(context);
                })
            : null,
        centerTitle: true,
        brightness: Brightness.light,
        backgroundColor: ColorsX.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTitle ??
                xText(
                    text: title,
                    color: ColorsX.textBlack,
                    fontSize: scale.size(16),
                    fontWeight: FontWeight.w800),
          ],
        ),
        elevation: 0.0,
        titleSpacing: showBack == true ? 0 : blocks.size(25),
      ),
    ),
    preferredSize: Size.fromHeight(kToolbarHeight),
  );
}
