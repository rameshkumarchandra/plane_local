import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plane_startup/provider/auth_provider.dart';

class ProviderList {
  static var userProvider =
      ChangeNotifierProvider<AuthProvider>((_) => AuthProvider());
}
