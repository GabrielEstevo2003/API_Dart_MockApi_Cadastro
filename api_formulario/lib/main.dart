import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consumo de API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> products = [];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      final response = await http.get(
        Uri.parse('https://67f059fb2a80b06b8897a135.mockapi.io/api/cadastro/aluno'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        setState(() {
          products = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      print('Erro ao buscar dados: $e');
      throw Exception('Erro ao buscar dados: $e');
    }
  }

  Future<void> addPost(String nome, String cidade, String pais) async {
    try {
      final response = await http.post(
        Uri.parse('https://67f059fb2a80b06b8897a135.mockapi.io/api/cadastro/aluno'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nome': nome,
          'cidade': cidade,
          'pais': pais,
        }),
      );

      if (response.statusCode == 201) {
        setState(() {
          products.add(json.decode(response.body));
        });
      } else {
        final errorMessage = json.decode(response.body)['message'] ?? 'Erro desconhecido';
        throw Exception('Falha ao adicionar o registro: $errorMessage');
      }
    } catch (e) {
      print('Erro ao adicionar registro: $e');
      throw Exception('Erro ao adicionar registro: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Produtos'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: products.length,
              separatorBuilder: (BuildContext context, int index) => const Divider(),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('Nome: ${products[index]['nome']}\nCidade: ${products[index]['cidade']}\nPais: ${products[index]['pais']}'),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProductPage(onSubmit: addPost),
                ),
              );
            },
            child: const Text('Inserir Registro'),
          ),
        ],
      ),
    );
  }
}

class AddProductPage extends StatefulWidget {
  final Future<void> Function(String nome, String cidade, String pais) onSubmit;

  const AddProductPage({super.key, required this.onSubmit});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _nomeController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _paisController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Novo Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _cidadeController,
              decoration: const InputDecoration(labelText: 'Cidade'),
            ),
            TextField(
              controller: _paisController,
              decoration: const InputDecoration(labelText: 'País'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final nome = _nomeController.text;
                final cidade = _cidadeController.text;
                final pais = _paisController.text;

                if (nome.isNotEmpty && cidade.isNotEmpty && pais.isNotEmpty) {
                  widget.onSubmit(nome, cidade, pais).then((_) {
                    Navigator.pop(context); // Volta para a página anterior
                  }).catchError((e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  });
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}