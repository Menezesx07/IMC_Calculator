import 'package:flutter/material.dart';
import 'package:imc_calculator/model/input_form.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper extends ChangeNotifier {

  //instanciando a função "Database" do package do sqlflite e criando a
  //tabela com base nela (modo de criar simplificado do sqlflite)
  static Future<void> createTables(sql.Database database) async {
    //.execute é a função de criação de tabelas do sqflite
    await database.execute('''
    CREATE TABLE cards (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    weight REAL,
    makeExercise INTEGER,
    mood TEXT,
    date TEXT
    )
  ''');
  }

  //abrindo a conexão com o banco toda vez que for fazer uma operação,
  //caso seja a primeira vez, ele cria o banco.
  //criando uma "lista" com as funções do sqlflite, lembrando que o sql
  //veio do "as sql" no import do package
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      //nome do arquivo que ficam as tabelas
      "dbcards.db",
      //versão do banco, meio que uma "key"
      version: 1,
      //no primeiro acesso, vai criar um novo banco com as instancias
      //da função "createTables" criada logo acima
      onCreate: (sql.Database database, int version) async {
        print("...criando a tabela...");
        await createTables(database);
      }
    );
  }


  //função de Insert no banco
  static Future<int> createItem(InputForm inputForm) async {
    //abrindo a conexão com base na função acima
    final db = await SQLHelper.db();

    //criando o objeto a ser enviado
    final data = {
      "date": inputForm.date,
      "weight": inputForm.weight,
      "makeExercise": inputForm.makeExercise,
      "mood": inputForm.mood
    };
    final id = await db.insert(
      //ele pede o nome da table e os dados a serem inseridos
      "cards",
      data,
      //vai ignorar os arquivos existentes e enviar os novos
      conflictAlgorithm: sql.ConflictAlgorithm.replace);

    //retornando o retorno do insert
    return id;
  }

  //função de retornar todos os itens
  static Future<List<Map<String, dynamic>>> getItens() async {
    //abrindo a conexão com o banco
    final db = await SQLHelper.db();
    //retornando tudo da tabela
    return db.query("cards", orderBy: "id");
  }

  //função de deletar o item
  static Future<void> deleteItem(int id) async {
    //abrindo a conexão com o banco
    final db = await SQLHelper.db();
    try {
      await db.delete("cards", where: "id = ?", whereArgs: [id]);
    } catch (e) {
      print("Erro ao deletar : $e");
    }
  }

  //função de retornar o item escolhido pelo id
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    //abrindo a conexão com o banco
    final db = await SQLHelper.db();
    //retornando o conteudo na tabela com base no id
    //lembrando que o ? no sql, é onde vai a variavel
    return db.query("cards", where: "id = ?", whereArgs: [id], limit: 1);
  }


}