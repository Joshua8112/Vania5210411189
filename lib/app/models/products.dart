import 'package:vania/vania.dart';
import '../utils/generate_id.dart';

class Product extends Model {
  Product() {
    super.table('products');
  }
    String generateId() {
    const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return Utils.generateId(5, characters);
  }
}