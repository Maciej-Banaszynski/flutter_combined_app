import '../../models/user/user.dart';

abstract interface class UserRepositoryInterface {
  Future<void> saveUserPhoto(User user, String imageUrl);
  Future<int> insertUser(User user);
  Future<void> insertUsers(List<User> users);
  Future<List<User>> getAllUsers();
  Future<void> deleteUserById(int userId);
  Future<void> deleteAllData();
  Future<void> generateAndInsertUsers(int count);
}