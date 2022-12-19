class UserInfo {
  UserInfo({
    required this.id,
    required this.name,
    required this.email,
    required this.tasks,
    required this.createdAt,
  });

  final String id;
  final String name;
  final String email;
  final List<String> tasks;
  final DateTime createdAt;
}
