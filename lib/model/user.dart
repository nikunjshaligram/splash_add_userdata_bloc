const String userTable = 'users';

class UserFields {
  static final List<String> values = [
    id,
    firstname,
    lastname,
    mobilenumber,
    gender,
    role
  ];

  static const String id = '_id';
  static const String firstname = 'firstname';
  static const String lastname = 'lastname';
  static const String mobilenumber = 'mobilenumber';
  static const String gender = 'gender';
  static const String role = 'role';
}

class User {
  final int? id;
  final String? firstname;
  final String? lastname;
  final String? mobilenumber;
  final String? gender;
  final String? role;

  const User({
    this.id,
    required this.firstname,
    required this.lastname,
    required this.mobilenumber,
    required this.gender,
    required this.role,
  });

  User copy({
    int? id,
    String? firstname,
    String? lastname,
    String? mobilenumber,
    String? gender,
    String? role,
  }) =>
      User(
        id: id ?? this.id,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        mobilenumber: mobilenumber ?? this.mobilenumber,
        gender: gender ?? this.gender,
        role: role ?? this.role,
      );

  static User fromJson(Map<String, Object?> json) => User(
        id: json[UserFields.id] as int?,
        firstname: json[UserFields.firstname] as String?,
        lastname: json[UserFields.lastname] as String,
        mobilenumber: json[UserFields.mobilenumber] as String,
        gender: json[UserFields.gender] as String,
        role: json[UserFields.role] as String,
      );
  Map<String, Object?> toJson() => {
        UserFields.id: id,
        UserFields.firstname: firstname,
        UserFields.lastname: lastname,
        UserFields.mobilenumber: mobilenumber,
        UserFields.gender: gender,
        UserFields.role: role,
      };
}
