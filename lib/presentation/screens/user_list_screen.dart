import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:splash_add_userdata_bloc/bloc/adduser/adduser_bloc.dart';
import 'package:splash_add_userdata_bloc/presentation/screens/add_user_screen.dart';
import 'package:splash_add_userdata_bloc/presentation/widget/sizebox.dart';

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Players List"),
      ),
      body: BlocBuilder<AdduserBloc, AdduserState>(
        builder: (context, state) {
          if (state is UserInitial) {
            context.read<AdduserBloc>().add(FetchUsers());
          }
          if (state is DisplayUsers) {
            return SafeArea(
              child: Container(
                padding: const EdgeInsets.all(8),
                height: MediaQuery.of(context).size.height,
                child: Column(children: [
                  const SizedBox(
                    height: 10,
                  ),
                  state.user.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.all(0),
                            itemCount: state.user.length,
                            itemBuilder: (context, i) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 14),
                                child: Card(
                                  elevation: 10,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Row(
                                          children: [
                                            Text(
                                              state.user[i].firstname!
                                                  .toUpperCase(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            commonwidget().sizebox_width_10(),
                                            Text(
                                              state.user[i].lastname!
                                                  .toUpperCase(),
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.user[i].mobilenumber!,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              state.user[i].gender!,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                            Text(
                                              state.user[i].role!,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            )
                                          ],
                                        ),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: ((context) =>
                                                        AddUserScreen(
                                                          user: state.user[i],
                                                        )),
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Colors.green,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                context.read<AdduserBloc>().add(
                                                      DeleteUser(
                                                        id: state.user[i].id!,
                                                      ),
                                                    );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    duration: Duration(
                                                        milliseconds: 500),
                                                    content:
                                                        Text("deleted User"),
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : const Center(
                          child: Text('No User Found.'),
                        ),
                ]),
              ),
            );
          }
          return Container(
            color: Colors.white,
            child: const Center(child: CircularProgressIndicator()),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 5,
        onPressed: (() {
          context.read<AdduserBloc>().add(FetchUsers());
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => AddUserScreen()),
            ),
          );
        }),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
