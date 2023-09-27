import 'package:flutter/material.dart';
import 'package:imc_calculator/controller/home_controller.dart';
import 'package:imc_calculator/database/db_helper.dart';
import 'package:imc_calculator/model/input_form.dart';
import 'package:provider/provider.dart';

class homeFloatAction extends StatefulWidget {
  const homeFloatAction({super.key});

  @override
  State<homeFloatAction> createState() => _homeFloatActionState();
}

class _homeFloatActionState extends State<homeFloatAction> {

  //esqueci de componentizar o dialog :c
  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Aviso"),
          content: const Text(
            "Defina a data e depois como está se sentindo para salvar",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          actions: <Widget>[
            FilledButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final controller = HomeController();

  String weight = "50.00";
  int? makeExercise = 0;
  String? mood;
  DateTime? dateController;
  //recebe o parametro dentro onTap
  var dateFormated;
  bool makeExerciseController = false;


  //carregando os cards do banco na função getCards
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //função que vai da tanto o setState da variavel
  //quando o state do StatefulBuilder do ShowModal.
  //ShowModal trabalha como um "Stateless" e precisa
  //builder para "virar" Stateful
  void setStateBuilder(state) {
    setState(() {});
    state(() {});
  }

  //tem de ser feito essa adaptação pois o SQLite
  //não recebe Bool, apenas INT no lugar
  void setMakeExercise () {
    if (makeExerciseController == true) {
      makeExercise = 1;
    } else makeExercise = 0;
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(builder: (context, value, child) =>  FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            //isScroll para caso haja uma lista (muitos cards)
            //a modal não fique no fim da pagina
              isScrollControlled: true,
              context: context,
              builder: (context) {
                //como o ShowModal é um widget Stateless, tem de passar o builder
                //para as interações, e fazer a chamada do "state" passado como parametro
                //dentro do componente editavel (exemplo do slider) na função do onPressed
                return StatefulBuilder(builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: 20,
                        right: 20,
                        left: 20,
                        bottom: MediaQuery.of(context).viewInsets.bottom + 10),
                    child: Wrap(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.calendar_month_outlined),
                          title: const Text("Data da Pesagem:",
                              style: TextStyle(fontWeight: FontWeight.bold)),

                          //calendario ----------
                          trailing: FilledButton(
                            onPressed: () async {
                              //chamando o calendario
                              dateController = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2023, 1, 1),
                                  lastDate: DateTime.now());

                              //formatando a data, recebendo dia, mes e ano
                              dateFormated = "${dateController?.day}/${dateController?.month}/${dateController?.year}";

                              setStateBuilder(state);

                            },
                            child: dateController == null
                                ? const Text("Escolher")
                                : Text("$dateFormated"),),
                        ),

                        const Divider(),

                        //peso --------------
                        ListTile(
                          leading: const Icon(Icons.monitor_weight_outlined),
                          title: const Text(
                            "Qual o Seu Peso \nHoje ? ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            "${weight} kg",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),

                        Slider(
                            min: 30,
                            max: 200,
                            value: double.parse(weight),
                            onChanged: (double value) {
                              weight = value.toStringAsFixed(2);
                              //chamando o StatefulBuilder para recarregar
                              //o componente e exibir o valor correto
                              setStateBuilder(state);
                            }),

                        const Divider(),

                        //switch ---------------
                        ListTile(
                          leading: const Icon(Icons.accessibility_new_outlined),
                          title: const Text("Fez Exercicio hoje ?",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Switch(
                            value: makeExerciseController,
                            onChanged: (bool value) {
                              makeExerciseController = value;
                              setMakeExercise();
                              setStateBuilder(state);
                            },
                          ),
                        ),

                        const Divider(),

                        //mood ----------------
                        ListTile(
                          leading: const Icon(Icons.sunny_snowing),
                          title: const Text(
                            "Como Está se sendindo ?",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: FilledButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  //não componentizei os itens pois o state(){} não funcionava
                                  return SimpleDialog(
                                    title: const Text(
                                      "Como Você Está ?",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    children: <Widget>[
                                      SimpleDialogOption(
                                        child: const Text("Disposto"),
                                        onPressed: () {
                                          mood = "Disposto";
                                          setStateBuilder(state);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      SimpleDialogOption(
                                        child: const Text("Mais ou menos"),
                                        onPressed: () {
                                          mood = "Mais ou Menos";
                                          setStateBuilder(state);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      SimpleDialogOption(
                                        child: const Text("Cansado"),
                                        onPressed: () {
                                          mood = "Cansado";
                                          setStateBuilder(state);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: mood == null
                                ? const Text("Escolher")
                                : Text("$mood"),
                          ),
                        ),
                        const Divider(),

                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: FilledButton(
                                onPressed: ()  async {

                                  final counter = context.read<HomeController>();

                                  if( mood != null && dateFormated != null ) {

                                    counter.setCard(InputForm(
                                        dateFormated,
                                        double.parse(weight),
                                        makeExercise,
                                        mood));

                                    Navigator.pop(context);

                                  }  else {
                                    _dialogBuilder(context);
                                  }

                                }, child: const Text("Salvar")))
                      ],
                    ),
                  );
                });
              });
        })
    );
  }
}
