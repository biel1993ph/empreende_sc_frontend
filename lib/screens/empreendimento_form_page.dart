import 'package:flutter/material.dart';

class EmpreendimentoFormPage extends StatefulWidget {
  const EmpreendimentoFormPage({super.key});

  @override
  State<EmpreendimentoFormPage> createState() => _EmpreendimentoFormPageState();
}

class _EmpreendimentoFormPageState extends State<EmpreendimentoFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _nomeEmpreendimentoController = TextEditingController();
  final _nomeResponsavelController = TextEditingController();
  final _municipioController = TextEditingController();
  final _contatoController = TextEditingController();

  static const List<String> _segmentos = [
    'Tecnologia',
    'Comércio',
    'Indústria',
    'Serviços',
    'Agronegócio',
  ];

  String? _segmentoSelecionado;
  bool _statusAtivo = true;

  @override
  void dispose() {
    _nomeEmpreendimentoController.dispose();
    _nomeResponsavelController.dispose();
    _municipioController.dispose();
    _contatoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Novo Empreendimento',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nomeEmpreendimentoController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do empreendimento',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _nomeResponsavelController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do(a) empreendedor(a) responsável',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _municipioController,
                  decoration: const InputDecoration(
                    labelText: 'Município de Santa Catarina',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: _segmentoSelecionado,
                  decoration: const InputDecoration(
                    labelText: 'Segmento de atuação',
                    border: OutlineInputBorder(),
                  ),
                  items: _segmentos
                      .map(
                        (segmento) => DropdownMenuItem<String>(
                          value: segmento,
                          child: Text(segmento),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _segmentoSelecionado = value;
                    });
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _contatoController,
                  decoration: const InputDecoration(
                    labelText: 'E-mail ou meio de contato',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  value: _statusAtivo,
                  onChanged: (value) {
                    setState(() {
                      _statusAtivo = value ?? false;
                    });
                  },
                  title: Text('Status: ${_statusAtivo ? 'Ativo' : 'Inativo'}'),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
