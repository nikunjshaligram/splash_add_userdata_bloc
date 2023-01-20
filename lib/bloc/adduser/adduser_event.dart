// ignore_for_file: must_be_immutable, camel_case_types

part of 'adduser_bloc.dart';

class AdduserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class selectGender extends AdduserEvent {
  selectGender({this.genderValue});

  String? genderValue;

  @override
  List<Object?> get props => [genderValue!];
}

class selectRole extends AdduserEvent {
  selectRole({this.roleValue});

  String? roleValue;

  @override
  List<Object?> get props => [roleValue];
}

class AddUser extends AdduserEvent {
  final String? firstname;
  final String? lastname;
  final String? mobilenumber;
  final String? gender;
  final String? role;
  AddUser(
      {required this.firstname,
      required this.lastname,
      required this.mobilenumber,
      required this.gender,
      required this.role});

  @override
  List<Object?> get props => [firstname, lastname, mobilenumber, gender, role];
}

class UpdateUser extends AdduserEvent {
  final User user;
  UpdateUser({required this.user});
  @override
  List<Object?> get props => [user];
}

class FetchUsers extends AdduserEvent {
  FetchUsers();

  @override
  List<Object?> get props => [];
}

class FetchSpecificUser extends AdduserEvent {
  final int id;
  FetchSpecificUser({required this.id});

  @override
  List<Object?> get props => [id];
}

class DeleteUser extends AdduserEvent {
  final int id;
  DeleteUser({required this.id});
  @override
  List<Object?> get props => [id];
}
