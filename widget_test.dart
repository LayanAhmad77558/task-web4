import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('VoiceBot initial UI test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('Click to talk '), findsOneWidget);
    expect(find.byIcon(Icons.mic_none), findsOneWidget);
  });
}
