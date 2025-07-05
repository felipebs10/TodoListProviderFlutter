import 'package:uuid/uuid.dart';

class TodoModel {
  final String id;
  final String title;
  final String? description; /*? significa que pode ser nulo*/
  final DateTime date;

  //Construtor padrão
  TodoModel({
    String? cId,
    required this.title,
    this.description, //Sem o required, não é obrigatório.
    DateTime? cDate,
  }) : id = cId ?? const Uuid().v4(),
       date = cDate ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.millisecondsSinceEpoch,
    };
  }

  //Consturtutor customizado
  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      cId: map['id'],
      title: map['title'],
      description: map['description'],
      cDate: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }
}
