class User {
  int id;
  int userId;
  String username;
  String? avatarUrl;
  String role;

  User({
    required this.id,
    required this.userId,
    required this.username,
    required this.avatarUrl,
    required this.role,
  });

  User.empty()
      : id = 0,
        userId = 0,
        username = '',
        avatarUrl = null,
        role = '';

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userId: json['userId'],
      username: json['username'],
      avatarUrl: json['avatarUrl'],
      role: json['role'],
    );
  }

  User copyWith({
    int? id,
    int? userId,
    String? username,
    String? avatarUrl,
    String? role,
  }) {
    return User(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      role: role ?? this.role,
    );
  }
}
