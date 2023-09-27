import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:imc_calculator/model/input_form.dart';
import '../database/db_helper.dart';
import '../model/user.dart';
import '../repository/User_repository.dart';
import '../screen/home.dart';

class HomeController extends ChangeNotifier {

  List <Map<String, dynamic>> _cardsList = [];
  List <Map<String, dynamic>> get cardsList => _cardsList;

  String? _name = "loading";
  String? _height = "loading";
  String? get name => _name;
  String? get height => _height;

  //recuperando os cards do bd
  Future<void> getCards() async {
    //retorno da função que o get no bd
    _cardsList = await SQLHelper.getItens();
    notifyListeners();
  }

  //chamando a função responsavel pelo insert
  //essa função dentro do controller é só para usar o notifyListener
  setCard(InputForm inputForm) async {
      SQLHelper.createItem(inputForm);
      await getCards();
  }

  deleteCard(int id, context) async{
    await SQLHelper.deleteItem(id);
    await getCards();
  }

  Future<void> getUserData() async {
    var userData = await UserRepository().getUserData();
    _name = userData[0];
    _height = userData[1];
  }

  //recebendo os dados via parametro e salvando na box do hive
  setUser (User user, context) async {

    var box = await getHiveData();

    box.put(1, user.name);
    box.put(2, user.height?.toStringAsFixed(2));

    getUserData();

    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => homeScreen()),
    );

    return false;
  }

  //instanciando as funções e dados da box de User do hive
  getHiveData () async {
    final userBox = Hive.box("user");
    return userBox;
  }


}