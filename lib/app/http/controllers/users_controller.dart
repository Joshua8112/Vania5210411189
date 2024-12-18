import 'package:vania/vania.dart';
import 'package:vaniajoshuabackend/app/models/users.dart';

class UsersController extends Controller {
  Future<Response> index() async {
    Map? user = Auth().user();

    if (user != null) {
      user.remove('password');
      return Response.json({
        'status': 'success',
        'message': 'User Data index successfull',
        'data': user,
      });
    } else {
      return Response.json({
        'status': 'error',
        'message': 'User not authenticated',
      }, 401);
    }
  }

  Future<Response> updatePassword(Request request) async {
    request.validate({
      'current_password': 'required',
      'password': 'required|min_length:6|confirmed'
    }, {
      'current_password.required': 'Current password must be filled',
      'password.required': 'New password must be filled',
      'password.min_length': 'New password must have 6 characters',
      'password.confirmed': 'Confirmation password must be filled',
    });

    String currentPassword = request.string('current_password');

    Map<String, dynamic>? user = Auth().user();

    if (user != null) {
      if (Hash().verify(currentPassword, user['password'])) {
        await Users().query().where ('id', '=', Auth().id()).update({
          'password': Hash().make(request.string('password')),
        });
        return Response.json({
          'status': 'success',
          'message': 'Password Updated',
        });
      } else {
        return Response.json({
          'status': 'error',
          'message': 'Current password not match',
        }, 401);
      }
    } else {
      return Response.json({
        'status': 'error',
        'message': 'User not found',
      }, 404);
    }
  }
}

final UsersController usersController = UsersController();