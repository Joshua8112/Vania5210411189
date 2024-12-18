import 'package:vania/vania.dart';
import 'package:vaniajoshuabackend/app/models/products.dart'; 
import 'package:vaniajoshuabackend/app/models/productnotes.dart'; 

class ProductnotesController extends Controller {
  Future<Response> daftarPesan() async { 
    try { 
      var results = await ProductNotes() 
          .query() 
          .join('products', 'productnotes.prod_id', '=', 'products.prod_id') 
          .select(['productnotes.*', 'products.prod_name']).get(); 
       return Response.json({ 
        'success': true, 
        'message': 'Product notes ditemukan', 
        'data': results, 
      }); 
    } catch (e) { 
      return Response.json({ 
        'success': false, 
        'message': 'Gagal mendapatkan product notes', 
        'error': e.toString() 
      }); 
    } 
  } 
 
  Future<Response> buat() async { 
    return Response.json({}); 
  } 

  Future<Response> buatPesan(Request request) async { 
    try { 
      var productId = request.input('product_id'); 
      var isProductExist = await Product().query().where('prod_id', '=', productId).first(); 
      if (isProductExist == null) { 
        return Response.json({ 
          'success': false, 
          'message': 'Produk tidak ditemukan', 
        }); 
      } 
 
      var noteDate = request.input('date'); 
      var noteText = request.input('text'); 
 
      var productNoteId = ProductNotes().generateId(); 
      await ProductNotes().query().insert({ 
        'note_id': productNoteId, 
        'prod_id': isProductExist['prod_id'], 
        'note_date': noteDate, 
        'note_text': noteText, 
        'created_at': DateTime.now().toIso8601String(), 
        'updated_at': DateTime.now().toIso8601String(), 
      }); 

      var productNote = await ProductNotes() 
          .query() 
          .where('note_id', '=', productNoteId) 
          .first(); 
 
      return Response.json({ 
        'success': true, 
        'message': 'Berhasil membuat product note', 
        'data': productNote 
      }); 
    } catch (e) { 
      return Response.json({ 
        'success': false, 
        'message': 'Gagal untuk membuat product note', 
        'error': e.toString() 
      }); 
    } 
  } 
 
  Future<Response> tampilkanPesan(int id) async { 
    return Response.json({}); 
  } 
 
  Future<Response> ubah(int id) async { 
    return Response.json({}); 
  } 
 
  Future<Response> ubahPesan(Request request, String id) async 
{ 
    try { 
      var existingProductNote = await ProductNotes().query().where('note_id', '=', id).first(); 
      if (existingProductNote == null) { 
        return Response.json({ 
          'success': false, 
          'message': 'Product Note tidak ditemukan', 
        }); 
      } 
      var productId = request.input('product_id'); 
      if (productId != null && productId.isNotEmpty) { 
        var isProductExist = await Product().query().where('prod_id', '=', productId).first(); 
        if (isProductExist == null) { 
          return Response.json({ 
            'success': false, 
            'message': 'Produk tidak ditemukan',
          }); 
        } 
      } else { 
        productId = existingProductNote['prod_id']; 
      } 
 
      var noteDate = request.input('date'); 
      var noteText = request.input('text'); 
      await ProductNotes().query().where('note_id', '=', id).update({ 
        'prod_id': productId, 
        'note_date': noteDate, 
        'note_text': noteText, 
        'updated_at': DateTime.now().toIso8601String(), 
      }); 
 
      var productNote = await ProductNotes().query().where('note_id', '=', id).first(); 
 
      return Response.json({ 
        'success': true, 
        'message': 'Product Note berhasil diubah', 
        'data': productNote 
      }); 
    } catch (e) { 
      return Response.json({ 
        'success': false, 
        'message': 'Gagal mengubah product note', 
        'error': e.toString() 
      }); 
    } 
  } 
 
  Future<Response> hapusPesan(String id) async { 
    try { 
      var existingProductNote = await ProductNotes().query().where('note_id', '=', id).first(); 
      if (existingProductNote == null) { 
        return Response.json({ 
          'success': false, 
          'message': 'Product Note tidak ditemukan', 
        }); 
      } 
      await ProductNotes().query().where('note_id', '=', id).delete(); 
      return Response.json({ 
        'success': true, 
        'message': 'Product Note berhasi dihapus', 
      }); 
    } catch (e) { 
      return Response.json({ 
        'success': false, 
        'message': 'Gagal menghapus product note', 
        'error': e.toString() 
      }); 
    } 
  } 
} 

final ProductnotesController productnotesController = ProductnotesController();

