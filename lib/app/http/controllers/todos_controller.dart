import 'package:vania/vania.dart';
import 'package:vaniajoshuabackend/app/models/todos.dart';

class TodosController extends Controller {
  Future<Response> index() async {
    return Response.json({'message': 'Hello World'});
  }

  Future<Response> store(Request request) async {
    request.validate({
      'title': 'required',
      'description': 'required',
    }, {
      'title.required': 'Title must be filled',
      'description.required': 'Description must be filled',
    });

    Map<String, dynamic> data = request.all();

    Map<String, dynamic>? user = Auth().user();

    if (user != null) {
      String todoId = Todos().generateId();
      var todos = await Todos().query().create({
        'id': todoId,
        'user_id': Auth().id(),
        'title': data['title'],
        'description': data['description'],
      });

      return Response.json({
        'status': 'success',
        'message': 'Your To Do is created successfull',
        'data': todos,
      }, 201);
    } else {
      return Response.json({
        'status': 'error',
        'message': 'User not authenticated',
      }, 401);
    }
  }
}

final TodosController todosController = TodosController();