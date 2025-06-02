import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoRouterRefreshBloc<T extends StateStreamableSource>
    extends ChangeNotifier {
  GoRouterRefreshBloc(T bloc) {
    notifyOnChange(bloc);
  }

  void notifyOnChange(T bloc) {
    bloc.stream.listen((event) {
      notifyListeners();
    });
  }
}
