import 'package:flutter/cupertino.dart';

class InputForm {

  final String _id = UniqueKey().toString();
  String? _date;
  double? _weight;
  bool? _makeExercise;
  String? _mood;

  InputForm(this._date, this._weight, this._makeExercise, this._mood);

}