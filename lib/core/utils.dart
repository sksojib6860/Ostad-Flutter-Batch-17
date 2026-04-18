double calculateAverage(Map<String, dynamic> student) {
  final List scores = student["scores"] ?? [];

  if (scores.isEmpty) return 0;

  double sum = 0;
  for (var s in scores) {
    sum += (s as num);
  }

  double avg = sum / scores.length;
  avg += (student["bonus"] ?? 0);

  return avg > 100 ? 100 : avg;
}

String getGrade(double avg) {
  if (avg >= 90) {
    return "A";
  } else if (avg >= 80) {
    return "B";
  } else if (avg >= 70) {
    return "C";
  } else if (avg >= 60) {
    return "D";
  } else {
    return "F";
  }
}
