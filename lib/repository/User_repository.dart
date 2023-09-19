import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:imc_calculator/model/user.dart';
import '../screen/home.dart';
import '../screen/new_user.dart';


class UserRepository {

  //instanciando as funções e dados da box de User do hive
  getHiveData () async {
    final userBox = Hive.box("user");
    return userBox;
  }

  //conferindo se o usuario já utilizou o app com base no status da altura
  getUserToLogin (context) async {
      //instanciando o retorno do hive dessa função
      var newUserBox = await getHiveData();

      if(newUserBox.get(1) == null && newUserBox.get(2) == null ) {
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => newUserScreen()),
        );
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => homeScreen())
        );
      }
  }

  //retorna os dados de nome e altura do usuario
  getUserData () async {

    //instanciando o OpenBox do hive
    var userBox = await getHiveData();

    //resgatando os dados, não sei o motivo mas
    //  o hive tá transformando o height em String
    String name = await userBox.get(1);
    String height = await userBox.get(2);

    //jogando no array para facilitar extração
    var userData = [name, height];

    return userData;

  }


  //recebendo os dados via parametro e salvando na box do hive
  setUser (User user, context) async {

    var box = await getHiveData();

    box.put(1, user.name);
    box.put(2, user.height?.toStringAsFixed(2));

      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => homeScreen()),
      );

  }


}