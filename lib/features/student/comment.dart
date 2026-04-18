import 'dart:io';

import '../../data/database.dart';

void addComment() {
  for (int i = 0; i < students.length; i++) {
    print("${i + 1}. ${students[i]["name"]}");
  }

  int index = int.parse(stdin.readLineSync()!) - 1;

  stdout.write("Enter comment: ");
  String comment = stdin.readLineSync()!;

  students[index]["comment"] = comment;
}
