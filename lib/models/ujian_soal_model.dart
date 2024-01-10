class QuizResponse {
  String message;
  List<Question> soal;
  int semester;
  List<Essay> essay;

  QuizResponse({
    required this.message,
    required this.soal,
    required this.semester,
    required this.essay,
  });

  factory QuizResponse.fromJson(final Map<String, dynamic> json) =>
      QuizResponse(
        message: json['message'],
        semester: json['semester'],
        soal: List<Question>.from(
            json['soal'].map((final x) => Question.fromJson(x))),
        essay:
            List<Essay>.from(json['essay'].map((final x) => Essay.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'semester': semester,
        'soal': List<dynamic>.from(soal.map((final x) => x.toJson())),
        'essay': List<dynamic>.from(essay.map((final x) => x.toJson())),
      };
}

class Question {
  String idSoal;
  String soal;
  List<List<String>> pilihan;
  String jawaban;

  Question({
    required this.idSoal,
    required this.soal,
    required this.pilihan,
    required this.jawaban,
  });

  factory Question.fromJson(final Map<String, dynamic> json) => Question(
        idSoal: json['id_soal'],
        soal: json['soal'],
        pilihan: List<List<String>>.from(
            json['pilihan'].map((final x) => List<String>.from(x))),
        jawaban: json['jawaban'],
      );

  Map<String, dynamic> toJson() => {
        'id_soal': idSoal,
        'soal': soal,
        'pilihan':
            List<dynamic>.from(pilihan.map((final x) => List<dynamic>.from(x))),
        'jawaban': jawaban,
      };
}

class Essay {
  String idSoal;
  String soal;
  String jawaban;

  Essay({
    required this.idSoal,
    required this.soal,
    required this.jawaban,
  });

  factory Essay.fromJson(final Map<String, dynamic> json) => Essay(
        idSoal: json['id_soal'],
        soal: json['soal'],
        jawaban: json['jawaban'],
      );

  Map<String, dynamic> toJson() => {
        'id_soal': idSoal,
        'soal': soal,
        'jawaban': jawaban,
      };
}
