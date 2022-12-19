class Task {
  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.usersIds,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String title;
  final String description;
  final List<String> usersIds;
  final DateTime createdAt;
  final DateTime updatedAt;
}
