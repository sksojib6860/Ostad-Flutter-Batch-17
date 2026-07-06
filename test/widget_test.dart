import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:module_9_local_db/myapp.dart';

void main() {
  testWidgets('Task App initial UI smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the title / workspace header is displayed
    expect(find.text('Workspace'), findsOneWidget);

    // Verify that the Add Task button exists on screen
    expect(find.text('Add Task'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Verify that the initial loader is shown or empty state is present
    // Since the database initialization is async, the widget starts in a loading state.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
