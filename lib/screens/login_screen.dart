import 'package:bloc_learn/config/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:bloc_learn/blocs/block.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: Drawer(backgroundColor: Colors.black12),
//       appBar: AppBar(
//         backgroundColor: Colors.lightBlue,
//         title: Text("Bloc_demo"),
//       ),
//       body: Center(child: Column(children: [Text("Hello")])),
//     );
//   }
// }

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<AuthBloc>().add(
                  LoggedIn('piemahesh@gmail.com', 'mahesh@123'),
                );
                AppLogger.e("Pressed the button");
              },
              child: const Text('Login'),
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) return CircularProgressIndicator();
                if (state is AuthError) return Text(state.message);
                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
