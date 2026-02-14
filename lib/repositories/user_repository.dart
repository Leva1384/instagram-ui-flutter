import '../data/data_constants.dart';
import '../models/user.dart';

class UserRepository {
  List<User> getUsers() {
    return DataConstants.users.map((e) => User.fromJson(e)).toList();
  }

  User? getUserById(int id) {
    for (final user in getUsers()) {
      if (user.userId == id) return user;
    }
    return null;
  }

  User getMe() {
    return getUserById(1)!;
  }
}
