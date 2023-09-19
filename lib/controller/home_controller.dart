

import '../database/db_helper.dart';

class HomeController {

  List <Map<String, dynamic>> cardsList = [];

  bool isLoading = true;

  //recuperando os cards do bd
  getCards() async {
    //retorno da função que o get no bd
    final data = await SQLHelper.getItens();
      cardsList = data;
      isLoading = false;
      print("...numero de itens ${cardsList.length}");
  }

}