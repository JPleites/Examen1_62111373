import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> dataList = [];

  @override
  void initState() {
    super.initState();
    // Cargar la lista de datos al inicio
    loadListData();
  }

  Future<void> loadListData() async {
    // Leer el archivo JSON de los assets
    String jsonData = await rootBundle.loadString('assets/data_copy.json');
    // Decodificar el JSON a una lista de objetos
    List<dynamic> jsonList = json.decode(jsonData);
    // Actualizar el estado con los datos cargados
    setState(() {
      dataList = jsonList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 50, 216, 28),
        title: const Text('Lista de Libros'),
      ),
      body: Container(
        color: Color.fromARGB(255, 110, 197, 255),
        child: ListView.builder(
          itemCount: dataList.length,
          itemBuilder: (BuildContext context, int id) {
            return GestureDetector(
              onTap: () {
                // Abrir la nueva ventana y pasar los datos del elemento seleccionado
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(item: dataList[id]),
                  ),
                );
              },
              child: ListTile(
                title: Text(dataList[id]['Title']),
                subtitle: Text(dataList[id]['Publisher']),
              ),
            );
          },
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final dynamic item;

  const DetailScreen({Key? key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 221, 17, 17),
        title: const Text('Detalles'),
      ),
      body: Container(
        color: Color.fromARGB(255, 255, 109, 25),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Nombre: ${item['Title']}'),
              const SizedBox(height: 10),
              Text('Año: ${item['Year']}'),
              Text('Editorial: ${item['Publisher']}'),
              Text('ISBN: ${item['ISBN']}'),
              Text('Paginas: ${item['Pages']}'),
              Text('Villains: ${item['villains']}'),
            ],
          ),
        ),
      ),
    );
  }
}
