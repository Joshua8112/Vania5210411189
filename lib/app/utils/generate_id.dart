import 'dart:math';

class Utils {
  static String generateId(int length, String characters) {
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(
      length,
      (_) => characters.codeUnitAt(random.nextInt(characters.length)),
    ));
  }
}