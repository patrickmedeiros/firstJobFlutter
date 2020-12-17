import 'package:firstJob/tarefas_form.dart';
import 'package:flutter/material.dart';

class HomeTarefas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro das minhas tarefas'),
      ),
      body: ListView(
        children: <Widget>[
          //Header(),
          TarefasForm(),
        ],
      ),
    );
  }
}