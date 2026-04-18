import 'dart:io';

import '../core/utils.dart';
import '../data/database.dart';

void viewReportCard() {
  for (int i = 0; i < students.length; i++) {
    print("${i + 1}. ${students[i]["name"]}");
  }

  int index = int.parse(stdin.readLineSync()!) - 1;

  var s = students[index];

  double avg = calculateAverage(s);
  String grade = getGrade(avg);

  String comment = s["comment"]?.toUpperCase() ?? "No comment";
  print("""
╔═══════════════════════════════════╗
║              REPORT CARD          ║
╠═══════════════════════════════════╝
║ Name: ${s["name"]}                ║
║ Scores: ${s["scores"]}            ║
║ Bonus: +${s["bonus"] ?? 0}        ║
║ Average: ${avg.toStringAsFixed(1)}║
║ Grade: $grade                     ║
║ Comment: $comment                 ║
╚═══════════════════════════════════╝
""");
}
