import 'package:vania/vania.dart';
import 'package:vaniajoshuabackend/app/models/customers.dart';

class CustomerController extends Controller {
  Future<Response> daftarPelanggan() async {
    try {
      var hasilQuery = await Customers()
          .query()
          .join('orders', 'customers.cust_id', '=', 'orders.cust_id')
          .join('orderitems', 'orders.order_num', '=', 'orderitems.order_num')
          .get();

      Map<String, dynamic> dataPelanggan = {};
      for (var record in hasilQuery) {
        String pelangganId = record['cust_id'];

        if (!dataPelanggan.containsKey(pelangganId)) {
          dataPelanggan[pelangganId] = {
            'cust_id': record['cust_id'],
            'cust_name': record['cust_name'],
            'cust_address': record['cust_address'],
            'cust_city': record['cust_city'],
            'cust_zip': record['cust_zip'],
            'cust_country': record['cust_country'],
            'cust_telp': record['cust_telp'],
            'created_at': record['created_at'],
            'updated_at': record['updated_at'],
            'orders': []
          };
        }

        String nomorPesanan = record['order_num'].toString();
        var pesananAda = dataPelanggan[pelangganId]['orders'].firstWhere(
            (pesanan) => pesanan['order_num'].toString() == nomorPesanan,
            orElse: () => null);

        if (pesananAda == null) {
          pesananAda = {
            'order_num': record['order_num'],
            'order_date': record['order_date'],
            'created_at': record['created_at'],
            'updated_at': record['updated_at'],
            'order_items': []
          };

          dataPelanggan[pelangganId]['orders'].add(pesananAda);
        }

        pesananAda['order_items'].add({
          'order_item': record['order_item'],
          'prod_id': record['prod_id'],
          'quantity': record['quantity'],
          'size': record['size'],
          'created_at': record['created_at'],
          'updated_at': record['updated_at'],
        });
      }

      return Response.json({
        'success': true,
        'message': 'Data pelanggan berhasil diambil',
        'data': dataPelanggan.values.toList(),
      });
    } catch (error) {
      return Response.json({
        'success': false,
        'message': 'Terjadi kesalahan saat mengambil data pelanggan',
        'error': error.toString()
      });
    }
  }

  Future<Response> buatPelanggan() async {
    return Response.json({});
  }

  Future<Response> simpanPelanggan(Request request) async {
    try {
      var nama = request.input('name');
      var alamat = request.input('address');
      var kota = request.input('kota');
      var kodePos = request.input('zip');
      var negara = request.input('country');
      var telepon = request.input('telp');

      var idPelanggan = Customers().generateId();

      await Customers().query().insert({
        'cust_id': idPelanggan,
        'cust_name': nama,
        'cust_address': alamat,
        'cust_city': kota,
        'cust_zip': kodePos,
        'cust_country': negara,
        'cust_telp': telepon,
        'created_at': DateTime.now().toIso8601String(),
        'updated_at': DateTime.now().toIso8601String(),
      });

      var pelangganBaru = await Customers().query().where('cust_id', '=', idPelanggan).first();
      return Response.json({
        'success': true,
        'message': 'Pelanggan berhasil dibuat',
        'data': pelangganBaru
      });
    } catch (error) {
      return Response.json({
        'success': false,
        'message': 'Terjadi kesalahan saat membuat pelanggan',
        'error': error.toString()
      });
    }
  }

  Future<Response> tampilkanPelanggan(String id) async {
    try {
      var pelanggan = await Customers().query().where('cust_id', '=', id).first();

      if (pelanggan == null) {
        return Response.json({
          'success': false,
          'message': 'Pelanggan tidak ditemukan',
        });
      }
      return Response.json({
        'success': true,
        'message': 'Pelanggan ditemukan',
        'data': pelanggan,
      });
    } catch (error) {
      return Response.json({
        'success': false,
        'message': 'Terjadi kesalahan saat mengambil data pelanggan',
        'error': error.toString()
      });
    }
  }

  Future<Response> ubahPelanggan(Request request, String id) async {
    try {
      var nama = request.input('name');
      var alamat = request.input('address');
      var kota = request.input('kota');
      var kodePos = request.input('zip');
      var negara = request.input('country');
      var telepon = request.input('telp');

      await Customers().query().where('cust_id', '=', id).update({
        'cust_name': nama,
        'cust_address': alamat,
        'cust_city': kota,
        'cust_zip': kodePos,
        'cust_country': negara,
        'cust_telp': telepon,
        'updated_at': DateTime.now().toIso8601String(),
      });

      var pelangganTerbaru = await Customers().query().where('cust_id', '=', id).first();

      return Response.json({
        'success': true,
        'message': 'Pelanggan berhasil diperbarui',
        'data': pelangganTerbaru
      });
    } catch (error) {
      return Response.json({
        'success': false,
        'message': 'Terjadi kesalahan saat memperbarui pelanggan',
        'error': error.toString()
      });
    }
  }

  Future<Response> hapusPelanggan(String id) async {
    try {
      var pelanggan = await Customers().query().where('cust_id', '=', id).first();

      if (pelanggan == null) {
        return Response.json({
          'success': false,
          'message': 'Pelanggan tidak ditemukan',
        });
      }

      await Customers().query().where('cust_id', '=', id).delete();

      return Response.json({
        'success': true,
        'message': 'Pelanggan berhasil dihapus',
      });
    } catch (error) {
      return Response.json({
        'success': false,
        'message': 'Terjadi kesalahan saat menghapus pelanggan',
        'error': error.toString()
      });
    }
  }
}

final CustomerController customerController = CustomerController();
