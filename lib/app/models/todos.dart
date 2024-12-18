import 'package:vania/vania.dart';
import '../utils/generate_id.dart';

class Todos extends Model {
  Todos() {
    super.table('todos');
  }
  String generateId() {
    const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return Utils.generateId(5, characters);
  }
}