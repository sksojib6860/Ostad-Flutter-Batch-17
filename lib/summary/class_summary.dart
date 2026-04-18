import '../../core/utils.dart';
import '../data/database.dart';

void classSummary() {
  double total = 0;

  for (var s in students) {
    total += calculateAverage(s);
  }

  double avg = total / students.length;

  print("Class Average: $avg");
}
