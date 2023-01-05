import 'package:isar/isar.dart';

part 'passwords.g.dart';

@Collection()
class Passwords{
  Id id = Isar.autoIncrement;
  late String? serviceName;
  late String? userName;
  late String? password;
}