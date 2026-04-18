import 'dart:io';

import '../../data/database.dart';

void addBonus() {
  for (int i = 0; i < students.length; i++) {
    print("${i + 1}. ${students[i]["name"]}");
  }

  int index = int.parse(stdin.readLineSync()!) - 1;
  var student = students[index];

  int bonus = int.parse(stdin.readLineSync()!);

  if (student["bonus"] == null) {
    student["bonus"] ??= bonus;
    print("Bonus added");
  } else {
    print("Already has bonus");
  }
}
