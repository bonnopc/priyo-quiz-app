class Quiz {
  String? quizUuid;
  String? name;
  String? startAt;
  bool? resultPublished;
  String? prize;
  List<QuizWinner>?winnerList;
  List<QuizQuestion>? questionList;

  Quiz(
      {this.quizUuid,
      this.name,
      this.startAt,
      this.resultPublished,
      this.prize,
      this.winnerList,
      this.questionList});

  Quiz.fromJson(Map<String, dynamic> json) {
    quizUuid = json['quizUuid'];
    name = json['name'];
    startAt = json['startAt'];
    resultPublished = json['resultPublished'];
    prize = json['prize'];
    if (json['winnerList'] != null) {
      winnerList = [];
      json['winnerList'].forEach((v) {
        winnerList?.add(new QuizWinner.fromJson(v));
      });
    }
    if (json['questionList'] != null) {
      questionList = [];
      json['questionList'].forEach((v) {
        questionList?.add(new QuizQuestion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quizUuid'] = this.quizUuid;
    data['name'] = this.name;
    data['startAt'] = this.startAt;
    data['resultPublished'] = this.resultPublished;
    data['prize'] = this.prize;
    if (this.winnerList != null) {
      data['winnerList'] = this.winnerList?.map((v) => v.toJson()).toList();
    }
    if (this.questionList != null) {
      data['questionList'] = this.questionList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuizWinner {
  String? xref;
  String? name;
  String? image;
  String? mobile;

  QuizWinner(
      {this.xref,
      this.name,
      this.image,
      this.mobile,
  });

  QuizWinner.fromJson(Map<String, dynamic> json) {
    xref = json['xref'];
    name = json['name'];
    image = json['image'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['xref'] = this.xref;
    data['name'] = this.name;
    data['image'] = this.image;
    data['mobile'] = this.mobile;
    return data;
  }
}

class QuizQuestion {
  String? questionText;
  String?questionImage;
  String? correctAnswerText;

  QuizQuestion({
    this.questionText, 
    this.questionImage, 
    this.correctAnswerText
  });

  QuizQuestion.fromJson(Map<String, dynamic> json) {
    questionText = json['questionText'];
    questionImage = json['questionImage'];
    correctAnswerText = json['correctAnswerText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionText'] = this.questionText;
    data['questionImage'] = this.questionImage;
    data['correctAnswerText'] = this.correctAnswerText;
    return data;
  }
}