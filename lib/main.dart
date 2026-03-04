import 'package:flutter/material.dart';
import 'package:empreende_sc_frontend/data/empreendimento_database.dart';
import 'package:empreende_sc_frontend/models/empreendimento.dart';
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
  bool _isLoading = true;
  List<Empreendimento> _empreendimentos = const [];
  String? _erroCarregamento;

  @override
  void initState() {
    super.initState();
    _loadEmpreendimentos();
  }

  Future<void> _loadEmpreendimentos() async {
    try {
      final empreendimentos = await EmpreendimentoDatabase.instance
          .getEmpreendimentos();
      if (!mounted) {
        return;
      }
      setState(() {
        _empreendimentos = empreendimentos;
        _erroCarregamento = null;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _empreendimentos = const [];
        _erroCarregamento =
            'Não foi possível carregar os empreendimentos neste ambiente.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _erroCarregamento != null
          ? Center(child: Text(_erroCarregamento!))
          : _empreendimentos.isEmpty
          ? const Center(
              child: Text('Nenhum empreendimento salvo até o momento.'),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _empreendimentos.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = _empreendimentos[index];

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.nomeEmpreendimento,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text('Responsável: ${item.nomeResponsavel}'),
                        Text('Município: ${item.municipio}'),
                        Text('Segmento: ${item.segmento}'),
                        Text('Contato: ${item.contato}'),
                        Text(
                          'Status: ${item.statusAtivo ? 'Ativo' : 'Inativo'}',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const EmpreendimentoFormPage(),
            ),
          );
          await _loadEmpreendimentos();
        },
        tooltip: 'Novo cadastro',
        child: const Icon(Icons.add),
      ),
    );
  }
}
