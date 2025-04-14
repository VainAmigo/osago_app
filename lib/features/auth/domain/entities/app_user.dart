class AppUser {
  final String uid;
  final String inn;
  final String email;

  AppUser({
    required this.uid,
    required this.inn,
    required this.email,
  });

  // conver app user to json
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'inn': inn,
      'email': email,
    };
  }

  // convert json to appuser
  factory AppUser.fromJson(Map<String, dynamic> jsonUser) {
    return AppUser(
      uid: jsonUser['uid'],
      inn: jsonUser['inn'],
      email: jsonUser['email'],
    );
  }
}
