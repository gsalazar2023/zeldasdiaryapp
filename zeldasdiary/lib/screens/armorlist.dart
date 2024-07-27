import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zeldasdiary/data/armors.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class ArmorScreen extends StatefulWidget {
  @override
  _ArmorScreenState createState() => _ArmorScreenState();
}

class _ArmorScreenState extends State<ArmorScreen> {
  late Future<List<Armors>> _armorList;

  @override
  void initState() {
    super.initState();
    _armorList = fetchArmors();
  }

  Future<List<Armors>> fetchArmors() async {
    final String response = await rootBundle.loadString('assets/json/armor.json');
    List<dynamic> data = jsonDecode(response);
    return data.map<Armors>((json) => Armors.fromJson(json)).toList();
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
            child: Text('Armor List',
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => HomePage()),
                // );
              },
            ),
            ListTile(
              title: const Text('Monsters'),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) =>
                //           MyMonsterPage(title: 'Monster Drops')),
                // );
              },
            ),
            ListTile(
              title: const Text('Items'),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) =>
                //           MyItemPage(title: 'Item Drops')),
                // );
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
        child: Center(
          child: FutureBuilder<List<Armors>>(
            future: _armorList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Text("No data available");
              } else {
                return Container(
                  width: 300,
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final armor = snapshot.data![index];
                      final backgroundColor = index.isEven
                          ? Colors.white
                          : const Color.fromARGB(255, 247, 150, 32);

                      return Container(
                        color: backgroundColor,
                        child: ListTile(
                          title: Text(
                            armor.name,
                            style: const TextStyle(
                              fontFamily: 'FOT-RodinProN-M',
                              color: Color.fromARGB(255, 134, 94, 44),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ArmorDetailScreen(
                                          armor: armor,
                                        )));
                          },
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class ArmorDetailScreen extends StatelessWidget {
  final Armors armor;

  const ArmorDetailScreen({Key? key, required this.armor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            armor.name,
            style: const TextStyle(
                fontFamily: 'The Wild Breath of Zelda',
                fontSize: 50,
                color: Colors.white),
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
                          SvgPicture.asset(
                            armor.image,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.scaleDown,
                          ),
                          Text(
                            armor.name,
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
                  const SizedBox(height: 8),
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
                          armor.location.isEmpty
                              ? 'Unavailable'
                              : armor.location.join('\n'),
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
                    'Items Upgrade:',
                    style: TextStyle(
                        fontFamily: 'FOT-RodinProN-M',
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
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
            Navigator.pop(context);
          },
          child: const Text('Go Back'),
        ),
      ],
    );
  }
}