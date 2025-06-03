import 'package:bloc_learn/blocs/auth_event.dart';
import 'package:bloc_learn/blocs/auth_state.dart';
import 'package:bloc_learn/config/app_logger.dart';
import 'package:bloc_learn/repositories/auth_repositories.dart';
import 'package:bloc_learn/services/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc(this._authRepository) : super(AuthInitial()) {
    // check the user is persists or not
    on<CheckAuthStatus>((event, emit) {
      final user = HiveService.userBox.get('currentUser');
      final myUsr = user?.toJson();
      AppLogger.i("user $user", "$myUsr");
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    });
    // started
    on<AppStarted>((event, emit) {
      final isAuth = _authRepository.isAuthenticated();
      if (isAuth) {
        final user = _authRepository.getCurrentUser();
        emit(Authenticated(user!));
      } else {
        emit(Unauthenticated());
      }
    });
    //   logged in
    on<LoggedIn>((event, emit) async {
      emit(AuthLoading());
      final user = await _authRepository.login(event.email, event.password);
      if (user != null) {
        emit(Authenticated(user));
      } else {
        AppLogger.i("invalid email");
        emit(AuthError("invalid email or password"));
      }
    });
    //   Logout
    on<LoggedOut>((event, emit) async {
      emit(AuthLoading());
      await _authRepository.logout();
      emit(Unauthenticated());
    });
  }
}
