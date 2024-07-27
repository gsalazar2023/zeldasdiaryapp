import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zeldasdiary/data/item.dart';
import 'package:zeldasdiary/data/monster.dart';
import 'package:zeldasdiary/screens/armorlist.dart';
import 'package:http/http.dart' as http;
import 'package:zeldasdiary/screens/home.dart';

class MyMonDetail extends StatefulWidget {
  const MyMonDetail({super.key, required this.title, required this.monster});
  final String title;
  final Monster monster;
  @override
  State<MyMonDetail> createState() => _MonDetState();
}

class _MonDetState extends State<MyMonDetail> {
  late String dropsText;
  late String locText;

  @override
  void initState() {
    super.initState();

    dropsText = widget.monster.drops.isEmpty
        ? 'No Monster Drops'
        : widget.monster.drops.join('\n');
    locText = widget.monster.location.isEmpty
        ? 'Unavailable'
        : widget.monster.location.join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(widget.monster.name,
                  style: const TextStyle(
                      fontFamily: 'The Wild Breath of Zelda',
                      fontSize: 50,
                      color: Colors.white)),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 30, 183, 222),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: const Color.fromARGB(255, 35, 52, 99),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          children: [
                            Image.network(widget.monster.image,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.scaleDown),
                            Text(
                              widget.monster.name,
                              style: const TextStyle(
                                  fontFamily: 'The Wild Breath of Zelda',
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Category: \n${widget.monster.category}',
                      style: const TextStyle(
                          fontFamily: 'FOT-RodinProN-M',
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: const Color.fromARGB(255, 158, 222, 30),
                        child: Center(
                          child: Text(
                            'Description: \n${widget.monster.desc}',
                            style: const TextStyle(
                                fontFamily: 'FOT-RodinProN-M',
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Locations:',
                      style: TextStyle(
                          fontFamily: 'FOT-RodinProN-M',
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: const Color.fromARGB(255, 30, 183, 222),
                        child: Center(
                          child: Text(
                            locText,
                            style: const TextStyle(
                                fontFamily: 'FOT-RodinProN-M',
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Drops:',
                      style: TextStyle(
                          fontFamily: 'FOT-RodinProN-M',
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: const Color.fromARGB(255, 30, 183, 222),
                        child: Center(
                          child: Text(
                            dropsText,
                            style: const TextStyle(
                                fontFamily: 'FOT-RodinProN-M',
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        persistentFooterAlignment: AlignmentDirectional.center,
        persistentFooterButtons: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop;
              },
              child: const Text('Go Back'))
        ]);
  }
}

class MyMonsterPage extends StatefulWidget {
  const MyMonsterPage({super.key, required this.title});
  final String title;

  @override
  State<MyMonsterPage> createState() => _MonsterPageState();
}

class _MonsterPageState extends State<MyMonsterPage> {
  late Future<List<Monster>> _monlist;

  @override
  void initState() {
    super.initState();
    _monlist = fetchMonster();
  }

  Future<List<Monster>> fetchMonster() async {
    final response = await http.get(Uri.parse(
        'https://botw-compendium.herokuapp.com/api/v3/compendium/category/monsters'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      //para una lista usar:
      //print('text');
      //print(jsonDecode(response.body)["data"]);
      final List<dynamic> jsonDecoded =
          jsonDecode(response.body)["data"] as List<dynamic>;
      return jsonDecoded
          .map((dynamic item) => Monster.fromJson(item as Map<String, dynamic>))
          .toList();

      //para un elemento usar:
      //return List<Monster>.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 30, 183, 222),
        title: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(widget.title,
                style: const TextStyle(
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
                  MaterialPageRoute(builder: (context) => const ArmorScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 35, 52, 99),
        child: Container(
          child: Center(
              child: FutureBuilder<List<Monster>>(
            future: _monlist,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text("No data available");
              } else {
                return Container(
                  width: 300, // Ajusta el ancho del contenedor
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final monster = snapshot.data![index];

                      // Alterna los colores de fondo de las filas
                      final backgroundColor = index.isEven
                          ? Colors.white
                          : const Color.fromARGB(255, 247, 150, 32);

                      return Container(
                        color: backgroundColor,
                        child: ListTile(
                            title: Text(
                              monster.name,
                              style: const TextStyle(
                                fontFamily: 'FOT-RodinProN-M',
                                color: Color.fromARGB(255, 134, 94, 44),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyMonDetail(
                                            title: monster.name,
                                            monster: monster,
                                          )));
                            }),
                      );
                    },
                  ),
                );
              }
            },
          )),
        ),
      ),
    );
  }
}

class MyItemDetail extends StatefulWidget {
  const MyItemDetail({super.key, required this.title, required this.item});
  final String title;
  final Items item;

  @override
  State<MyItemDetail> createState() => _ItemDetState();
}

class _ItemDetState extends State<MyItemDetail> {
  late String locText;

  @override
  void initState() {
    super.initState();

    locText = widget.item.locations.isEmpty
        ? 'Unavailable'
        : widget.item.locations.join('\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(widget.item.name,
                  style: const TextStyle(
                      fontFamily: 'The Wild Breath of Zelda',
                      fontSize: 50,
                      color: Colors.white)),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 30, 183, 222),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: const Color.fromARGB(255, 35, 52, 99),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          children: [
                            Image.network(widget.item.image,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.scaleDown),
                            Text(
                              widget.item.name,
                              style: const TextStyle(
                                  fontFamily: 'The Wild Breath of Zelda',
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Category: \n${widget.item.category}',
                      style: const TextStyle(
                          fontFamily: 'FOT-RodinProN-M',
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: const Color.fromARGB(255, 158, 222, 30),
                        child: Center(
                          child: Text(
                            'Description: \n${widget.item.desc}',
                            style: const TextStyle(
                                fontFamily: 'FOT-RodinProN-M',
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Location:',
                      style: TextStyle(
                          fontFamily: 'FOT-RodinProN-M',
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: const Color.fromARGB(255, 30, 183, 222),
                        child: Center(
                          child: Text(
                            locText,
                            style: const TextStyle(
                                fontFamily: 'FOT-RodinProN-M',
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        persistentFooterAlignment: AlignmentDirectional.center,
        persistentFooterButtons: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop;
              },
              child: const Text('Go Back'))
        ]);
  }
}

class MyItemPage extends StatefulWidget {
  const MyItemPage({super.key, required this.title});
  final String title;

  @override
  State<MyItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<MyItemPage> {
  late Future<List<Items>> _itemlist;

  @override
  void initState() {
    super.initState();
    _itemlist = fetchItem();
  }

  Future<List<Items>> fetchItem() async {
    final response = await http.get(Uri.parse(
        'https://botw-compendium.herokuapp.com/api/v3/compendium/category/materials'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      //para una lista usar:
      //print('text');
      //print(jsonDecode(response.body)["data"]);
      final List<dynamic> jsonDecoded =
          jsonDecode(response.body)["data"] as List<dynamic>;
      return jsonDecoded
          .map((dynamic item) => Items.fromJson(item as Map<String, dynamic>))
          .toList();

      //para un elemento usar:
      //return List<Monster>.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 30, 183, 222),
        title: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(widget.title,
                style: const TextStyle(
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
                  MaterialPageRoute(builder: (context) => ArmorScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 35, 52, 99),
        child: Container(
          child: Center(
              child: FutureBuilder<List<Items>>(
            future: _itemlist,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text("No data available");
              } else {
                return Container(
                  width: 300, // Ajusta el ancho del contenedor
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final item = snapshot.data![index];

                      // Alterna los colores de fondo de las filas
                      final backgroundColor = index.isEven
                          ? Colors.white
                          : const Color.fromARGB(255, 247, 150, 32);

                      return Container(
                        color: backgroundColor,
                        child: ListTile(
                            title: Text(
                              item.name,
                              style: const TextStyle(
                                fontFamily: 'FOT-RodinProN-M',
                                color: Color.fromARGB(255, 134, 94, 44),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyItemDetail(
                                            title: item.name,
                                            item: item,
                                          )));
                            }),
                      );
                    },
                  ),
                );
              }
            },
          )),
        ),
      ),
    );
  }
}
