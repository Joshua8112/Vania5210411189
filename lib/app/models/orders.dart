import 'package:vania/vania.dart';
import '../utils/generate_id.dart';

class Order extends Model {
  Order() {
    super.table('orders');
  }
  String generateId() {
    const characters = '0123456789';
    return Utils.generateId(11, characters);
  }
}