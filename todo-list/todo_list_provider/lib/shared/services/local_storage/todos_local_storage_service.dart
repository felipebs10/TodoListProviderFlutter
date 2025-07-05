import 'dart:convert';
import 'dart:developer';

import 'package:todo_list_provider/shared/services/local_storage/local_storage_service.dart';

import 'package:todo_list_provider/shared/const/message_const.dart';
import 'package:todo_list_provider/shared/errors/local_storage_exceptions.dart';
import 'package:todo_list_provider/shared/models/todo_model.dart';

class TodosLocalStorageService {
  final String todoskey = "todosKey";
  final String doneTodoskey = "doneTodosKey";

  final LocalStorageService _localStorageService;

  TodosLocalStorageService(this._localStorageService);

  Future<String?> setTodos(List<TodoModel> todos) async {
    try {
      final String data = jsonEncode(
        todos.map((todo) => todo.toMap()).toList(),
      );

      await _localStorageService.set(todoskey, data);

      return null;
    } on LocalStorageException {
      return "Erro ao salvar tarefas.";
    } catch (error, st) {
      log('Error saving todos', error: error, stackTrace: st);
      return defaultErrorMessage;
    }
  }

  Future<(String? error, List<TodoModel>? todos)> getTodos() async {
    try {
      final String? todosJson = await _localStorageService.get(todoskey);
      if (todosJson != null) {
        final todos = (jsonDecode(todosJson) as List)
            .map<TodoModel>((todo) => TodoModel.fromMap(todo))
            .toList();

        return (null, todos);
      }

      return (null, <TodoModel>[]);
    } on LocalStorageException {
      return ("Erro ao carregar tarefas.", null);
    } catch (error, st) {
      log('Error loading todos', error: error, stackTrace: st);
      return (defaultErrorMessage, null);
    }
  }

  /*Código para marcar o check da aplicação ou desmarcar.*/
  Future<String?> setDoneTodos(List<String> donetodos) async {
    try {
      final String data = jsonEncode(doneTodoskey);

      await _localStorageService.set(doneTodoskey, data);

      return null;
    } on LocalStorageException {
      return "Erro ao Salvar tarefas feitas.";
    } catch (error, st) {
      log('Error saving done todos', error: error, stackTrace: st);
      return defaultErrorMessage;
    }
  }

  Future<(String? error, List<String>? doneTodos)> getDoneTodos() async {
    try {
      final String? doneTodosJson = await _localStorageService.get(
        doneTodoskey,
      );
      if (doneTodosJson != null) {
        final doneTodos = (jsonDecode(doneTodosJson) as List).cast<String>();
        return (null, doneTodos);
      }

      return (null, <String>[]);
    } on LocalStorageException {
      return ("Erro ao carregar tarefas feitas.", null);
    } catch (error, st) {
      log('Error loading done todos', error: error, stackTrace: st);
      return (defaultErrorMessage, null);
    }
  }
}
