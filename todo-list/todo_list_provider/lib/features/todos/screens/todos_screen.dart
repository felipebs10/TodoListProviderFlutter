import 'package:flutter/material.dart';
import 'package:todo_list_provider/widgets/todo_checkbox_widget.dart';
import 'package:todo_list_provider/widgets/todo_date_widget.dart';
import 'package:todo_list_provider/widgets/todo_title_and_description_widget.dart';

import '../../../shared/models/todo_model.dart';

final List<TodoModel> todos = [
  TodoModel(title: 'Título 1', description: 'Descrição 1'),
  TodoModel(title: 'Título 2', description: 'Descrição 2'),
];

class TodosScreen extends StatelessWidget {
  const TodosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de tarefas - Flutter Dicas'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      body: ListView.builder(
        //itemCount, usado para saber a qtd de itens que tem.
        itemCount: todos.length,
        itemBuilder: (_, int index) {
          final TodoModel todo = todos[index];
          //Retorna uma linha

          return Row(
            children: [
              TodoCheckboxWidget(todo),
              const SizedBox(width: 12),
              TodoTitleAndDescriptionWidget(todo),
              TodoDateWidget(todo),
            ],
          );
        },
      ),
    );
  }
}
