import 'package:equatable/equatable.dart';

class UserInfo extends Equatable {
  const UserInfo({
    required this.id,
    required this.name,
    required this.email,
    required this.tasks,
    required this.createdAt,
  });

  final String id;
  final String name;
  final String email;
  final Set<String> tasks;
  final DateTime createdAt;

  @override
  List<Object?> get props => [id, name, email, tasks, createdAt];
}
