class User {
  String? id;
  String username;
  String password;
  String email;
  String avatar;

  User({
    this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        username: json['username'],
        password: json['password'],
        email: json['email'],
        avatar: json['avatar'],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "email": email,
        "avatar": avatar,
      };
}
