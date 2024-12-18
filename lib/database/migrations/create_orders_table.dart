import 'package:vania/vania.dart';

class CreateOrdersTable extends Migration {

  @override
  Future<void> up() async{
   super.up();
   await createTableNotExists('orders', () {
      bigInt('order_num');
      primary('order_num');
      date('order_date');
      char('cust_id', length: 5);
      foreign('cust_id', 'customers', 'cust_id', constrained: true, onDelete: 'CASCADE');
      timeStamps();
    });
  }
  
  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('orders');
  }
}