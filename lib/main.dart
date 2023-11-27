import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: '/', // Página inicial
      routes: {
        '/': (context) => HomeView(),
        '/second': (context) => const SecondView(),
        '/third': (context) => const ThirdView(),
        '/fourth': (context) => FourthView(),
        '/fifth': (context) => FifthView(),
      },
    );
  }
}

class HomeView extends StatelessWidget {
  final TextEditingController text1Controller = TextEditingController();
  final TextEditingController text2Controller = TextEditingController();

  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: text1Controller,
              decoration: InputDecoration(
                labelText: 'Campo de Texto 1',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: text2Controller,
              decoration: InputDecoration(
                labelText: 'Campo de Texto 2',
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Text(
                'CarStore México',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(
              title: Text('Home '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Busqueda'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/second',
                    arguments: [text1Controller, text2Controller]);
              },
            ),
            ListTile(
              title: Text('Favoritos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/third');
              },
            ),
            ListTile(
              title: Text('Categorias'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/fourth');
              },
            ),
            ListTile(
              title: Text('Usuario'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/fifth');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SecondView extends StatelessWidget {
  const SecondView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<TextEditingController> controllers = ModalRoute.of(context)
        ?.settings
        .arguments as List<TextEditingController>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Busqueda de autos'),
      ),
      body: const Center(),
    );
  }

  void _showMessage(
      BuildContext context, List<TextEditingController> controllers) {
    final text1 = controllers[0].text;
    final text2 = controllers[1].text;

    final message =
        'Este es el contenido de la vista principal:\n$text1\n$text2';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}

class ThirdView extends StatelessWidget {
  const ThirdView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: const Center(
          // child: Text('Contenido tercera vista'),
          ),
    );
  }
}

class FourthView extends StatefulWidget {
  @override
  _FourthViewState createState() => _FourthViewState();
}

class _FourthViewState extends State<FourthView> {
  double _var1 = 0;
  double _var2 = 0;
  String _operation = 'suma';
  int _result = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Categorias")),
      body: const Center(),
    );
  }

  String get _resultText {
    if (_operation == 'suma') {
      _result = _var1.round() + _var2.round();
    } else {
      _result = _var1.round() * _var2.round();
    }

    return 'El resultado de la ${_operation} es: ${_result}';
  }
}

class FifthView extends StatefulWidget {
  @override
  _FifthViewState createState() => _FifthViewState();
}

class _FifthViewState extends State<FifthView> {
  File? _image;
  final picker = ImagePicker();
  final textController = TextEditingController();

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Usuarios")),
      body: Column(
        children: <Widget>[
          if (_image != null)
            kIsWeb ? Image.network(_image!.path) : Image.file(_image!),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () => getImage(ImageSource.gallery),
                  child: Text("Cargar Imagen")),
              SizedBox(width: 10),
              ElevatedButton(
                  onPressed: () => getImage(ImageSource.camera),
                  child: Text("Tomar Foto")),
            ],
          ),
          TextField(
            controller: textController,
            decoration: InputDecoration(hintText: 'Nombre'),
          ),
          ElevatedButton(
              onPressed: () {
                // Aquí puedes usar la imagen (_image) y el texto (textController.text)
                setState(() {});
              },
              child: Text('Submit')),
          if (_image != null) Text(textController.text),
        ],
      ),
    );
  }
}
