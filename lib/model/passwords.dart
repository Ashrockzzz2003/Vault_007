import 'package:isar/isar.dart';
part 'passwords.g.dart';

@Collection()

class Passwords {
  Id id = Isar.autoIncrement;
  late String? serviceName;
  late String? userName;
  late String? password;
  late DateTime? createdAt;
  late DateTime? updatedAt;
  late bool? isAutoGenerated;
  late String? hint;
  late List<String> tags;
}