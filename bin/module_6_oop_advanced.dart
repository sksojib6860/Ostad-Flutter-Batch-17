import 'dart:io';

/// ============================================================================
/// Module 6 Assignment – Advanced OOP Concepts Practice & Bank Account System
/// ============================================================================

// --- Step 2: Encapsulation ---
class Person {
  String _name; // Private variable
  int _age; // Private variable

  Person(this._name, this._age);

  // Public getters
  String get name => _name;
  int get age => _age;

  // Public setters with validation
  set age(int value) {
    if (value > 0) {
      _age = value;
    } else {
      print('Error: Age must be positive!');
    }
  }

  set name(String value) {
    if (value.isNotEmpty) {
      _name = value;
    } else {
      print('Error: Name cannot be empty!');
    }
  }
}

// --- Step 3: Static Variables and Methods ---
class ObjectCounter {
  static int _count = 0; // Static variable shared among all objects

  ObjectCounter() {
    _count++;
  }

  // Static method that can be called without creating an object
  static int get count => _count;

  static void reset() => _count = 0;
}

// --- Step 4 & 5: Factory Constructors & Singleton Pattern ---
class BankService {
  // Step 5: Singleton - Only one instance can exist
  static BankService? _instance;

  // Private constructor
  BankService._internal();

  // Step 4: Factory constructor
  // Useful to control instance creation, return cached instances, or subtypes.
  factory BankService() {
    _instance ??= BankService._internal();
    return _instance!;
  }

  void logTransaction(String message) {
    print('[BankService Log]: $message');
  }
}

// --- Step 6: Mixins for Code Reuse ---
mixin LoggerMixin {
  void log(String msg) => print('LOG: $msg');
}

mixin TransactionValidator {
  bool validateAmount(double amount) {
    return amount > 0;
  }
}

// --- Step 7: Extensions ---
extension StringFormatting on String {
  String get capitalize =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : this;
}

extension NumberValidation on double {
  bool get isPositive => this > 0;
}

// --- Step 8: Operator Overloading ---
class Point {
  final int x, y;
  Point(this.x, this.y);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Point && other.x == x && other.y == y;
  }

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  String toString() => 'Point(x: $x, y: $y)';
}

// --- Step 9: Copy Constructor Concept ---
class Product {
  String name;
  double price;

  Product(this.name, this.price);

  // Copy constructor: Takes another object and copies its values
  Product.from(Product other) : name = other.name, price = other.price;

  @override
  String toString() => 'Product: $name, Price: \$$price';
}

// --- Step 12: Implementing the Bank Account System ---
class BankAccount with TransactionValidator, LoggerMixin {
  final String accountNumber;
  double _balance; // Private balance (Encapsulation)

  BankAccount(this.accountNumber, this._balance);

  // Getter for balance
  double get balance => _balance;

  // Deposit method with validation
  void deposit(double amount) {
    if (validateAmount(amount)) {
      _balance += amount;
      log(
        'Deposited \$${amount.toStringAsFixed(2)}. New Balance: \$${_balance.toStringAsFixed(2)}',
      );
    } else {
      print('Error: Invalid deposit amount.');
    }
  }

  // Withdraw method with validation
  void withdraw(double amount) {
    if (!validateAmount(amount)) {
      print('Error: Invalid withdrawal amount.');
      return;
    }
    if (amount > _balance) {
      print(
        'Error: Insufficient funds! Current balance: \$${_balance.toStringAsFixed(2)}',
      );
    } else {
      _balance -= amount;
      log(
        'Withdrew \$${amount.toStringAsFixed(2)}. Remaining Balance: \$${_balance.toStringAsFixed(2)}',
      );
    }
  }

  void display() {
    print(
      'Account [$accountNumber] - Balance: \$${_balance.toStringAsFixed(2)}',
    );
  }
}

// --- Step 10: Class Composition ---
class Customer {
  String name;
  BankAccount account; // Composition: Customer "has-a" BankAccount

  Customer(this.name, this.account);

  void showProfile() {
    print('\nCustomer: ${name.capitalize}');
    account.display();
  }
}

/// ============================================================================
/// MAIN APPLICATION LOGIC
/// ============================================================================

void runConceptDemos() {
  print('--- Section 1: OOP Concepts Demonstration ---');

  // Step 2 Demo
  var p = Person('Alice', 20);
  p.age = -5; // Validation trigger
  print('Person: ${p.name}, Age: ${p.age}');

  // Step 3 Demo
  ObjectCounter();
  ObjectCounter();
  print('Objects Created (Static): ${ObjectCounter.count}');

  // Step 4 & 5 Demo
  var s1 = BankService();
  var s2 = BankService();
  print('Singleton Check (s1 == s2): ${identical(s1, s2)}');

  // Step 8 Demo
  var pt1 = Point(1, 2);
  var pt2 = Point(1, 2);
  print('Operator Overloading (pt1 == pt2): ${pt1 == pt2}');
  print('ToString Overloading: $pt1');

  // Step 9 Demo
  var prod1 = Product('Coffee', 5.0);
  var prod2 = Product.from(prod1);
  prod2.name = 'Latte';
  print('Original: $prod1 | Copy: $prod2');

  print('\n--------------------------------------------\n');
}

void main() {
  // Step 14: Review - Run demos first
  runConceptDemos();

  // Step 11 & 13: Interactive Bank Account System Testing
  print('--- Section 2: Interactive Bank System ---');

  final List<Customer> customers = [];
  bool running = true;

  while (running) {
    print('\n[BANK MANAGEMENT SYSTEM]');
    print('1. Create Customer Account');
    print('2. Deposit');
    print('3. Withdraw');
    print('4. Show Balance');
    print('5. Exit');
    stdout.write('Select Option: ');

    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write('Enter Customer Name: ');
        String name = stdin.readLineSync() ?? 'User';
        stdout.write('Enter Account Number: ');
        String accNo = stdin.readLineSync() ?? '000';
        stdout.write('Enter Initial Balance: ');
        double initial = double.tryParse(stdin.readLineSync() ?? '0') ?? 0.0;

        var newAccount = BankAccount(accNo, initial);
        customers.add(Customer(name, newAccount));
        print('Success: Account created for $name.');
        break;

      case '2':
        var customer = _selectCustomer(customers);
        if (customer != null) {
          stdout.write('Enter Deposit Amount: ');
          double amount = double.tryParse(stdin.readLineSync() ?? '0') ?? 0.0;
          customer.account.deposit(amount);
        }
        break;

      case '3':
        var customer = _selectCustomer(customers);
        if (customer != null) {
          stdout.write('Enter Withdrawal Amount: ');
          double amount = double.tryParse(stdin.readLineSync() ?? '0') ?? 0.0;
          customer.account.withdraw(amount);
        }
        break;

      case '4':
        var customer = _selectCustomer(customers);
        if (customer != null) {
          customer.showProfile();
        }
        break;

      case '5':
        print('Exiting... Goodbye!');
        running = false;
        break;

      default:
        print('Invalid Choice. Try again.');
    }
  }
}

Customer? _selectCustomer(List<Customer> list) {
  if (list.isEmpty) {
    print('No customers registered.');
    return null;
  }
  print('\nSelect Customer:');
  for (int i = 0; i < list.length; i++) {
    print('${i + 1}. ${list[i].name} (${list[i].account.accountNumber})');
  }
  stdout.write('Enter Choice (1-${list.length}): ');
  int idx = (int.tryParse(stdin.readLineSync() ?? '0') ?? 0) - 1;

  if (idx >= 0 && idx < list.length) {
    return list[idx];
  } else {
    print('Invalid Selection.');
    return null;
  }
}
