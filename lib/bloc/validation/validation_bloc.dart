// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';

part 'validation_event.dart';
part 'validation_state.dart';

class ValidationBloc extends Bloc<ValidationEvent, ValidationState> {
  ValidationBloc() : super(ValidationState()) {
    on<ValidationEvent>((event, emit) {
      emit(
        ValidationState(
          firstname: event.firstname,
          lastname: event.lastname,
          mobilenumber: event.mobilenumber,
          firstnameError: (event.firstname.isEmpty)
              ? "This field should not be empty!"
              : "",
          lastnameError:
              (event.lastname.isEmpty) ? "This field should not be empty!" : "",
          mobilenumberError: (event.mobilenumber.isEmpty)
              ? "This field should not be empty!"
              : "",
        ),
      );
    });
  }
}
