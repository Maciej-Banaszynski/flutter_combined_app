import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'dao/user_dao/user_dao.dart';
import 'tables/user_table.dart';

part 'drift_db.g.dart';

@DriftDatabase(tables: [UserTable], daos: [UserDao])
class DriftDb extends _$DriftDb {
  factory DriftDb.instance() => _instance;

  static final DriftDb _instance = DriftDb._private();

  DriftDb._private() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
