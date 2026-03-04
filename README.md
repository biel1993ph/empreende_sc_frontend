# Empreende SC Frontend

## Descrição da solução desenvolvida

Este projeto é uma aplicação Flutter (Android e iOS) para cadastro e gestão de empreendimentos de Santa Catarina.

A solução permite:

- cadastrar empreendimentos com os campos de negócio definidos;
- listar os empreendimentos salvos na tela inicial;
- editar um registro ao clicar em uma célula da listagem;
- excluir registros com confirmação;
- validar dados do formulário (obrigatoriedade, limite de caracteres e formato de e-mail);
- selecionar município com autocomplete a partir de uma lista de municípios de SC.

Os dados são persistidos localmente em SQLite.

## Tecnologias utilizadas

- Flutter (Dart)
- SQLite com `sqflite`
- `path` para manipulação de caminho do banco
- Testes com `flutter_test`

## Estrutura geral do projeto

Estrutura principal:

```text
lib/
	main.dart                          # Tela inicial com listagem dos dados
	data/
		empreendimento_database.dart     # Acesso ao SQLite (insert, update, delete, query)
		sc_municipios.dart               # Lista de municípios de Santa Catarina
	models/
		empreendimento.dart              # Modelo de dados do empreendimento
	screens/
		empreendimento_form_page.dart    # Formulário de cadastro/edição

test/
	widget_test.dart                   # Teste de navegação da home para formulário
	screens/
		empreendimento_form_page_test.dart # Testes de validação do formulário
```

## Instruções para execução

### Pré-requisitos

- Flutter SDK instalado
- Dispositivo/emulador configurado (Android ou iOS)

### Passos

1. Instale as dependências:

```bash
flutter pub get
```

2. Execute o projeto:

```bash
flutter run
```

3. (Opcional) Rode os testes:

```bash
flutter test
```

### Observações

- O banco SQLite é criado automaticamente na primeira execução.
- A listagem inicial é recarregada após criar, editar ou excluir um empreendimento.

