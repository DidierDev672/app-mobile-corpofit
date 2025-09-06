import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/presentation/provider/providers.dart';

final goRouterNotifierProvider = Provider((ref) {
  return GoRouterNotifier(ref);
});

class GoRouterNotifier extends ChangeNotifier {
  final Ref _ref;
  AuthStatus _authStatus = AuthStatus.cheking;

  GoRouterNotifier(this._ref) {
    _ref.listen<AuthState>(authProvider, (_, state) {
      _authStatus = state.status;
      notifyListeners();
    });
  }

  AuthStatus get authStatus => _authStatus;
}
