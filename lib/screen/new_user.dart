import 'package:flutter/material.dart';
import 'package:imc_calculator/repository/User_repository.dart';
import '../model/user.dart';
import 'home.dart';

class newUserScreen extends StatefulWidget {
   newUserScreen({super.key});

  @override
  State<newUserScreen> createState() => _newUserScreenState();
}

class _newUserScreenState extends State<newUserScreen> {

  TextEditingController nameController = TextEditingController();
  String? name;
  double height = 1.50;

//intanciando as funções
  var userRepository = UserRepository();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                const Text("Bem Vindo ao IMC Calculator !!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

                const SizedBox(height: 18),

                const Text("Você pode alterar suas configurações clicando \nno icone de perfil na tela inicial", style: TextStyle(fontSize: 14)),

                const SizedBox(height: 40),

                const Text("Qual o Seu Nome ?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),

                //Nome
                TextField(
                  controller: nameController,
                  onChanged: (nameController) {
                    name = nameController;
                    setState(() { });
                  },

                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white24,
                  ),
                ),

                const SizedBox(height: 20),

                const Text("Qual Sua Altura ?", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),

                const SizedBox(height: 18),

                //slider altura
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

              const SizedBox(height: 20),

              Container(
                  width: MediaQuery.of(context).size.width,
                  child: FilledButton(
                      onPressed: () async {
                        //passando os parametros dos campos, e o context para troca de tela
                        await userRepository.setUser(User(name, height), context);
                      },
                      child: const Text("Salvar")))
            ],
          ),
        ),
      ),

    );
  }
}
