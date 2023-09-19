

class InputForm  {

  String? _date;
  double? _weight;
  String? _mood;
  //SQLLite não suporta bool, tendo de ser INT
  //no caso, passando 0 ou 1
  int? _makeExercise;


  String? get date => _date;
  double? get weight => _weight;
  int? get makeExercise => _makeExercise;
  String? get mood => _mood;

  InputForm(this._date, this._weight, this._makeExercise, this._mood);


}