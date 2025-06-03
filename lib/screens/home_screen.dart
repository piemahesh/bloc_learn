import 'package:bloc_learn/blocs/block.dart';
import 'package:bloc_learn/helper/destructure_helper.dart';
import 'package:bloc_learn/models/model.dart';
import 'package:bloc_learn/repositories/auth_repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(LoggedOut());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Authenticated) {
            User user = state.user;
            return ListView(
              padding: EdgeInsets.all(20),
              children: [
                Text("user name is ${user.name}"),
                Text("user email is ${user.email}"),
                Text("user id is ${user.id}"),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
