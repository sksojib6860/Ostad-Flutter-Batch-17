import 'dart:io';

import 'package:student_grader_v1/features/student/add_student.dart';
import 'package:student_grader_v1/features/student/bonus.dart';
import 'package:student_grader_v1/features/student/comment.dart';
import 'package:student_grader_v1/features/student/record_score.dart';
import 'package:student_grader_v1/features/student/view_students.dart';
import 'package:student_grader_v1/menu/menu.dart';
import 'package:student_grader_v1/report/report_card.dart';
import 'package:student_grader_v1/summary/class_summary.dart';

void main() {
  bool running = true;

  do {
    menu();
    stdout.write("Choose: ");
    var choice = stdin.readLineSync();

    switch (choice) {
      case "1":
        addStudent();
        break;
      case "2":
        recordScore();
        break;
      case "3":
        addBonus();
        break;
      case "4":
        addComment();
        break;
      case "5":
        viewStudents();
        break;
      case "6":
        viewReportCard();
        break;
      case "7":
        classSummary();
        break;
      case "8":
        running = false;
        break;
    }
  } while (running);
}
