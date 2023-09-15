import 'package:flutter/material.dart';
import '../repository/User_repository.dart';

class splashScreen extends StatefulWidget {
  const splashScreen ({super.key});

  @override
  State<splashScreen> createState() => _State();
}

class _State extends State<splashScreen> {

  var checkUser = UserRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //função do repository para checkar se existe usuario
    checkUser.getUserToLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("IMC Calculator", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
