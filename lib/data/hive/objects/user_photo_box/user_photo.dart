import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'user_photo.g.dart';

@HiveType(typeId: 1)
class UserPhoto extends HiveObject {
  @HiveField(0)
  final int userId;

  @HiveField(1)
  final Uint8List photoData;

  UserPhoto({required this.userId, required this.photoData});
}
