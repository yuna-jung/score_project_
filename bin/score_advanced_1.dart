import 'dart:io';

class Score { //부모 class인 Score 지정
  int score=0;
  void show(){ //점수를 출력하는 기본 메서드
    print("점수는: $score");
  }
}

class StudentScore extends Score { //클래스를 상속받아 학생 점수 클래스 정의
   String name='';

    StudentScore(this.name, int score) { //학생 정보와 점수를 문자열로 반환하는 메서드
      this.score=score;
    }
    String getResultString(){
      return "이름: $name, 점수: $score 점";
    }

  @override //Score 클래스의 show 메서드를 재정의
  void show(){
    print(getResultString());
  }
}

void saveResults(String filepath, String content){ //파일에 문자열을 저장하는 함수
    try{
    final file=File(filepath); //저장할 파일 객체 생성
    file.writeAsStringSync(content); //content 내용을 파일에 동기적으로 작성
    print("저장 완료");
    } catch(e){
      print("저장 실패 $e"); // 오류 발생 시 메시지 출력
    }
  }

void main(){
    List<StudentScore>students=[]; //학생 정보를 저장할 리스트 생성

  final file = File('students.txt');
  final lines=file.readAsLinesSync(); //파일 내용을 줄 단위로 읽어 리스트로 반환

  for(var line in lines){
    final parts=line.split(','); //이름과 점수를 분리
    String name=parts[0].trim(); //이름 부분 추출 후 공백 제거
    int score=int.parse(parts[1]);

    students.add(StudentScore(name,score));
    
  }
  while(true){
    print("어떤 학생의 통계를 확인하시겠습니까");
    String? input=stdin.readLineSync()?.trim();

    if(input != null){
      StudentScore? foundStudent;
      for(var student in students){
        if(student.name==input){
          foundStudent=student;
          break;
        }
      }
      if(foundStudent !=null){
        foundStudent.show();
         saveResults('result.txt', foundStudent.getResultString());
        break;
      }else{
        print("잘못된 학생 이름을 입력하셨습니다. 다시 입력해주세요.");
      }
    }
  }
}