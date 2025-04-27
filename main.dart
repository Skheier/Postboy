import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Postboy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 209, 2, 2)),
        useMaterial3: true,
      ),
      home: const HomePostboy(title: 'Postboy'),
    );
  }
}

class HomePostboy extends StatefulWidget {
  const HomePostboy({super.key, required this.title});
  final String title;
  @override
  State<HomePostboy> createState() => _HomePostboyState();
}

class _HomePostboyState extends State<HomePostboy> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _enderecoController = TextEditingController();

  void clearFields() {
    _nomeController.clear(); 
    _telefoneController.clear(); 
    _emailController.clear();
    _enderecoController.clear();
  }

  String? validarEmail(String? email){
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if(!isEmailValid){
      return 'email inválido...';
    }
    return null;
  }

  Future<http.Response> postRequest2() async {
    var url = _urlController.text;
    
    Map data = {
      'nome': _nomeController.text,
      'telefone': _telefoneController.text,
      'email': _emailController.text,
      'endereco': _enderecoController.text,
    };
    var body = json.encode(data);//encode Map to JSON

    var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": 'application/json'},
      body: body
    );
    print("${response.statusCode}");
    print("${response.body}");

    clearFields();

    return response;
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        
      ),

      body: Center(
        child: Column(//Coluna principal
          children: <Widget>[
            
            Padding(padding: const EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
            child: Row(
              children: <Widget>[ 
                
                Expanded(child: //Constringe a grossura do textField e impede erro onde ele se baseia na grossura do widget superior.
                  TextField(
                    controller: _urlController,
                    decoration: InputDecoration(labelText: 'URL'),
                  ),
                ),
              
                SizedBox(width: 20),
              
                ElevatedButton(
                  onPressed: () { _urlController.clear(); },
                  child: Text('Reset'),
                ),
              
              ]
            ),
            ),
            
            SizedBox(height: 30),

            Padding(padding: EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 50.0),
            child: Form(
              key: _formKey,
              child: Column(//Colun do form
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              
                  TextFormField(
                    controller: _nomeController,
                    decoration: InputDecoration(labelText: 'Nome'),
                    validator: (nome) => nome!.length < 2
                      ? 'Isso não é um nome'
                      : null, 
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 20), 
              
                  TextFormField(
                    controller: _telefoneController,
                    decoration: InputDecoration(labelText: 'Telefone'),
                    validator: (telefone) => telefone!.length < 11
                      ? 'Telefone deve ter no mínimo 11 números...'
                      : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 20),
              
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'E-mail'),
                    validator: validarEmail,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 20),
              
                  TextFormField(
                    controller: _enderecoController,
                    decoration: InputDecoration(labelText: 'Endereco'),
                    validator: (telefone) => telefone!.length < 10
                      ? 'Esse não é seu endereço 0_0'
                      : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    //style: ,
                  ),
                  SizedBox(height: 20),
              
                ],
              ),
            ),
            ),

          ],  
        ),
        /* */

      ),


      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton.extended( 
            onPressed: () {
              if(_formKey.currentState!.validate()){
                postRequest2(); 
              }
            },
            tooltip: 'Post',
            backgroundColor: Colors.red,
            heroTag: 'mapZoomOut',
            label: Text('Post', style: TextStyle(color: Colors.white),),
            icon: Icon(Icons.upload_file_outlined, color: Colors.white),
          ),

          SizedBox(
            width: 20,
          ),

          FloatingActionButton.extended(
            onPressed: () {
              clearFields();       
            },
            tooltip: 'Clear',
            backgroundColor: Colors.brown,
            //shape: ,
            label: const Text('Clear', style: TextStyle(color: Colors.white)),
            icon: const Icon(Icons.cleaning_services, color: Colors.white),
          ),

        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }
}