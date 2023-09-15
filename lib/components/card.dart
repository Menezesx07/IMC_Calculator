import 'package:flutter/material.dart';

class cardHome extends StatefulWidget {
  const cardHome({super.key});

  @override
  State<cardHome> createState() => _cardHomeState();
}

class _cardHomeState extends State<cardHome> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Hero(
          tag: 'ListTile-Hero',
            child: Material(
              child: ListTile(

                leading: const FlutterLogo(size: 42.0),
                title: const Row(
                  children: [
                    Text("58.4", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                    Text(" imc"),
                  ],
                ),
                subtitle: const Text("110kg", style: TextStyle( fontWeight: FontWeight.bold)),
                trailing: const Text("12/09/2023", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                tileColor: Colors.lightGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<Widget>(builder: (BuildContext context) {
                      return Scaffold(
                        appBar: AppBar(title: const Text('Detalhes')),
                        body: Center(
                          child: Hero(
                            tag: 'ListTile-Hero',
                            child: Material(
                                child: Container(
                                  child: Column (
                                    children: [
                                      Text("data"),
                                      Text("data"),
                                      Text("data"),
                                      Text("data"),
                                    ],
                                  ),
                                )
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                },

              ),
            ),
        ),
      ),
    );
  }
}
