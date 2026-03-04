import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:empreende_sc_frontend/data/sc_municipios.dart';

class EmpreendimentoFormPage extends StatefulWidget {
  const EmpreendimentoFormPage({super.key});

  @override
  State<EmpreendimentoFormPage> createState() => _EmpreendimentoFormPageState();
}

class _EmpreendimentoFormPageState extends State<EmpreendimentoFormPage> {
  static const int _maxFieldLength = 255;

  final _formKey = GlobalKey<FormState>();

  final _nomeEmpreendimentoController = TextEditingController();
  final _nomeResponsavelController = TextEditingController();
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

  String _normalizeText(String value) {
    const from = 'áàâãäéèêëíìîïóòôõöúùûüçÁÀÂÃÄÉÈÊËÍÌÎÏÓÒÔÕÖÚÙÛÜÇ';
    const to = 'aaaaaeeeeiiiiooooouuuucAAAAAEEEEIIIIOOOOOUUUUC';
    var normalized = value;
    for (var index = 0; index < from.length; index++) {
      normalized = normalized.replaceAll(from[index], to[index]);
    }
    return normalized.toLowerCase().trim();
  }

  String? _maxLengthValidator(String? value) {
    if (value != null && value.length > _maxFieldLength) {
      return 'Máximo de $_maxFieldLength caracteres.';
    }
    return null;
  }

  String? _emailValidator(String? value) {
    final maxLengthError = _maxLengthValidator(value);
    if (maxLengthError != null) {
      return maxLengthError;
    }

    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final email = value.trim();
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

    if (!emailRegex.hasMatch(email)) {
      return 'Informe um e-mail válido.';
    }

    return null;
  }

  @override
  void dispose() {
    _nomeEmpreendimentoController.dispose();
    _nomeResponsavelController.dispose();
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
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(_maxFieldLength),
                  ],
                  validator: _maxLengthValidator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    labelText: 'Nome do empreendimento',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _nomeResponsavelController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(_maxFieldLength),
                  ],
                  validator: _maxLengthValidator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    labelText: 'Nome do(a) empreendedor(a) responsável',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    final query = _normalizeText(textEditingValue.text);

                    if (query.isEmpty) {
                      return const Iterable<String>.empty();
                    }

                    return scMunicipios
                        .where((municipio) {
                          return _normalizeText(municipio).contains(query);
                        })
                        .take(20);
                  },
                  fieldViewBuilder:
                      (
                        context,
                        textEditingController,
                        focusNode,
                        onFieldSubmitted,
                      ) {
                        return TextFormField(
                          controller: textEditingController,
                          focusNode: focusNode,
                          decoration: const InputDecoration(
                            labelText: 'Município de Santa Catarina',
                            border: OutlineInputBorder(),
                          ),
                        );
                      },
                  optionsViewBuilder: (context, onSelected, options) => Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      elevation: 4,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxHeight: 240),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 32,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: options.length,
                            itemBuilder: (context, index) {
                              final option = options.elementAt(index);
                              return ListTile(
                                title: Text(option),
                                onTap: () => onSelected(option),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
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
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(_maxFieldLength),
                  ],
                  validator: _emailValidator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
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
