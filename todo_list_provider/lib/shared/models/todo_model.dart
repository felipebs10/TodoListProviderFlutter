import 'package:uuid/uuid.dart';

class TodoModel {
  final String id;
  final String title;
  final String? description; /*? significa que pode ser nulo*/
  final DateTime date;

  TodoModel({
    String? cId,
    required this.title,
    this.description, //Sem o required, não é obrigatório.
    DateTime? cDate,
  }) : id = cId ?? const Uuid().v4(),
       date = cDate ?? DateTime.now();
}
