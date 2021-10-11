import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/app.dart';

import 'mock_todo_service.dart';

void main() {
  Future<void> initApp(WidgetTester tester) async {
    await tester.pumpWidget(TodosApp(
      service: MockTodoService(),
    ));
    await tester.pumpAndSettle();
  }

  group('Todo Widget Tests', () {
    testWidgets('Add Todo Test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await initApp(tester);
      await tester.enterText(find.byType(TextField), 'sample todo');
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      await tester.drag(
        find.byKey(const ValueKey<int>(3)),
        const Offset(50, -500),
      );
      await tester.pump();
      expect(
        find.byKey(const ValueKey<int>(11)),
        findsOneWidget,
      );
    });
  });
}
