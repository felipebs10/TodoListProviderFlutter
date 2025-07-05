import 'package:flutter/material.dart';
import 'package:todo_list_provider/shared/models/todo_model.dart';
import 'package:todo_list_provider/shared/services/local_storage/todos_local_storage_service.dart';

class TodosController extends ChangeNotifier {
  final TodosLocalStorageService _todosLocalStorageService;

  TodosController(this._todosLocalStorageService);

  final List<TodoModel> todos = [];

  final List<String> doneTodos = [];

  Future<String?> loadTodos() async {
    final (String? error, List<TodoModel>? loadedTodos) =
        await _todosLocalStorageService.getTodos();

    if (error == null) {
      /*Nesse formato fica em cascada em vem de usa um todo para cada*/
      todos
        ..clear()
        ..addAll(loadedTodos!);

      sortTodosByDate();
    }

    return error;
  }

  /*Organiando as informações por data*/
  void sortTodosByDate() {
    todos.sort((todoA, todoB) => todoA.date.compareTo(todoB.date));
    notifyListeners();
  }

  Future<String?> loadDoneTodos() async {
    final (String? error, List<String>? loadDoneTodos) =
        await _todosLocalStorageService.getDoneTodos();

    if (error == null) {
      doneTodos
        ..clear()
        ..addAll(loadDoneTodos!);
    }

    return error;
  }

  Future<String?> addTodo(TodoModel todo) async {
    todos.add(todo);

    final String? error = await saveTodos();

    if (error == null) {
      sortTodosByDate();
    }

    return error;
  }

  Future<String?> saveTodos() async {
    return _todosLocalStorageService.setTodos(todos);
  }

  //Verificando se o id do item do todo é igual ao id da função
  //Nesse caso verificada se a opção já está marcada.
  bool isTodoChecked(String id) {
    return doneTodos.indexWhere((checkedTodoId) => checkedTodoId == id) != -1;
  }

  //Função responsável que ao clicar no botão
  Future<String?> checkTodo(String id) async {
    if (!isTodoChecked(id)) {
      doneTodos.add(id);
    } else {
      doneTodos.removeWhere((checkedTodoId) => checkedTodoId == id);
    }

    final String? error = await _todosLocalStorageService.setDoneTodos(
      doneTodos,
    );

    if (error == null) {
      notifyListeners();
    }

    //Se der erro
    if (isTodoChecked(id)) {
      doneTodos.add(id);
    } else {
      doneTodos.removeWhere((checkedTodoId) => checkedTodoId == id);
    }

    return error;
  }
}
