import 'package:vania/vania.dart';
import '../utils/generate_id.dart';

class Customers extends Model{
  Customers(){
    super.table('customers');
  }
    String generateId() {
    const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return Utils.generateId(5, characters);
  }
}