import 'package:vania/vania.dart';
import 'package:vaniajoshuabackend/app/models/users.dart';

class AuthController extends Controller {
  Future<Response> register(Request request) async {
    request.validate({
      'name': 'required',
      'email': 'required|email',
      'password': 'required|min_length:6|confirmed',
    }, {
      'name.required': 'Name must be filled',
      'email.required': 'Email must be filled',
      'email.email': 'Email not valid',
      'password.required': 'Password must be filled',
      'password.min_length': 'Password must have 6 characters',
      'password.confirmed': 'Password Confirmation is incorrect',
    });
    final name = request.input('name');
    final email = request.input('email');
    var password = request.input('password');
    var user = await Users().query().where('email', '=', email).first();
    if (user != null) {
      return Response.json({
        "message": "User already Register",
      },409);
    }
    String userId = Users().generateId();
    password = Hash().make(password);
    await Users().query().insert({
      "id": userId,
      "name": name,
      "email": email,
      "password": password,
      "created_at": DateTime.now().toIso8601String(),
    });
    return Response.json({
      "message": "Register Successfull"
      },201);
  }
  Future<Response> login(Request request) async {
    request.validate({
      'email': 'required|email',
      'password': 'required',
    }, {
      'email.required': 'email must be filled',
      'email.email': 'email not valid',
      'password.required': 'Password must be filled',
    });

    final email = request.input('email');
    var password = request.input('password').toString();

    var user = await Users().query().where('email', '=', email).first();
    if (user == null) {
      return Response.json({
        "message": "user not register",
      }, 409);
    }

    if (!Hash().verify(password, user['password'])) {
      return Response.json({
        "message": "Password is incorrect",
      }, 401);
    }

    final token = await Auth()
      .login(user)
      .createToken(expiresIn: Duration(days: 30), withRefreshToken: true);
    return Response.json({
      "message": "Login Successfull",
      "token": token,
    });
  }
}

final AuthController authController = AuthController();

