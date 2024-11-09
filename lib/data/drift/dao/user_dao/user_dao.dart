import 'package:drift/drift.dart';

import '../../../models/user/user.dart';
import '../../drift_db.dart';
import '../../tables/user_table.dart';
import 'user_dao_interface.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [UserTable])
class UserDao extends DatabaseAccessor<DriftDb> with _$UserDaoMixin implements UserDaoInterface {
  UserDao(super.db);

  @override
  Future<int> insertUser(User user) => into(userTable).insert(
        UserTableData(
          id: user.id,
          firstName: user.firstName,
          lastName: user.lastName,
          birthDate: user.birthDate,
          address: user.address,
          phoneNumber: user.phoneNumber,
          position: user.position,
          company: user.company,
        ),
        mode: InsertMode.insertOrReplace,
      );

  @override
  Future<int> insertNewUser(User user) => into(userTable).insert(UserTableCompanion.insert(
        firstName: user.firstName,
        lastName: user.lastName,
        birthDate: user.birthDate,
        address: user.address,
        photo: Value(user.photo),
        phoneNumber: user.phoneNumber,
        position: user.position,
        company: user.company,
      ));

  @override
  Future<List<User>> getAllUsers() async {
    final userRows = await select(userTable).get();
    return userRows.map((row) => User.fromData(row)).toList();
  }

  @override
  Future<void> insertUsers(List<User> users) async {
    await batch((batch) {
      batch.insertAll(
        userTable,
        users
            .map((user) => UserTableData(
                  id: user.id,
                  firstName: user.firstName,
                  lastName: user.lastName,
                  birthDate: user.birthDate,
                  address: user.address,
                  phoneNumber: user.phoneNumber,
                  position: user.position,
                  company: user.company,
                ))
            .toList(),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  @override
  Future<void> insertNewUsers(List<User> users) async {
    await batch((batch) {
      batch.insertAll(
        userTable,
        users
            .map((user) => UserTableCompanion.insert(
                  firstName: user.firstName,
                  lastName: user.lastName,
                  birthDate: user.birthDate,
                  address: user.address,
                  photo: Value(user.photo),
                  phoneNumber: user.phoneNumber,
                  position: user.position,
                  company: user.company,
                ))
            .toList(),
      );
    });
  }

  @override
  Future<void> updateUserPosition(int userId, String newPosition) async {
    await (update(userTable)..where((tbl) => tbl.id.equals(userId)))
        .write(UserTableCompanion(position: Value(newPosition)));
  }

  @override
  Future<void> deleteUserById(int userId) async {
    await (delete(userTable)..where((tbl) => tbl.id.equals(userId))).go();
  }

  @override
  Future<void> clearUserTable() async {
    await delete(userTable).go();
  }
}
