// ignore_for_file: must_be_immutable, non_constant_identifier_names, unnecessary_type_check

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splash_add_userdata_bloc/bloc/adduser/adduser_bloc.dart';
import 'package:splash_add_userdata_bloc/bloc/validation/validation_bloc.dart';
import 'package:splash_add_userdata_bloc/model/user.dart';
import 'package:splash_add_userdata_bloc/presentation/widget/sizebox.dart';

class AddUserScreen extends StatefulWidget {
  AddUserScreen({super.key, this.user});
  User? user;

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  TextEditingController firstnamecontroller = TextEditingController();
  TextEditingController lastnamecontroller = TextEditingController();
  TextEditingController mobilenumbercontroller = TextEditingController();
  ValidationBloc? validationBloc;
  final formKey = GlobalKey<FormState>();
  String? genderValue;
  String? selectroleValue;

  @override
  void initState() {
    super.initState();
    if (widget.user?.id != null) {
      firstnamecontroller.text = widget.user!.firstname.toString();
      lastnamecontroller.text = widget.user!.lastname.toString();
      mobilenumbercontroller.text = widget.user!.mobilenumber.toString();
      genderValue = widget.user?.gender.toString();
      selectroleValue = widget.user?.role.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    validationBloc = BlocProvider.of<ValidationBloc>(context);

    Widget firstname_widget(state) {
      return TextFormField(
        controller: firstnamecontroller,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 0.0),
          ),
          hintText: 'Enter your First name',
          labelText: 'First Name',
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter First Name";
          }
          return null;
        },
        onChanged: (value) {},
      );
    }

    Widget lastname_widget() {
      return TextFormField(
        controller: lastnamecontroller,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter your Last name',
          labelText: 'Last Name',
        ),
        onChanged: (value) {},
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter Last Name";
          }
          return null;
        },
      );
    }

    Widget mobilenumber_widget() {
      return TextFormField(
        controller: mobilenumbercontroller,
        keyboardType: TextInputType.number,
        maxLength: 10,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter your Mobile Number',
          labelText: 'Mobile Number',
          counterText: "",
        ),
        onChanged: (value) {},
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter Mobile Number";
          }
          return null;
        },
      );
    }

    Widget gender_txt_widget() {
      return const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Gender',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      );
    }

    Widget gender_selection_widget(state) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Text(state.male ?? genderValue),
                value: "Male",
                groupValue: genderValue,
                onChanged: (value) {
                  genderValue = value.toString();
                  context.read<AdduserBloc>().add(
                        selectGender(
                          genderValue: value!.toString(),
                        ),
                      );
                },
              ),
              RadioListTile(
                contentPadding: const EdgeInsets.all(0),
                title: Text(state.female! ?? genderValue),
                value: "Female",
                groupValue: genderValue,
                onChanged: (value) {
                  genderValue = value.toString();
                  context.read<AdduserBloc>().add(
                        selectGender(
                          genderValue: value!.toString(),
                        ),
                      );
                },
              ),
            ],
          ),
        ),
      );
    }

    Widget role_txt_widget() {
      return const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Role',
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      );
    }

    Widget role_selection_widget(state) {
      return DropdownButtonHideUnderline(
        child: DropdownButtonFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          value: selectroleValue,
          hint: const Text("Select Role"),
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          onChanged: (newValue) {
            selectroleValue = newValue.toString();
            context
                .read<AdduserBloc>()
                .add(selectRole(roleValue: newValue!.toString()));
          },
          validator: (value) {
            if (value == null) {
              return "Please Select Role";
            }
            return null;
          },
          items: state.selectrole.map<DropdownMenuItem<String>>(
            (String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            },
          ).toList(),
        ),
      );
    }

    Widget btn_submit(state) {
      return BlocBuilder<AdduserBloc, AdduserState>(
        builder: (context, state) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: const Size(250, 40)),
            child: const Text('Submit'),
            onPressed: () {
              if (genderValue == "" || genderValue == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Please Select Gender."),
                  ),
                );
              } else if (formKey.currentState!.validate()) {
                if (widget.user?.id == null) {
                  context.read<AdduserBloc>().add(
                        AddUser(
                          firstname: firstnamecontroller.text,
                          lastname: lastnamecontroller.text,
                          mobilenumber: mobilenumbercontroller.text,
                          gender: state.isselectedgender,
                          role: state.isselectedrole,
                        ),
                      );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(seconds: 1),
                      content: Text("User added successfully"),
                    ),
                  );
                  context.read<AdduserBloc>().add(FetchUsers());
                  Navigator.pop(context);
                }
              } else {
                context.read<AdduserBloc>().add(
                      UpdateUser(
                        user: User(
                          id: widget.user?.id,
                          firstname: firstnamecontroller.text,
                          lastname: lastnamecontroller.text,
                          mobilenumber: mobilenumbercontroller.text,
                          gender: genderValue,
                          role: selectroleValue,
                        ),
                      ),
                    );
              }
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.black,
                duration: Duration(seconds: 1),
                content: Text('Todo details updated'),
              ));
              Navigator.of(context).popUntil((route) => route.isFirst);
              context.read<AdduserBloc>().add(FetchUsers());
            },
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Players"),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              context.read<AdduserBloc>().add(FetchUsers());
              Navigator.pop(context);
            }
            //  Navigator.of(context).pop(),
            ),
      ),
      body: BlocBuilder<AdduserBloc, AdduserState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    firstname_widget(state),
                    commonwidget().sizebox_height_15(),
                    // error_text(),
                    lastname_widget(),
                    commonwidget().sizebox_height_15(),
                    mobilenumber_widget(),
                    commonwidget().sizebox_height_15(),
                    gender_txt_widget(),
                    commonwidget().sizebox_height_15(),
                    gender_selection_widget(state),
                    commonwidget().sizebox_height_15(),
                    role_txt_widget(),
                    commonwidget().sizebox_height_15(),
                    role_selection_widget(state),
                    commonwidget().sizebox_height_15(),
                    commonwidget().sizebox_height_15(),
                    commonwidget().sizebox_height_15(),
                    btn_submit(state)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
