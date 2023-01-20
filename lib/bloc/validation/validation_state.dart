part of 'validation_bloc.dart';

class ValidationState {
  final String firstname;
  final String lastname;
  final String mobilenumber;

  final String firstnameError;
  final String lastnameError;
  final String mobilenumberError;

  ValidationState({
    this.firstname = "",
    this.lastname = "",
    this.mobilenumber = "",
    this.firstnameError = "",
    this.lastnameError = "",
    this.mobilenumberError = "",
  });
}
