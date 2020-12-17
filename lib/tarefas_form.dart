import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firstJob/list_page.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class TarefasForm extends StatefulWidget {
  @override
  _TarefaFormState createState() => _TarefaFormState();
}

class _TarefaFormState extends State<TarefasForm> {
  var _edTarefa = TextEditingController();
  String _rbPrioridade = '';
  var _edData = TextEditingController();
  String _mensagem = '';

  @override
  void initState() {
    super.initState();
    _readData().then((value) => {
          setState(() {
            _tarefas = json.decode(value);
          }),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _edTarefa,
            keyboardType: TextInputType.name,
            style: TextStyle(
              fontSize: 20,
            ),
            decoration: InputDecoration(
              labelText: 'Tarefa',
            ),
          ),
          TextFormField(
            controller: _edData,
            keyboardType: TextInputType.datetime,
            style: TextStyle(
              fontSize: 20,
            ),
            decoration: InputDecoration(
              labelText: 'Data',
            ),
          ),
          ListTile(
            title: const Text('Urgente'),
            leading: Radio(
              value: 'Urgente',
              groupValue: _rbPrioridade,
              onChanged: (value) {
                setState(() {
                  _rbPrioridade = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Normal'),
            leading: Radio(
              value: 'Normal',
              groupValue: _rbPrioridade,
              onChanged: (value) {
                setState(() {
                  _rbPrioridade = value;
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
            ),
            child: FlatButton(
              onPressed: () {
                _addTarefa();
              },
              child: Text(
                ' Cadastrar ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
            ),
            child: FlatButton(
              onPressed: () {
                _listagem(context);
              },
              child: Text(
                ' Listar ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            _mensagem,
            style: TextStyle(
              color: Colors.orange,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  _addTarefa() {
    String tarefa = _edTarefa.text;
    String data = _edData.text;

    var novaTarefa = new Map();

    novaTarefa['tarefa'] = tarefa;
    novaTarefa['data'] = data;
    novaTarefa['ok'] = false;

    setState(() {
      _tarefas.add(novaTarefa);
      _edTarefa.text = '';
      _edData.text = '';
    });

    _saveData();
  }

  List _tarefas = [];

  _listagem(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListPage()),
    );
  }

  Future<File> _getFile() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    return File(appDocPath + '/compras.json');
  }

  Future<File> _saveData() async {
    String tarefas = json.encode(_tarefas);
    try {
      final file = await _getFile();
      _mensagem = 'Tarefa cadastrada com sucesso.';
      return file.writeAsString(tarefas);
    } catch (e) {
      print('Erro ao cadastrar tarefa ${e.toString()}');
      return null;
    }
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      print('Erro na leitura do arquivo ${e.toString()}');
      return null;
    }
  }
}
