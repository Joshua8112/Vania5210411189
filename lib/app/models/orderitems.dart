import 'package:vania/vania.dart';
import '../utils/generate_id.dart';

class OrderItems extends Model {
  OrderItems() {
    super.table('orderitems');
  }
    String generateId() {
    const characters = '0123456789';
    return Utils.generateId(11, characters);
  }
}
