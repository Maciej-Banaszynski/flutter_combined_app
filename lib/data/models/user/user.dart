import 'package:freezed_annotation/freezed_annotation.dart';

import '../../drift/drift_db.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String firstName,
    required String lastName,
    required DateTime birthDate,
    required String address,
    String? photo,
    required String phoneNumber,
    required String position,
    required String company,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  factory User.fromData(UserTableData data) {
    return User(
      id: data.id,
      firstName: data.firstName,
      lastName: data.lastName,
      birthDate: data.birthDate,
      address: data.address,
      photo: data.photo,
      phoneNumber: data.phoneNumber,
      position: data.position,
      company: data.company,
    );
  }
}
