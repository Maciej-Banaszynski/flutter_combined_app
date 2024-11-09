import 'package:drift/drift.dart';

@DataClassName('UserTableData')
class UserTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get firstName => text().withLength(min: 1, max: 50)();
  TextColumn get lastName => text().withLength(min: 1, max: 50)();
  DateTimeColumn get birthDate => dateTime()();
  TextColumn get address => text().withLength(min: 1, max: 100)();
  TextColumn get photo => text().nullable()(); // Photo as Base64
  TextColumn get phoneNumber => text().withLength(min: 10, max: 30)();
  TextColumn get position => text().withLength(min: 1, max: 50)();
  TextColumn get company => text().withLength(min: 1, max: 100)();
}
