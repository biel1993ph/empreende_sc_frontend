import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:empreende_sc_frontend/screens/empreendimento_form_page.dart';

Finder _textFormFieldAt(int index) => find.byType(TextFormField).at(index);

void main() {
  Future<void> _pumpForm(WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: EmpreendimentoFormPage()));
  }

  Future<void> _preencherCamposObrigatorios(WidgetTester tester) async {
    await tester.enterText(_textFormFieldAt(0), 'Minha Empresa');
    await tester.enterText(_textFormFieldAt(1), 'João da Silva');
    await tester.enterText(_textFormFieldAt(2), 'Florianópolis');

    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tecnologia').last);
    await tester.pumpAndSettle();
  }

  testWidgets('exibe validações de campos obrigatórios ao salvar vazio', (
    WidgetTester tester,
  ) async {
    await _pumpForm(tester);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Salvar'));
    await tester.pumpAndSettle();

    expect(find.text('Campo obrigatório.'), findsNWidgets(4));
  });

  testWidgets('exibe erro para e-mail inválido', (WidgetTester tester) async {
    await _pumpForm(tester);
    await _preencherCamposObrigatorios(tester);

    await tester.enterText(_textFormFieldAt(3), 'email-invalido');

    await tester.tap(find.widgetWithText(ElevatedButton, 'Salvar'));
    await tester.pumpAndSettle();

    expect(find.text('Informe um e-mail válido.'), findsOneWidget);
  });

  testWidgets('limita nome do empreendimento a 255 caracteres', (
    WidgetTester tester,
  ) async {
    await _pumpForm(tester);

    final textoMuitoLongo = 'a' * 300;
    final textoLimitado = 'a' * 255;

    await tester.enterText(_textFormFieldAt(0), textoMuitoLongo);
    await tester.pumpAndSettle();

    expect(find.text(textoLimitado), findsOneWidget);
    expect(find.text(textoMuitoLongo), findsNothing);
  });
}
