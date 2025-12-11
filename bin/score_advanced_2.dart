import 'dart:io';
import 'dart:convert';

class Score { //부모 class인 Score 지정
  List<int> scores = [];

  Score([this.scores = const []]);
 
  double get average => scores.isNotEmpty  // 평균 점수 계산
      ? scores.reduce((a, b) => a + b) / scores.length
      : 0.0;

  void show() {
    print("점수: ${scores.join(', ')}"); //점수 출력
  }
}

class StudentScore extends Score { // 자식 클래스 StudentScore: 이름과 점수를 포함하여 구체적 정보 출력
  String name;

  StudentScore(this.name, List<int> scores) : super(scores);

  @override
  void show() {
    print('이름: $name, 점수: ${scores.join(', ')}, 평균: ${average.toStringAsFixed(1)}'); // 학생 이름과 평균 점수 출력
  }
}

Future<void> main() async {
  final file = File('students.txt');

  if (!await file.exists()) {
    print('students.txt 파일이 없습니다.');
    return;
  }

  final lines = await file.readAsLines(encoding: utf8);
  List<StudentScore> students = [];

  // 파일에서 학생 데이터 읽기
  for (var line in lines) {
    var parts = line.split(',').map((e) => e.trim()).toList();
    if (parts.length >= 4) {
      String name = parts[0];
      List<int> scores = parts.sublist(1).map(int.parse).toList();
      students.add(StudentScore(name, scores));
    }
  }

  if (students.isEmpty) {
    print('학생 데이터가 없습니다.');
    return;
  }

  print('원하는 기능을 선택하세요:');
  print('1: 우수생 보기');
  print('2: 전체 평균 점수 보기');

  String? input = stdin.readLineSync();

  if (input == '1') {
    // 평균 기준 내림차순 정렬 후 우수생 출력
    students.sort((a, b) => b.average.compareTo(a.average));
    var topStudent = students.first;
    print('우수생: ${topStudent.name} (평균 점수: ${topStudent.average.toStringAsFixed(1)})');
  } else if (input == '2') {
    // 전체 평균 점수 계산
    double totalAverage =
        students.map((s) => s.average).reduce((a, b) => a + b) / students.length;
    print('전체 평균 점수: ${totalAverage.toStringAsFixed(1)}');
  } else {
    print('잘못된 입력입니다. 1 또는 2를 입력하세요.');
  }
}
