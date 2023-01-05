import 'package:encrypt/encrypt.dart';
import 'dart:convert';

class AutoGeneratePassword {
  AutoGeneratePassword({
    required this.hint,
  });

  String hint;

  String generatePassword(){
    const key = "Ed_KChj5Qv2WQYRNBAXn5qwflq48b248LVDCKHMeO9M=";
    final iv = IV.fromLength(16);

    final b64key = Key.fromBase64(key);
    final hash = Fernet(b64key);
    final encrypter = Encrypter(hash);

    String password = "Enter Hint...";
    if (hint != "") {
      password = (encrypter.encrypt(hint)).base64;
      password = password.substring(16, 32);
    }
    return password;
  }
}