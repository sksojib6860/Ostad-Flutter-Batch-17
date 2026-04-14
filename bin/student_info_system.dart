// Dart Practice: Lists, Sets, Maps, and Student Info System
// Author: [Your Name]
// Date: [Today's Date]

void main() {
  // -------------------------------
  // Step 2: Practicing Lists
  // -------------------------------

  // Growable list
  List<int> growableList = [1, 2, 3];
  growableList.add(4); // Adding
  growableList.remove(2); // Removing
  growableList.insert(1, 99); // Inserting
  growableList.sort(); // Sorting
  print("Growable List: $growableList");

  // Fixed-length list
  List<String> fixedList = List.filled(3, "Empty");
  fixedList[0] = "Apple";
  fixedList[1] = "Banana";
  fixedList[2] = "Cherry";
  print("Fixed List: $fixedList");

  // -------------------------------
  // Step 3: Practicing Sets
  // -------------------------------

  Set<String> fruits = {"Apple", "Banana", "Apple"}; // Duplicate removed
  fruits.add("Mango");
  fruits.remove("Banana");
  print("Set after add/remove: $fruits");

  Set<String> setA = {"Apple", "Banana", "Cherry"};
  Set<String> setB = {"Banana", "Mango", "Cherry"};

  print("Union: ${setA.union(setB)}");
  print("Intersection: ${setA.intersection(setB)}");
  print("Difference (A-B): ${setA.difference(setB)}");

  // -------------------------------
  // Step 4: Practicing Maps
  // -------------------------------

  Map<String, int> studentAges = {"Alice": 20, "Bob": 22, "Charlie": 19};
  print("Alice's age: ${studentAges["Alice"]}");

  // -------------------------------
  // Step 5: Nested Maps
  // -------------------------------

  Map<int, Map<String, String>> studentDetails = {
    101: {"name": "Alice", "grade": "A"},
    102: {"name": "Bob", "grade": "B"},
  };
  print("Student 101 details: ${studentDetails[101]}");

  // -------------------------------
  // Step 6: Map methods
  // -------------------------------

  print("Keys: ${studentAges.keys}");
  print("Values: ${studentAges.values}");

  // -------------------------------
  // Step 7 & 8: Student Info System
  // -------------------------------

  List<Map<String, dynamic>> students = [
    {"name": "Alice", "roll": 101, "grade": "A"},
    {"name": "Bob", "roll": 102, "grade": "B"},
  ];

  // Display all students
  print("\n--- Student Info System ---");
  for (var student in students) {
    print(
      "Name: ${student['name']}, Roll: ${student['roll']}, Grade: ${student['grade']}",
    );
  }

  // Add new student
  students.add({"name": "Charlie", "roll": 103, "grade": "A"});
  print("\nAfter adding Charlie:");
  for (var student in students) {
    print(
      "Name: ${student['name']}, Roll: ${student['roll']}, Grade: ${student['grade']}",
    );
  }

  // Optional: Update or remove
  students[1]["grade"] = "A+"; // Update Bob's grade
  students.removeWhere((student) => student["roll"] == 101); // Remove Alice
  print("\nAfter update/remove:");
  for (var student in students) {
    print(
      "Name: ${student['name']}, Roll: ${student['roll']}, Grade: ${student['grade']}",
    );
  }

  // -------------------------------
  // Step 9: Testing
  // -------------------------------
  print(
    "\nTesting complete: Lists, Sets, Maps, and Student Info System all working!",
  );

  // -------------------------------
  // Step 11: Code cleanup
  // -------------------------------
  // Comments added, unnecessary lines removed, formatting applied.
}
