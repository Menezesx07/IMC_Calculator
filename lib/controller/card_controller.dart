import 'package:flutter/material.dart';

class CardController extends ChangeNotifier {

  Color? color;
  Image? image;
  String? imc;
  String? imcType;

  int? id;
  double? weight;
  int? makeExercise;
  String? mood;
  String? date;

  cardDestructuring (cardList) {
    var card = cardList;
    List<Object> cardMap(Map<String, dynamic> card) {
      return [
       id = card['id'] as int,
       weight = card['weight'] as double,
       makeExercise = card['makeExercise'] as int,
       mood = card['mood'] as String,
       date = card['date'] as String,
      ];
    }
    var info = cardMap(card);
    List<dynamic> res = [info[0], info[1], info[2],info[3], info[4]];
    return res;
  }

  getCardElements(weight, height, mood) {
    getUserImc(weight, height, mood);
    getImcColor(imc);
    getImage(mood);
  }

  getUserImc (weight, height, mood) async {
    imc = (weight! / (double.parse(height) * double.parse(height))).toStringAsFixed(2);
    return imc.toString();
  }

  //definindo a cor do card
  Color? getImcColor (imc) {
    double _imc = double.parse(imc);

    if(_imc <= 16.99) {
      color = Colors.redAccent;
      imcType = "Magreza Grave";
    } else if (_imc >= 17 && _imc <= 18.59) {
      color = Colors.yellowAccent[300];
      imcType = "Magreza Leve";
    } else if (_imc >= 18.6 && _imc <= 24.99) {
      color = Colors.greenAccent;
      imcType = "Saudável";
    } else if (_imc >= 25 && _imc <= 29.99) {
      color = Colors.yellow[300];
      imcType = "Sobrepeso";
    } else if (_imc >= 30 && _imc <= 34.99) {
      color = Colors.orangeAccent;
      imcType = "Obesidade Gr. 1";
    } else if (_imc >= 35 && _imc <= 39.99) {
      color = Colors.deepOrangeAccent;
      imcType = "Obesidade Gr. 2";
    } else if (_imc >= 40) {
      color = Colors.red;
      imcType = "Obesidade Gr. 3";
    }
    return color;
  }

  getImage (mood) {

    if(mood == "Cansado") {
      image = Image.asset("assets/images/tired.png");
    } else if (mood == "Mais ou Menos") {
      image = Image.asset("assets/images/neutral.png");
    } else if (mood == "Disposto") {
      image = Image.asset("assets/images/smile.png");
    } else print("error");

    return image;
  }



}