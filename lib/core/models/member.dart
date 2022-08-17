import 'dart:convert';

class Member {
  String name;
  String email;
  String firstName;
  String lastName;
  String profileUrl;

  Member({
    required this.name,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.profileUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'user_first_name': firstName,
      'user_last_name': lastName,
    };
  }

  factory Member.fromLocal(Map<String, dynamic> map) {
    return Member(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      firstName: map['user_first_name'] ?? '',
      lastName: map['user_last_name'] ?? '',
      profileUrl: map['user_avatar_url'] ?? '',
    );
  }

  factory Member.fromServer(Map<String, dynamic> map) {
    return Member(
      name: map['user_display_name'] ?? '',
      email: map['user_email'] ?? '',
      firstName: map['user_first_name'] ?? '',
      lastName: map['user_last_name'] ?? '',
      profileUrl: map['user_avatar_url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Member.fromJson(String source) => Member.fromLocal(json.decode(source));
}
