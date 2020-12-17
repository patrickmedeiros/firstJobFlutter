import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ListPage extends StatefulWidget {
  @override
  _TarefasPageState createState() => _TarefasPageState();
}

class _TarefasPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas tarefas"),
      ),
      body: _body(context),
    );
  }

  @override
  void initState() {
    super.initState();
    _readData().then((value) => {
          setState(() {
            _tarefas = json.decode(value);
          }),
        });
  }

  Column _body(context) {
    return Column(
      children: <Widget>[
        _listagem(context),
      ],
    );
  }

  List _tarefas = [];

  _listagem(context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _tarefas.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(_tarefas[index]['tarefa']),
            subtitle: Text(_tarefas[index]['data']),
            value: _tarefas[index]['ok'],
            onChanged: (bool value) {
              setState(() {
                _tarefas[index]['ok'] = value;
              });
            },
          );
        },
      ),
    );
  }

  Future<File> _getFile() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    return File(appDocPath + '/compras.json');
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
