import 'package:flutter/material.dart';
import 'package:empreende_sc_frontend/screens/empreendimento_form_page.dart';

const Color santaCatarinaRed = Color(0xFFC8102E);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Empreendedorismo SC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: santaCatarinaRed),
        appBarTheme: const AppBarTheme(
          backgroundColor: santaCatarinaRed,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: santaCatarinaRed,
          foregroundColor: Colors.white,
        ),
      ),
      home: const MyHomePage(title: 'EMPREENDEDORISMO SC'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.business, size: 56, color: santaCatarinaRed),
            SizedBox(height: 12),
            Text(
              'Cadastre um empreendimento',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 6),
            Text('Toque no botão + para abrir o formulário.'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const EmpreendimentoFormPage(),
            ),
          );
        },
        tooltip: 'Novo cadastro',
        child: const Icon(Icons.add),
      ),
    );
  }
}
