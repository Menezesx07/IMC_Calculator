import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:imc_calculator/controller/card_controller.dart';
import 'package:imc_calculator/screen/detail_screen.dart';
import '../controller/home_controller.dart';

class cardHome extends StatefulWidget {
  const cardHome({super.key, required this.cardList, this.height});

  final cardList;
  final height;

  @override
  State<cardHome> createState() => _cardHomeState();
}

class _cardHomeState extends State<cardHome> {

  //criando um controller para a home recarregar os cards
  final homeController = HomeController();
  final cardController = CardController();

  int? _id;
  double? _weight;
  int? _makeExercise;
  String? _mood;
  String? date;
  String? get imc => cardController.imc;
  Color? get cardColor => cardController.color;
  Image? get cardImage => cardController.image;
  String? get imcType => cardController.imcType;

  @override
  void initState() {
    // TODO: implement initState
    // _getUserImage();
    _getCardInfo();
    getCardElements();
    super.initState();
  }

  //processando o calculo do imc, cor do Tile e icone
  getCardElements() {
    cardController.getCardElements(_weight, widget.height, _mood);
    setState(() { });
  }

  //não foi possivel puxar os dados direto do controller pois dava problema nos widgets
  void _getCardInfo () {
  List<dynamic> res = cardController.cardDestructuring(widget.cardList);
    setState(() {
      _id = res[0];
      _weight = res[1];
      _makeExercise = res[2];
      _mood = res[3];
      date = res[4];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Material(
        child: ListTile(
          //leading: cardImage,
          title:  Row(
            children: [
              Text("$imc", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              Text(" imc - $imcType", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
          subtitle: Text("$_weight kg", style: const TextStyle( fontWeight: FontWeight.bold)),
          trailing: Text("$date", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          tileColor: cardColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),

          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) =>
                   detailScreen(
                     date: date,
                     mood: _mood,
                     makeExercise: _makeExercise,
                     weight: _weight,
                     color: cardColor,
                     imc: imc,
                     id: _id,
                   ))
            );
          },

        ),
      ),
    );
  }
}
