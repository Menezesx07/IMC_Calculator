import 'package:flutter/material.dart';
import 'package:imc_calculator/components/card.dart';
import 'package:imc_calculator/components/floating_action_button.dart';
import 'package:imc_calculator/controller/home_controller.dart';
import 'package:imc_calculator/screen/config_screen.dart';
import 'package:provider/provider.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {



  //função que vai ser chamada ao carregar a tela
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<HomeController>(context, listen: false).getUserData();
    Provider.of<HomeController>(context, listen: false).getCards();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  List<dynamic> teste = [];

  @override
  Widget build(BuildContext context) {

    return Consumer<HomeController>(builder: (context, value, child) => Scaffold(

        appBar: PreferredSize(

          preferredSize: const Size.fromHeight(70.0),
          child: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(30.0),
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal:20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "IMC Calculator",
                          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                        ),
                        Text( "${value.name} / Altura: ${value.height} m " , style: const TextStyle(fontSize: 14.0, color: Colors.blue),
                        )
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.person),
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const configScreen()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        floatingActionButton: const homeFloatAction(),

        body: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: value.cardsList.isEmpty
                ?  const Center(child: Text("Comece Adicionando \nitens a Lista", style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, ),))
                :  ListView.builder(
                reverse: true,
                shrinkWrap: true,
                itemCount: value.cardsList.length,
                itemBuilder: (context, index) {

                  return cardHome(cardList: value.cardsList[index], height: value.height);

                }
            )
        )
    )
    );
  }
}