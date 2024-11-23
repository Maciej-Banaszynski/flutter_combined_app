import '../../../models/user/user.dart';

abstract interface class UserDaoInterface {
  Future<List<User>> getAllUsers();
  Future<List<User>> getAllUsersLeads();
  Future<int> insertUser(User user);
  Future<int> insertNewUser(User user);
  Future<void> insertUsers(List<User> users);
  Future<void> insertNewUsers(List<User> users);
  Future<void> updateUserPosition(int userId, String newPosition);
  Future<void> deleteUserById(int userId);
  Future<void> clearUserTable();
}
