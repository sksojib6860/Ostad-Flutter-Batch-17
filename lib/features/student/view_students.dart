import '../../data/database.dart';

void viewStudents() {
  for (var s in students) {
    var tags = [
      s["name"],
      "${s["scores"].length} scores",
      if (s["bonus"] != null) "⭐ Bonus",
    ];

    print(tags.join(" | "));
  }
}
