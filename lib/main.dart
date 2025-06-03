import 'package:bloc_learn/blocs/auth_bloc.dart';
import 'package:bloc_learn/blocs/block.dart';
import 'package:bloc_learn/config/app_logger.dart';
import 'package:bloc_learn/config/app_router.dart';
import 'package:bloc_learn/repositories/repositories.dart';
import 'package:bloc_learn/services/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await HiveService.init();
//
//   final authRepository = AuthRepository();
//   final authBloc = AuthBloc(authRepository);
//   runApp(MyApp(authRepository: authRepository, authBloc: authBloc));
// }
//
// class MyApp extends StatelessWidget {
//   final AuthRepository authRepository;
//   final AuthBloc authBloc;
//   const MyApp({
//     super.key,
//     required this.authRepository,
//     required this.authBloc,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       routerConfig: AppRouter(authBloc: authBloc).router,
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();

  final authRepository = AuthRepository();
  final authBloc = AuthBloc(authRepository);
  authBloc.add(CheckAuthStatus());

  AppLogger.i("auth bloc $authBloc");
  final appRouter = AppRouter(authBloc: authBloc);

  runApp(
    BlocProvider.value(value: authBloc, child: MyApp(router: appRouter.router)),
  );
}

class MyApp extends StatelessWidget {
  final GoRouter router;
  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
