import 'package:quizhub/core/common/entities/user.dart';

class HomeUserSession {
  const HomeUserSession._();

  static int? userId(User? user) {
    return int.tryParse(user?.id ?? '');
  }
}
