import 'package:flutter/material.dart';
import 'package:imc_calculator/controller/home_controller.dart';
import 'package:provider/provider.dart';

import '../model/user.dart';
import '../repository/User_repository.dart';
import 'home.dart';

class configScreen extends StatefulWidget {
  const configScreen({super.key});

  @override
  State<configScreen> createState() => _configScreenState();
}

class _configScreenState extends State<configScreen> {


  //basicamente a mesma coisa do "NewUser"
  TextEditingController nameController = TextEditingController();
  String? name;
  double height = 1.50;

//intanciando as funções
  var userRepository = UserRepository();

  void navigator () {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const homeScreen()));
  }

  //preenchendo tanto a label quanto a variavel interna com o nome ja escolhido
  getLabelName () async{
    var data = await userRepository.getUserData();
    nameController.text = data[0]; //default text
    name = data[0]; //default text
  }

  @override
  void initState() {
    getLabelName();
    super.initState();
  }

  bool isLoading = false;


  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, value, child) =>  Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back),
            onTap: () {
              navigator();
            },
          ),
          title: const Text("Configurações")),

      body:  Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column (

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text("Qual o Seu Nome ?",  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),

            const SizedBox(height: 18),

            TextField(
              controller: nameController,
              onChanged: (nameController) {
                name = nameController;
              },
              decoration: const InputDecoration(
                filled: true,
              ),
            ),

            const SizedBox(height: 30),

            const Text("Qual a sua altura ?",  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),


            const SizedBox(height: 18),

            Column(
              children: [
                Text("${height.toStringAsFixed(2)} metros", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                Slider(
                    min: 1,
                    max: 2.5,
                    value: height.toDouble(),
                    onChanged: (double value) { setState(() => height = value); }),
              ],
            ),

            const Divider(),

            const SizedBox(height: 18),

            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: FilledButton(
                    onPressed: () async {

                      final func = context.read<HomeController>();

                      if(name != null && name!.length <= 20) {

                      func.setUser(User(name, height), context);



                      } else {
                        print("Nome Vazio");
                        return;
                      }

                    },
                    child: const Text("Salvar")))

          ],
        ),
       ),
      )
    );
  }
}
