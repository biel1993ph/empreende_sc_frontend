// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:empreende_sc_frontend/main.dart';

void main() {
  testWidgets('abre tela de formulário ao tocar no botão +', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('EMPREENDEDORISMO SC'), findsOneWidget);
    expect(find.text('Novo Empreendimento'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.text('Novo Empreendimento'), findsOneWidget);
    expect(find.text('Nome do empreendimento'), findsOneWidget);
    expect(find.text('Segmento de atuação'), findsOneWidget);
  });
}
