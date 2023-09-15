import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Configurações")),

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
                setState(() { });
              },
              decoration: const InputDecoration(
                filled: true,
              ),
            ),

            const SizedBox(height: 30),

            const Text("Qual a sua altura ?",  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),

            const Divider(),

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



            Container(
                width: MediaQuery.of(context).size.width,
                child: FilledButton(
                    onPressed: () async {
                      //passando os parametros dos campos, e o context para troca de tela
                      userRepository.setUser(User(name, height), context);
                      setState(() {
                      });
                      Navigator.pop(context);



                    },
                    child: const Text("Salvar")))


          ],
        ),
      ),
    );
  }
}
