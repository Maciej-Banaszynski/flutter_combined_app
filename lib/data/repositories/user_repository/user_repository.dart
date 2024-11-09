import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../../drift/dao/user_dao/user_dao_interface.dart';
import '../../hive/objects/user_photo_box/user_photo.dart';
import '../../models/user/user.dart';
import 'user_repository_interface.dart';

class UserRepository implements UserRepositoryInterface {
  final UserDaoInterface _userDao;

  UserRepository(this._userDao);

  @override
  Future<void> generateAndInsertUsers(int count) async {
    final faker = Faker();
    final randomUsers = List.generate(
      count,
      (_) => User(
        id: 0,
        firstName: faker.person.firstName(),
        lastName: faker.person.lastName(),
        birthDate: faker.date.dateTime(minYear: 1950, maxYear: 2000),
        address: faker.address.streetAddress(),
        phoneNumber: faker.phoneNumber.us(),
        position: faker.job.title(),
        company: faker.company.name(),
      ),
    );

    await _userDao.insertNewUsers(randomUsers);
  }

  @override
  Future<void> saveUserPhoto(User user, String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      final photoData = response.bodyBytes;
      final photoBase64 = base64Encode(photoData);

      await _userDao.updateUserPosition(user.id, photoBase64);

      final userPhoto = UserPhoto(userId: user.id, photoData: photoData);
      final photoBox = await Hive.openBox('userPhoto');
      await photoBox.put(user.id, userPhoto);

      print("Photo saved for user ID: ${user.id}");
    } else {
      print("Error downloading photo for user ID: ${user.id}");
    }
  }

  @override
  Future<int> insertUser(User user) => _userDao.insertUser(user);

  @override
  Future<void> insertUsers(List<User> users) => _userDao.insertUsers(users);

  @override
  Future<List<User>> getAllUsers() => _userDao.getAllUsers();

  @override
  Future<void> deleteUserById(int userId) => _userDao.deleteUserById(userId);

  @override
  Future<void> deleteAllData() async {
    await _userDao.clearUserTable();
    // final photoBox = await Hive.openBox('userPhoto');
    // await photoBox.clear();
  }
}
