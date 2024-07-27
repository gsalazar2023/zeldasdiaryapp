import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeldasdiary/screens/drops.dart';
import 'package:zeldasdiary/screens/armorlist.dart';

/*
colores
azul: Color.fromARGB(255, 30, 183, 222)
verde: Color.fromARGB(255, 158, 222, 30)
marron: Color.fromARGB(255, 134, 94, 44)
blanco
azul osc: Color.fromARGB(255, 35, 52, 99) 
naranja: Color.fromARGB(255, 247, 150, 32)

FOT-RodinProN-M
The Wild Breath of Zelda
 */

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zeldas Diary',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatelessWidget {
  MyCustomForm({super.key});
  final String iconoArmor = "assets/icons/armor.svg";
  final String iconoItem = "assets/icons/item.svg";
  final String iconoMonster = "assets/icons/monster.svg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 30, 183, 222),
          title: const SizedBox(
            width: double.infinity,
            child: Center(
              child: Text('Home',
                  style: TextStyle(
                      fontFamily: 'The Wild Breath of Zelda', fontSize: 50)),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 158, 222, 30),
                ),
                child: Text(
                  'Navigation Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: const Text('Home'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyCustomForm()),
                  );
                },
              ),
              ListTile(
                title: const Text('Monsters'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const MyMonsterPage(title: 'Monster Drops')),
                  );
                },
              ),
              ListTile(
                title: const Text('Items'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const MyItemPage(title: 'Item Drops')),
                  );
                },
              ),
              ListTile(
                title: const Text('Armors'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ArmorScreen()),
                  );
                },
              ),
            ],
          ),
        ),
        body: Container(
          color: Color.fromARGB(255, 35, 52, 99),
          child: Center(
              child: Container(
            color: Color.fromARGB(255, 134, 94, 44),
            width: 350,
            height: 550,
            child: Card(
                color: const Color.fromARGB(255, 53, 201, 227),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Armor List',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'The Wild Breath of Zelda',
                              fontSize: 30)),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ArmorScreen()),
                            );
                          },
                          child: SvgPicture.asset(
                            iconoArmor,
                            height: 60,
                            width: 70,
                          )),
                      const Padding(padding: EdgeInsets.only(bottom: 45)),
                      const Text('Items',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'The Wild Breath of Zelda',
                              fontSize: 30)),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        MyItemPage(title: 'Item Drops'))));
                          },
                          child: SvgPicture.asset(
                            iconoItem,
                            height: 60,
                            width: 70,
                          )),
                      const Padding(padding: EdgeInsets.only(bottom: 45)),
                      const Text('Monsters',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'The Wild Breath of Zelda',
                              fontSize: 30)),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => MyMonsterPage(
                                        title: 'Monster Drops'))));
                          },
                          child: SvgPicture.asset(
                            iconoMonster,
                            height: 60,
                            width: 70,
                          )),
                      const Padding(padding: EdgeInsets.only(bottom: 45)),
                    ])),
          )),
        ),
        persistentFooterAlignment: AlignmentDirectional.bottomCenter,
        persistentFooterButtons: <Widget>[
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Volver")),
        ]);
  }
}

/*





 */