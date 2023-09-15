import 'package:flutter/material.dart';
import 'package:imc_calculator/model/input_form.dart';
import 'package:imc_calculator/repository/input_form_repository.dart';

class homeFloatAction extends StatefulWidget {
  const homeFloatAction({super.key});

  @override
  State<homeFloatAction> createState() => _homeFloatActionState();
}

class _homeFloatActionState extends State<homeFloatAction> {

  double weight = 50;
  bool makeExercise = false;
  String? mood;
  DateTime? dateController;
  //recebe o parametro dentro onTap
  var dateFormated;

  //intanciando as funções
  var inputFormRepository = InputFormRepository();

  //instanciando o bd (temporariamente)
  var _inputForm = <InputForm> [];

  //carregando os cards do banco na função getCards
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCards();
  }

  getCards() async => _inputForm = await inputFormRepository.listCards();

  //função que vai da tanto o setState da variavel
  //quando o state do StatefulBuilder do ShowModal
  //ShowModal trabalha como um "Stateless" e precisa
  //builder para "virar" Stateful
  void setStateBuilder(state) {
    setState(() {});
    state(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
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
                                    firstDate: DateTime(1900, 5, 20),
                                    lastDate: DateTime(2023, 12, 12));

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
                            "${weight.toStringAsFixed(2)} kg",
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),

                        Slider(
                            min: 30,
                            max: 200,
                            value: weight.toDouble(),
                            onChanged: (double value) {
                              weight = value;
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
                            value: makeExercise,
                            onChanged: (bool value) {
                              makeExercise = value;
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

                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: FilledButton(
                                onPressed: ()  async {
                                  await inputFormRepository.addCard(InputForm(dateFormated, weight, makeExercise, mood));
                                  Navigator.pop(context);
                                  setStateBuilder(state);

                                  getCards();

                                  print("inicio");
                                  print(_inputForm.length);
                                  print("inicio");

                                }, child: const Text("Salvar")))
                      ],
                    ),
                  );
                });
              });
        });
  }
}
