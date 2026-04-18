import 'dart:io';

import '../../core/constants.dart';
import '../../data/database.dart';

void addStudent() {
  stdout.write("Enter student name: ");
  var name = stdin.readLineSync();

  var student = {
    "name": name,
    "scores": <int>[],
    "subjects": {...availableSubjects},
    "bonus": null,
    "comment": null,
  };

  students.add(student);

  print("✅ Student added!");
}
