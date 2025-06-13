import 'package:encrypt/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Crypto {
  static late final Key key;
  static late final IV ivKey;

  setKey(Key KEY) {
    key = KEY;
  }

  setIV(IV IVKEY) {
    ivKey = IVKEY;
  }

  void initKey() async {
    final sp = await SharedPreferences.getInstance();

    if (sp.containsKey("isKey")) {
      if (sp.getBool("isKey") == true) {
        setKey(Key.fromBase64(sp.getString("key")!));
        setIV(IV.fromBase64(sp.getString("ivKey")!));
      } else {
        setKey(Key.fromSecureRandom(32));
        setIV(IV.fromSecureRandom(16));
        sp.setString("key", key.base64);
        sp.setString("ivKey", ivKey.base64);
        sp.setBool("isKey", true);
      }
    } else {
      setKey(Key.fromSecureRandom(32));
      setIV(IV.fromSecureRandom(16));
      sp.setString("key", key.base64);
      sp.setString("ivKey", ivKey.base64);
      sp.setBool("isKey", true);
    }
  }

  String decryptMyData(String encryptedData) {
    final encryptService = Encrypter(AES(key, mode: AESMode.cbc));
    final initVector = ivKey;
    return encryptService.decrypt(Encrypted.fromBase64(encryptedData),
        iv: initVector);
  }

  String generatePassword(String hint) {
    if (hint != "") {
      return Key.fromUtf8(encryptMyData(encryptMyData(hint)))
          .base64
          .toString()
          .substring(42, 58);
    }
    return "";
  }

  String encryptMyData(String plainText) {
    final encryptService = Encrypter(AES(key, mode: AESMode.cbc));
    final initVector = ivKey;
    Encrypted encryptedData = encryptService.encrypt(plainText, iv: initVector);
    return encryptedData.base64;
  }
}
