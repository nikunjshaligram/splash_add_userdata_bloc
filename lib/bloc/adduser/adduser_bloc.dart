// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:splash_add_userdata_bloc/model/user.dart';
import 'package:splash_add_userdata_bloc/services/database_service.dart';

part 'adduser_event.dart';
part 'adduser_state.dart';

class AdduserBloc extends Bloc<AdduserEvent, AdduserState> {
  AdduserBloc() : super((UserInitial())) {
    List<User> users = [];

    on<selectGender>((event, emit) {
      emit(state.copyWith(isselectedgender: event.genderValue!));
    });

    on<selectRole>((event, emit) {
      emit(state.copyWith(isselectedrole: event.roleValue));
    });

    on<AddUser>((event, emit) async {
      await DatabaseService.instance.create(
        User(
            firstname: event.firstname,
            lastname: event.lastname,
            mobilenumber: event.mobilenumber,
            gender: event.gender,
            role: event.role),
      );
    });

    on<UpdateUser>((event, emit) async {
      await DatabaseService.instance.update(user: event.user);
    });

    on<FetchUsers>((event, emit) async {
      users = await DatabaseService.instance.readAllUsers();
      emit(DisplayUsers(user: users));
    });

    on<FetchSpecificUser>((event, emit) async {
      User user = await DatabaseService.instance.readUser(id: event.id);
      emit(DisplaySpecificUser(user: user));
    });

    on<DeleteUser>((event, emit) async {
      await DatabaseService.instance.delete(id: event.id);
      add(FetchUsers());
    });
  }
}
