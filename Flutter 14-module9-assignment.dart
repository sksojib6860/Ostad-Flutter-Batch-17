// Problem 1: Student class
class Student {
  String name;
  int roll;

  // Constructor
  Student(this.name, this.roll);

  // Method to display info
  void displayInfo() {
    print("Name: $name, Roll: $roll");
  }
}

void main() {
  // Create Student object
  Student student1 = Student("Rahim", 101);
  student1.displayInfo();

  // Problem 2: Person and Teacher classes
  Person person1 = Person("Karim");
  Teacher teacher1 = Teacher("Hasan", "Mathematics");
  teacher1.displayInfo();

  // Problem 3: Abstract class Shape and Circle subclass
  Circle circle1 = Circle(5.0);
  print("Circle Area: ${circle1.area}");
}

// Problem 2: Person and Teacher classes
class Person {
  String name;

  Person(this.name);
}

class Teacher extends Person {
  String subject;

  Teacher(String name, this.subject) : super(name);

  void displayInfo() {
    print("Name: $name, Subject: $subject");
  }
}

// Problem 3: Abstract class Shape and Circle subclass
abstract class Shape {
  double _area = 0;

  // Abstract method
  void calculateArea();

  // Getter
  double get area => _area;

  // Setter
  set area(double value) {
    _area = value;
  }
}

class Circle extends Shape {
  double radius;

  Circle(this.radius) {
    calculateArea();
  }

  @override
  void calculateArea() {
    area = 3.1416 * radius * radius;
  }
}
