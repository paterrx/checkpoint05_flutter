import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: LivroFormScreen(),
  ));
}

class LivroFormScreen extends StatefulWidget {
  @override
  _LivroDoFormScreenState createState() => _LivroDoFormScreenState();
}

class _LivroDoFormScreenState extends State<LivroFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _tituloDoLivro = '';
  String _codigoISBN = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Livro.'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Titulo do Livro.'),
                onSaved: (value) {
                  _tituloDoLivro = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o titulo do livro.';
                  } else if (value.length < 3) {
                    return 'O titulo deve ter pelo menos 3 caracteres.';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Codigo ISBN.'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _codigoISBN = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o codigo ISBN.';
                  } else if (value.length != 13 || !RegExp(r'^\d+$').hasMatch(value)) {
                    return 'O codigo ISBN deve ter exatamente 13 digitos numericos.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TelaDeConfirmacao(
                          tituloDoLivro: _tituloDoLivro,
                        ),
                      ),
                    );
                  }
                },
                child: Text('Adicionar.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TelaDeConfirmacao extends StatelessWidget {
  final String tituloDoLivro;

  TelaDeConfirmacao({required this.tituloDoLivro});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmacao'),
      ),
      body: Center(
        child: Text(
          'Livro "$tituloDoLivro" adicionado a colecao!',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
