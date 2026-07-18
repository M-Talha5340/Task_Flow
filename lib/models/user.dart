class AppUser {
  final String? name;
  final String? email;
  final String? password;
  final String? profileimg;
  AppUser({
    required this.email,
    required this.name,
    required this.password,
    this.profileimg,
  });

  AppUser copyWith({
    String? email,
    String? name,
    String? password,
    String? profileimg,
  }) {
    return AppUser(
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      profileimg: profileimg ?? this.profileimg,
    );
  }

  Map<String, dynamic> tomap() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "profileimg": profileimg,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      name: map["name"],
      password: map["password"],
      profileimg: map["profileimg"],
      email: map["email"],
    );
  }
}
