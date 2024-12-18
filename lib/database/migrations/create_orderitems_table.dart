import 'package:vania/vania.dart';

class CreateOrderitemsTable extends Migration {

  @override
  Future<void> up() async{
   super.up();
   await createTableNotExists('orderitems', () {
      bigInt('order_item', length: 11);
      primary('order_item');
      bigInt('order_num', length: 11);
      foreign('order_num', 'orders', 'order_num', constrained: true, onDelete: 'CASCADE');
      string('prod_id', length: 10);
      foreign('prod_id', 'products', 'prod_id', constrained: true, onDelete: 'CASCADE');
      integer('quantity', defaultValue: 0);
      integer('size',defaultValue: 0);
    });
  }
  
  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('orderitems');
  }
}