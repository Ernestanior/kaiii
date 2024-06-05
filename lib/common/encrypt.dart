import 'package:encrypt/encrypt.dart';

String encrypt(String plainText) {
  const keyString = "asklg3hi^#xjvAk4";
  final key = Key.fromUtf8(keyString);
  final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
  final initVector = IV.fromUtf8("ASDFGH0123456789");
  Encrypted encryptedData = encrypter.encrypt(plainText, iv: initVector);
  return encryptedData.base16;
}
