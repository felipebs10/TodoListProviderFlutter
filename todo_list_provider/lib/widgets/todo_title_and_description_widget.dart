import 'package:flutter/material.dart';
import 'package:todo_list_provider/shared/widgets/text/text_widget.dart';
import '../../../shared/models/todo_model.dart';

class TodoTitleAndDescriptionWidget extends StatelessWidget {
  final TodoModel todo;

  const TodoTitleAndDescriptionWidget(this.todo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        //mainAxisAlignment, alinha a coluna
        //Alinha a esquerda ao lado do checkbox, horizontalmente
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(todo.title, cFontSize: 20),
          if (todo.description != null) TextWidget(todo.description!),
        ],
      ),
    );
  }
}
