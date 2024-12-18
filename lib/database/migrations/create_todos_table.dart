import 'package:vania/vania.dart';

class CreateTodosTable extends Migration {

  @override
  Future<void> up() async{
   super.up();
   await createTableNotExists('todos', () {
      id();
      bigInt('user_id', unsigned: true);
      foreign('user_id', 'users', 'id');
      string('title');
      text('desciption');
      timeStamps();
    });
  }
  
  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('todos');
  }
}
