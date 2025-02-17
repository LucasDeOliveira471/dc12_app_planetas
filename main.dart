import 'dart:html';
import 'dart:convert';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRUD de Planetas',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PlanetListScreen(),
    );
  }
}

class Planet {
  String name;
  String distance;
  String size;
  String? nickname;

  Planet({required this.name, required this.distance, required this.size, this.nickname});

  Map<String, String?> toJson() => {
        'name': name,
        'distance': distance,
        'size': size,
        'nickname': nickname,
      };
}

class PlanetListScreen extends StatefulWidget {
  @override
  _PlanetListScreenState createState() => _PlanetListScreenState();
}

class _PlanetListScreenState extends State<PlanetListScreen> {
  List<Planet> _planets = [];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();

  void _addPlanet() {
    if (_nameController.text.isNotEmpty &&
        _distanceController.text.isNotEmpty &&
        _sizeController.text.isNotEmpty) {
      setState(() {
        _planets.add(Planet(
          name: _nameController.text,
          distance: _distanceController.text,
          size: _sizeController.text,
          nickname: _nicknameController.text.isNotEmpty ? _nicknameController.text : null,
        ));
      });
      _nameController.clear();
      _distanceController.clear();
      _sizeController.clear();
      _nicknameController.clear();
    }
  }

  void _deletePlanet(int index) {
    setState(() {
      _planets.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Planetas')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Nome do Planeta')),
                TextField(controller: _distanceController, decoration: InputDecoration(labelText: 'Distância do Sol')),
                TextField(controller: _sizeController, decoration: InputDecoration(labelText: 'Tamanho (km)')),
                TextField(controller: _nicknameController, decoration: InputDecoration(labelText: 'Apelido (opcional)')),
                SizedBox(height: 10),
                ElevatedButton(onPressed: _addPlanet, child: Text('Adicionar Planeta')),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _planets.length,
              itemBuilder: (context, index) {
                final planet = _planets[index];
                return ListTile(
                  title: Text(planet.name),
                  subtitle: Text('Distância: ${planet.distance} UA - Tamanho: ${planet.size} km'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deletePlanet(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
