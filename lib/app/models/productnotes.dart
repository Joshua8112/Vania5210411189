import 'package:vania/vania.dart';
import '../utils/generate_id.dart';

class ProductNotes extends Model {
  ProductNotes() {
    super.table('productnotes');
  }
  String generateId() {
    const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return Utils.generateId(5, characters);
  }
}