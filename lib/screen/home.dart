import 'package:flutter/material.dart';
import 'package:imc_calculator/components/card.dart';
import 'package:imc_calculator/components/floating_action_button.dart';
import 'package:imc_calculator/repository/User_repository.dart';
import 'package:imc_calculator/screen/config_screen.dart';


class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {

  //botão canto inferior direito
  var homeFloatButton = const homeFloatAction();
  //cards exibidos na tela
  var cardHomeComponent = const cardHome();
  //variaveis vindo do getUser do hive
  String? name;
  String? height;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  getUserData () async {
    print("getUser");
    //instanciando a função que da o getData no hive
    var userData = await UserRepository().getUserData();
    //extraindo os dados do retorno da função
    //poderia chamar diretamente do widget, mas para
    //melhor limpeza, preferi assim
    name = userData[0];
    height = userData[1];
    //usando o setState pois caso não, ao carregar a tela, vai ser tentado preencher
    //o nome no topo, mas como ainda está nula, vai ficar como "null"
    setState(() { });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
                      Text( "$name / Altura: $height m " , style: TextStyle(fontSize: 14.0, color: Colors.blue),
                      )
                    ],
                  ),
                  IconButton(
                        icon: const Icon(Icons.person),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const configScreen()));
                        },
                      ),

                ],
              ),
            ),
          ),


        ),
      ),

      floatingActionButton: const homeFloatAction(),

      body: ListView(
          children: [

            const SizedBox(height: 40),

            cardHomeComponent,

            /*FilledButton(onPressed: () {


            }, child: Text("botão"))*/

          ],

      ),
    );
  }
}
