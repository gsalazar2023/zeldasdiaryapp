import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Item extends StatelessWidget {
  const Item({super.key});

  @override
  Widget build(BuildContext context) {

    
     return Scaffold(
      appBar: AppBar(

        backgroundColor: Color.fromARGB(255, 134, 130, 255),
        title: Text("Items"),
      ),

       body: Center(
              child: Container(
          width: 900,
          height: 350,
          child: Card(
            color: Color.fromARGB(255, 219, 216, 254),
            child: ListView(
              children: <Widget>[
                           Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 50),
                  Text("Items: "),
                ],
              ),
              SizedBox(height: 50),
                Container(
                  height: 55,
                  color: Color.fromARGB(255, 65, 197, 253),
                  child: const Center(
                    child: Text("Item 1"),
                )),
                Container(
                  height: 5,
                ),
                Container(
                  height: 55,
                  color: Color.fromARGB(255, 65, 197, 253),
                  child: const Center(
                       child: Text("Item 2"),
                )),
                Container(
                  height: 5,
                ),
               Container(
                  height: 55,
                 color: Color.fromARGB(255, 65, 197, 253),
                  child: const Center(
                       child: Text("Item 3"),
                )), 
            ],
          ),
                ),
        ),
       ),
      
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: <Widget>[
      ElevatedButton(onPressed: () {
            Navigator.pop(context);
      },
            child: const Text("Regresar")),
            
      ]

      
      
    );
  }
}