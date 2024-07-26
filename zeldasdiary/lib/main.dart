import 'package:flutter/material.dart';
import 'package:zeldasdiary/screens/home.dart';

/*
colores
azul: Color.fromARGB(255, 30, 183, 222))
verde: Color.fromARGB(255, 158, 222, 30)
marron: Color.fromARGB(255, 134, 94, 44)
blanco
azul osc: Color.fromARGB(255, 35, 52, 99) 
naranja: Color.fromARGB(255, 247, 150, 32)

 */

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 35, 52, 99)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Zelda Diary'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          color: const Color.fromARGB(255, 35, 52, 99),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: const Color.fromARGB(255, 134, 94, 44),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: const Color.fromARGB(255, 30, 183, 222),
                    child: Container(
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Zelda's Diary",
                          style: TextStyle(
                              fontFamily: 'The Wild Breath of Zelda',
                              fontSize: 120,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                color: Colors.white,
                child: const TextField(
                  decoration: InputDecoration(labelText: 'Enter username'),
                  readOnly: false, // Desactiva la entrada de texto
                ),
              ),
              const SizedBox(height: 16),
              Container(
                color: Colors.white,
                child: const TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter password',
                  ),
                  obscureText: true,
                  readOnly: false, // Desactiva la entrada de texto
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                child: const Text('Enter App'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyCustomForm()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
