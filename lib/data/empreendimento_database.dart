import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:empreende_sc_frontend/models/empreendimento.dart';

class EmpreendimentoDatabase {
  EmpreendimentoDatabase._();

  static final EmpreendimentoDatabase instance = EmpreendimentoDatabase._();

  static const _databaseName = 'empreendimentos.db';
  static const _databaseVersion = 1;
  static const _tableName = 'empreendimentos';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    return openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome_empreendimento TEXT NOT NULL,
            nome_responsavel TEXT NOT NULL,
            municipio TEXT NOT NULL,
            segmento TEXT NOT NULL,
            contato TEXT NOT NULL,
            status_ativo INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> insertEmpreendimento(Empreendimento empreendimento) async {
    final db = await database;
    return db.insert(_tableName, empreendimento.toMap());
  }

  Future<int> updateEmpreendimento(Empreendimento empreendimento) async {
    final db = await database;

    return db.update(
      _tableName,
      empreendimento.toMap(),
      where: 'id = ?',
      whereArgs: [empreendimento.id],
    );
  }

  Future<List<Empreendimento>> getEmpreendimentos() async {
    final db = await database;
    final result = await db.query(_tableName, orderBy: 'id DESC');

    return result.map(Empreendimento.fromMap).toList();
  }
}
