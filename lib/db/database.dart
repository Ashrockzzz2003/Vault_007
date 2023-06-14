import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vaultzerozeroseven_marktwo/model/passwords.dart';

class IsarService with ChangeNotifier {
  late Future<Isar> db;

  IsarService() {
    db = openIsar();
  }

  Future<Isar> openIsar() async {
    var databasePath = (await getApplicationDocumentsDirectory()).path;
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [PasswordsSchema],
        inspector: true,
        directory: databasePath,
      );
    }

    return Future.value(Isar.getInstance());
  }

  Stream<List<Passwords>> listenToPasswords() async* {
    final isar = await db;
    yield* isar.passwords
        .where()
        .sortByServiceName()
        .watch(fireImmediately: true);
  }

  Stream<List<Passwords>> listenToSearch(String search) async* {
    final isar = await db;
    yield* isar.passwords
        .where()
        .filter()
        .serviceNameContains(search, caseSensitive: false)
        .watch(fireImmediately: true);
  }

  Future<List<Passwords>> getPasswords() async {
    final isar = await db;
    return isar.passwords.where().findAllSync();
  }

  Future<void> createPassword(Passwords newPassword) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.passwords.putSync(newPassword));
    notifyListeners();
  }

  void deletePassword(int id) async {
    final isar = await db;
    await isar.writeTxn(() => isar.passwords.delete(id));
    notifyListeners();
  }

  Future<bool> isNew(String serviceName) async {
    final isar = await db;
    return await isar.passwords
        .filter()
        .serviceNameMatches(serviceName, caseSensitive: false)
        .isEmptySync();
  }

  Future<bool> isInvalidUpdate(
      String serviceName, String oldServiceName) async {
    if (oldServiceName == serviceName) {
      return false;
    }

    final isar = await db;
    return isar.passwords
        .filter()
        .serviceNameMatches(serviceName, caseSensitive: false)
        .findAllSync()
        .isNotEmpty;
  }

  Future<Passwords?> getExistingPassword(String serviceName) async {
    final isar = await db;
    return isar.passwords
        .filter()
        .serviceNameMatches(serviceName, caseSensitive: false)
        .findFirstSync();
  }
}
