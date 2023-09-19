import '../model/input_form.dart';

class InputFormRepository {

  //simulando o banco de dados temporariamente (vai ser usado o hive)
  final List<InputForm> _formInput = [];


  setInput (InputForm inputForm) async {

    print(inputForm.mood);
  }

}