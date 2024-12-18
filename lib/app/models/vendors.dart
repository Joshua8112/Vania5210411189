import 'package:vania/vania.dart';
import '../utils/generate_id.dart';

class Vendors extends Model {
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();

  Vendors() {
    super.table('vendors');
    createdAt = DateTime.now();
    updatedAt = DateTime.now();
  }

  String generateId() {
    const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return Utils.generateId(5, characters);
  }
}
