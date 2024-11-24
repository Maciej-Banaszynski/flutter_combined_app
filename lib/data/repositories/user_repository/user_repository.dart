import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:faker/faker.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../../drift/dao/user_dao/user_dao_interface.dart';
import '../../hive/objects/user_photo_box/user_photo.dart';
import '../../models/user/user.dart';
import 'user_repository_interface.dart';

class UserRepository implements UserRepositoryInterface {
  final UserDaoInterface _userDao;

  UserRepository(this._userDao);

  @override
  Future<List<User>> generateUsers(int count) async {
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

    return randomUsers;
  }

  @override
  Future<void> generateAndInsertUsers(int count) async {
    final randomUsers = await generateUsers(count);
    await _userDao.insertNewUsers(randomUsers);
  }

  @override
  Future<void> insertGeneratedUsers(GeneratedUsersCount count) async {
    final String csvString = await rootBundle.loadString(count.filePath);

    final List<List<dynamic>> csvData = const CsvToListConverter().convert(csvString);

    final users = csvData
        .skip(1)
        .map((row) => User(
              id: 0,
              firstName: row[0] as String,
              lastName: row[1] as String,
              birthDate: DateTime.parse(row[2] as String),
              address: row[3] as String,
              phoneNumber: row[4] is int ? row[4].toString() : row[4] as String,
              position: row[5] as String,
              company: row[6] as String,
            ))
        .toList();
    await _userDao.insertNewUsers(users);
  }

  @override
  Future<void> generateAndSaveUsers(int count) async {
    final faker = Faker();
    final randomUsers = List.generate(
      count,
      (index) => User(
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

    List<List<String>> csvData = [
      ['firstName', 'lastName', 'birthDate', 'address', 'phoneNumber', 'position', 'company'],
      ...randomUsers.map((user) => [
            user.firstName,
            user.lastName,
            user.birthDate.toIso8601String(),
            user.address,
            user.phoneNumber,
            user.position,
            user.company,
          ]),
    ];

    String dataToSave = const ListToCsvConverter().convert(csvData);

    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/fake_data.csv';
    final file = File(filePath);

    await file.writeAsString(dataToSave);

    print('CSV saved at: $filePath');
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
  Future<List<User>> getAllUsersLeads() => _userDao.getAllUsersLeads();

  @override
  Future<void> deleteUserById(int userId) => _userDao.deleteUserById(userId);

  @override
  Future<void> deleteAllData() async {
    await _userDao.clearUserTable();
    // final photoBox = await Hive.openBox('userPhoto');
    // await photoBox.clear();
  }
}
