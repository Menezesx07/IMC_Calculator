import '../model/input_form.dart';

class InputFormRepository {

  //simulando o banco de dados temporariamente (vai ser usado o hive)
  final List<InputForm> _formInput = [];

  //id é gerado automagicamente
  //é usado o future, pois essa função é chamada com await
  Future <void> addCard(InputForm formInput) async{
    await Future.delayed(const Duration(milliseconds: 200));
    _formInput.add(formInput);
  }

  //retornando todos os cards (chamado ao abrir a tela ou alguma alteração
  Future <List<InputForm>> listCards() async{
    await Future.delayed(const Duration(milliseconds: 100));
    return _formInput;
  }
}