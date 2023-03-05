import 'package:encrypt/encrypt.dart';

class Crypto{
  // Generate Key Once Unique for every user.
  // static final key = Key.fromSecureRandom(32);
  // static final ivKey = IV.fromSecureRandom(16);

  final String key = "aPdRgUkXp2s5v8y/B?E(H+MbQeThVmYq";

  String decryptMyData(String encryptedData) {
    final cipherKey = Key.fromUtf8(key);
    final encryptService = Encrypter(AES(cipherKey, mode: AESMode.cbc));
    final initVector = IV.fromUtf8(key.substring(0, 16));
    // Using AES CBC encryption
    // final encryptService = Encrypter(AES(key, mode: AESMode.cbc));
    // final initVector = ivKey;
    //Here the IV is generated from key. This is for example only. Use some other text or random data as IV for better security.

    return encryptService.decrypt(Encrypted.fromBase64(encryptedData), iv: initVector);
  }

  ///Encrypts the given plainText using the key. Returns encrypted data
  String encryptMyData(String plainText) {
    final cipherKey = Key.fromUtf8(key);
    final encryptService = Encrypter(AES(cipherKey, mode: AESMode.cbc));
    final initVector = IV.fromUtf8(key.substring(0, 16)); //Here the IV is generated from key. This is for example only. Use some other text or random data as IV for better security.

    // final encryptService = Encrypter(AES(key, mode: AESMode.cbc));
    // final initVector = ivKey;

    Encrypted encryptedData = encryptService.encrypt(plainText, iv: initVector);
    return encryptedData.base64;
  }
}