import 'package:vania/vania.dart';
import 'package:vaniajoshuabackend/app/http/controllers/customers_controller.dart';
import 'package:vaniajoshuabackend/app/http/controllers/orders_controller.dart';
import 'package:vaniajoshuabackend/app/http/controllers/products_controller.dart';
import 'package:vaniajoshuabackend/app/http/controllers/productnotes_controller.dart';
import 'package:vaniajoshuabackend/app/http/controllers/vendors_controller.dart';
import 'package:vaniajoshuabackend/app/http/controllers/users_controller.dart';
import 'package:vaniajoshuabackend/app/http/controllers/todos_controller.dart';
import 'package:vaniajoshuabackend/app/http/controllers/auth_controller.dart';
import 'package:vaniajoshuabackend/app/http/middleware/authenticate.dart';

class ApiRoute implements Route {
  @override
  void register() {
    Router.group((){
      Router.post('/register', authController.register);
      Router.post('/login', authController.login);
    }, prefix: '/auth');

    Router.group(() {
      Router.patch('/update-password', usersController.updatePassword);
      Router.get('/', usersController.index);
    }, prefix: '/user', middleware: [AuthenticateMiddleware()]);

    Router.group(() {
      Router.post('/todo', todosController.store);
    }, prefix: '/user', middleware: [AuthenticateMiddleware()]);

    Router.group(() { 
      Router.get('/', customerController.daftarPelanggan); 
      Router.post('/', customerController.simpanPelanggan); 
      Router.get('/{id}', customerController.tampilkanPelanggan); 
      Router.put('/{id}', customerController.ubahPelanggan); 
      Router.delete('/{id}', customerController.hapusPelanggan); 
    }, prefix: '/customers'); 

    Router.group(() { 
      Router.get('/', ordersController.daftarOrder); 
      Router.post('/', ordersController.simpanOrder); 
      Router.get('/{id}', ordersController.tampilkanOrder); 
      Router.delete('/{id}', ordersController.hapusOrder); 
    }, prefix: '/orders'); 
 
    Router.group(() { 
      Router.get('/', productsController.daftarProduk); 
      Router.post('/', productsController.buatProduk); 
      Router.get('/{id}', productsController.tampilkanProduk); 
      Router.put('/{id}', productsController.ubahProduk); 
      Router.delete('/{id}', productsController.hapusProduk); 
    }, prefix: '/products'); 
 
    Router.group(() { 
      Router.get('/', productnotesController.daftarPesan); 
      Router.post('/', productnotesController.buatPesan); 
      Router.get('/{id}', productnotesController.tampilkanPesan); 
      Router.put('/{id}', productnotesController.ubahPesan); 
      Router.delete('/{id}', productnotesController.hapusPesan); 
    }, prefix: '/product-notes'); 

    Router.group(() { 
      Router.get('/', vendorsController.daftarVendor); 
      Router.post('/', vendorsController.buatVendor); 
      Router.get('/{id}', vendorsController.tampilkanVendor); 
      Router.put('/{id}', vendorsController.ubahVendor); 
      Router.delete('/{id}', vendorsController.hapusVendor); 
    }, prefix: '/vendors'); 
  }
}
