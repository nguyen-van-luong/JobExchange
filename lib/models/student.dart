class Student {
  int id;
  String fullname;
  DateTime? birthday;
  String email;
  String? avatarUrl;
  bool? gender;
  String? address;

  Student({
    required this.id,
    required this.fullname,
    required this.email,
    required this.birthday,
    required this.avatarUrl,
    required this.address,
  });

  Student.empty()
      : id = 0,
        fullname = '',
        email = '',
        birthday = DateTime.now(),
        avatarUrl = null,
        address = '';

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      fullname: json['fullname'],
      email: json['email'],
      birthday: json['birthday'],
      avatarUrl: json['avatarUrl'],
      address: json['address']
    );
  }

  Student copyWith({
    int? id,
    String? fullname,
    String? email,
    DateTime? birthday,
    String? avatarUrl,
    String? address
  }) {
    return Student(
      id: id ?? this.id,
      fullname: fullname ?? this.fullname,
      email: email ?? this.email,
      birthday: birthday ?? this.birthday,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      address: address ?? this.address
    );
  }
}
