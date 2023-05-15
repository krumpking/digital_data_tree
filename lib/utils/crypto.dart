class Encryption {
  static String encrypt(String text, String key) {
    var encrypted = '';
    for (var i = 0; i < text.length; i++) {
      encrypted += String.fromCharCode(
          text.codeUnitAt(i) + key.codeUnitAt(i % key.length));
    }
    return encrypted;
  }

  static decrypt(String text, String key) {
    var decrypted = '';
    for (var i = 0; i < text.length; i++) {
      decrypted += String.fromCharCode(
          text.codeUnitAt(i) - key.codeUnitAt(i % key.length));
    }
    return decrypted;
  }
}
