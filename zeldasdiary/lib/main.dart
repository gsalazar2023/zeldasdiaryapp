import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeldasdiary/data/armors.dart';
import 'package:zeldasdiary/data/item.dart';
import 'package:zeldasdiary/data/monster.dart';


class Menu extends StatelessWidget {
  const Menu({super.key});

  void prueba()
  {

  }

  @override
  Widget build(BuildContext context) {
    String iconoArmor = "assets/icons/armor.svg";
    String iconoItem = "assets/icons/item.svg";
    String iconoMonster = "assets/icons/monster.svg";
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 198, 225, 230),
        title: Text("Menu"),
      ),

      body: Center(
        child: Container(
          width: 350,
          height: 550,
          child: Card( 
            color: Color.fromARGB(255, 53, 201, 227),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Text(' Perfil ',  style: TextStyle(fontFamily: 'SonicFont', fontSize: 20)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(                 
                  builder: (context) => const armors()));
              },
            child: SvgPicture.asset(iconoArmor, height: 60, width: 70,)), 
        
        const Padding(padding: EdgeInsets.only(bottom: 105)),
           
            Text(' Objetos ',  style: TextStyle(fontFamily: 'SonicFont', fontSize: 20)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(                 
                  builder: (context) => const Item())); //ir a lista de juegos
              },
              child: SvgPicture.asset(iconoItem, height: 60, width: 70,)),
         
             const Padding(padding: EdgeInsets.only(bottom: 45)),

              Text(' Monstruos ',  style: TextStyle(fontFamily: 'SonicFont', fontSize: 20)),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(                 
                  builder: (context) => const Monster())); //ir a lista de juegos
              },
              child: SvgPicture.asset(iconoMonster, height: 60, width: 70,)),
         
             const Padding(padding: EdgeInsets.only(bottom: 45)),
            ]
          )        
                ),
        )
    ),

      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: <Widget>[
      ElevatedButton(onPressed: () {
            Navigator.pop(context);
      },
            child: const Text("Volver")),
      ]
    );
  }
}