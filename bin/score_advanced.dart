import 'dart:io';

class Score {
  int score=0;
  void show(){
    print("점수는: $score");
  }
}

class StudentScore extends Score {
   String name='';
    StudentScore(this.name, int score) {
      this.score=score;
    }
    String getResultString(){
      return "이름: $name, 점수: $score 점";
    }

  @override
  void show(){
    print(getResultString());
  }
}

void saveResults(String filepath, String content){
    try{
    final file=File(filepath);
    file.writeAsStringSync(content);
    print("저장 완료");
    } catch(e){
      print("저장 실패 $e");
    }
  }

    // ('result.txt').writeAsStringSync(output);
    // print("파일에 저장 완료되었습니다!");}
    // catch(e){
    //   print("파일 저장 중 오류 발생: $e");}

void main(){
    List<StudentScore>students=[];

  final file = File('students.txt');
  final lines=file.readAsLinesSync();

  for(var line in lines){
    final parts=line.split(',');
    String name=parts[0].trim();
    int score=int.parse(parts[1]);

    students.add(StudentScore(name,score));
    // print("이름: $name, 점수: $score 점");
    
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