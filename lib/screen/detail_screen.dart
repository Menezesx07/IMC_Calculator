import 'package:flutter/material.dart';

class detailScreen extends StatelessWidget {
  const detailScreen({super.key, this.weight, this.mood, this.makeExercise, this.date, this.color, this.imc});

  final weight;
  final mood;
  final makeExercise;
  final date;
  final color;
  final imc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes')),
      body: Center(

        child: Card(
          elevation: 50,
          shadowColor: Colors.black,
          color: color,

          child: SizedBox(
            width: 350,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Seu IMC: $imc", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                          Text("Peso: ${weight}kg", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                        ],
                      ),
                      Text("$date", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, decoration: TextDecoration.underline,)),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  const Divider(color: Colors.white,),

                  Text(
                    makeExercise == 1
                    ? "Você treinou nesse Dia :D"
                    : "Nesse dia você ficou em repouso",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const Divider(color: Colors.white,),
                  //Text

                  Text("Você estava se sentindo $mood nesse dia" , style: const TextStyle( fontSize: 20, fontWeight: FontWeight.w500,),),


                  const Divider(color: Colors.white,),

                  const Text("Classificação IMC: ", style: TextStyle( fontSize: 20, fontWeight: FontWeight.w500,)),

                  const SizedBox(height: 10),

                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white60
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("IMC: "),
                              Text("Menor que 18,5"),
                              Text("18,5 a 24,9"),
                              Text("25 a 29,9"),
                              Text("30 a 34,9"),
                              Text("35 a 39,9"),
                              Text("Maior que 40"),
                            ],
                          ),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Classificação: "),
                              Text("Magreza"),
                              Text("Saudavel"),
                              Text("Sobrepreso"),
                              Text("Obesidade Grau 1"),
                              Text("Obesidade Grau 2"),
                              Text("Obesidade Grau 3"),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

                 //SizedBox
                ],
              ), //Column
            ), //Padding
          ), //SizedBox
        ),
      ),
    );
  }
}
