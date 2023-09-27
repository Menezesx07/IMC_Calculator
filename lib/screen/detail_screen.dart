import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/home_controller.dart';

class detailScreen extends StatelessWidget {
  const detailScreen({super.key, this.weight, this.mood, this.makeExercise, this.date, this.color, this.imc, this.id});

  final weight;
  final mood;
  final makeExercise;
  final date;
  final color;
  final imc;
  final id;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(builder: (context, value, child) => Scaffold(
      appBar: AppBar(title: const Text('Detalhes')),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text("$date", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

            const SizedBox(height: 20),

            Card(
              elevation: 50,
              shadowColor: Colors.black,
              color: color,

              child: SizedBox(
                width: 350,
                height: 575,
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

                        ],
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      const Divider(color: Colors.white,),

                      const SizedBox( height: 10 ),

                      Text(
                        makeExercise == 1
                        ? "Você treinou nesse Dia :D"
                        : "Nesse dia você ficou em repouso",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox( height: 10 ),

                      const Divider(color: Colors.white,),

                      const SizedBox( height: 10 ),

                      Text("Você estava se sentindo $mood nesse dia" , style: const TextStyle( fontSize: 20, fontWeight: FontWeight.w500,),),

                      const SizedBox( height: 10 ),

                      const Divider(color: Colors.white,),

                      const SizedBox( height: 10 ),

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

            const SizedBox(height: 20),

            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.redAccent
              ),
              onPressed: (){
                    _ShowDialog(context);
                }, child: const Text("Excluir"))
          ],
        ),
      ),
     )
    );
  }

  void _ShowDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<HomeController>(builder: (context, value, child) => AlertDialog(

          title: const Text("Deletar"),
          content: const Text("Você realmente que excluir ?"),
          actions: [

            ElevatedButton(onPressed: () {
              Navigator.pop(context);
            }, child: const Text("Cancelar")),

            FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: Colors.red
                ),
                onPressed: () async {

               await value.deleteCard(id, context);

               Navigator.pop(context);

            }, child: const Text("Confirmar")),
          ],
         )
        );
      },
    ).then((value) {
      // Navegar de volta à tela inicial após fechar o AlertDialog
      Navigator.pop(context);
    });
  }

}
