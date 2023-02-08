import 'package:vault_007_3/model/passwords.dart';
import 'package:isar/isar.dart';
import 'package:flutter/material.dart';

class IsarService with ChangeNotifier{
  late Future<Isar> db;

  IsarService() {
    db = openIsar();
  }

  Future<Isar> openIsar() async {
    if(Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [PasswordsSchema],
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }

  Future<void> createPassword(Passwords newPassword) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.passwords.putSync(newPassword));
    notifyListeners();
  }

  Stream<List<Passwords>> listenToSearch(String search) async* {
    final isar = await db;
    yield* isar.passwords.where().filter().serviceNameContains(search, caseSensitive: false).watch(fireImmediately: true);
  }

  Stream<List<Passwords>> listenToPasswords() async* {
    final isar = await db;
    yield* isar.passwords.where().sortByServiceName().watch(fireImmediately: true);
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
    notifyListeners();
  }

  Future<List<Passwords>> getPasswords() async{
    final isar = await db;
    return await isar.passwords.where().findAll();
  }

  void deletePassword(int id) async{
    final isar = await db;
    await isar.writeTxn(() => isar.passwords.delete(id));
    notifyListeners();
  }

  Future<bool?> isNew(Passwords newPassword) async{
    final isar = await db;
    return await isar.passwords.filter().serviceNameEqualTo(newPassword.serviceName).isEmpty();
  }
}