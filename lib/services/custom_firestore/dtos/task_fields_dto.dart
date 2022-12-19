import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TaskFieldsDTO extends Equatable {
  static const String titleId = 'title';
  static const String descriptionId = 'description';
  static const String usersIdsId = 'usersIds';
  static const String createdAtId = 'createdAt';
  static const String updatedAtId = 'updatedAt';

  const TaskFieldsDTO({
    required this.title,
    required this.description,
    required this.usersIds,
    required this.createdAt,
    required this.updatedAt,
  });

  final String title;
  final String description;
  final Set<String> usersIds;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toMap() => {
        titleId: title,
        descriptionId: description,
        usersIdsId: usersIds.toList(),
        createdAtId: Timestamp.fromDate(createdAt),
        updatedAtId: Timestamp.fromDate(updatedAt),
      };

  factory TaskFieldsDTO.fromMap(Map map) => TaskFieldsDTO(
        title: map[titleId],
        description: map[descriptionId],
        usersIds: map[usersIdsId].cast<String>().toSet(),
        createdAt: (map[createdAtId] as Timestamp).toDate(),
        updatedAt: (map[updatedAtId] as Timestamp).toDate(),
      );

  @override
  List<Object?> get props =>
      [title, description, usersIds, createdAt, updatedAt];
}
