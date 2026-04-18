import 'dart:io';

import '../../data/database.dart';

void recordScore() {
  if (students.isEmpty) return;

  for (int i = 0; i < students.length; i++) {
    print("${i + 1}. ${students[i]["name"]}");
  }

  int index = int.parse(stdin.readLineSync()!) - 1;
  var student = students[index];

  int score;
  while (true) {
    stdout.write("Enter score: ");
    score = int.parse(stdin.readLineSync()!);

    if (score >= 0 && score <= 100) break;
  }

  student["scores"].add(score);
}
