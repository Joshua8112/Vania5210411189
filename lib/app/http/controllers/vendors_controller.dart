import 'package:vania/vania.dart';
import 'package:vaniajoshuabackend/app/models/vendors.dart'; 

class VendorsController extends Controller {
  Future<Response> daftarVendor() async { 
    try { 
      var vendors = await Vendors().query().get(); 
      return Response.json({ 
        'success': true, 
        'message': 'Vendors found', 
        'data': vendors, 
      }); 
    } catch (e) { 
      return Response.json({ 
        'success': false, 
        'message': 'Failed to get vendors', 
        'error': e.toString() 
      }); 
    } 
  } 
 
  Future<Response> buat() async { 
    return Response.json({}); 
  } 
 
  Future<Response> buatVendor(Request request) async { 
    var name = request.input('name'); 
    var address = request.input('address'); 
    var kota = request.input('kota'); 
    var state = request.input('state'); 
    var zip = request.input('zip'); 
    var country = request.input('country'); 
 
    try { 
      var vendId = Vendors().generateId(); 
 
      await Vendors().query().insert({ 
        'vend_id': vendId, 
        'vend_name': name, 
        'vend_address': address, 
        'vend_kota': kota, 
        'vend_state': state, 
        'vend_zip': zip, 
        'vend_country': country, 
        'created_at': DateTime.now().toIso8601String(), 
        'updated_at': DateTime.now().toIso8601String(), 
      }); 
 
      var vendor = await Vendors().query().where('vend_id', '=', vendId).first(); 
      return Response.json({ 
        'success': true, 
        'message': 'Vendor created successfully', 
        'data': vendor 
      }); 
    } catch (e) { 
      return Response.json({ 
        'success': false, 
        'message': 'Failed to create vendor', 
        'error': e.toString() 
      }); 
    } 
  } 
 
  Future<Response> tampilkanVendor(String id) async { 
    try { 
      var vendor = await Vendors().query().where('vend_id', '=', id).first(); 
      if (vendor == null) { 
        return Response.json({ 
          'success': false, 
          'message': 'Vendor not found', 
        }); 
      } 
      return Response.json( 
        {'success': true, 'message': 'Vendor found', 'data': vendor}, 
      ); 
    } catch (e) { 
      return Response.json({ 
        'success': false, 
        'message': 'Failed to get vendor', 
        'error': e.toString() 
      }); 
    } 
  } 
 
  Future<Response> ubah(int id) async { 
    return Response.json({}); 
  } 
 
  Future<Response> ubahVendor(Request request, String id) async { 
    try { 
      var vendor = await Vendors().query().where('vend_id', '=', id).first(); 
      if (vendor == null) { 
        return Response.json({ 
          'success': false, 
          'message': 'Vendor not found', 
        }); 
      } 
 
      var name = request.input('name'); 
      var address = request.input('address'); 
      var kota = request.input('kota'); 
      var state = request.input('state'); 
      var zip = request.input('zip'); 
      var country = request.input('country'); 
      await Vendors().query().where('vend_id', '=', id).update({ 
        'vend_name': name, 
        'vend_address': address, 
        'vend_kota': kota, 
        'vend_state': state, 
        'vend_zip': zip, 
        'vend_country': country, 
        'updated_at': DateTime.now().toIso8601String(), 
      }); 
 
      var updatedVendor = await Vendors().query().where('vend_id', '=', id).first(); 
 
      return Response.json({ 
        'success': true, 
        'message': 'Vendor updated successfully', 
        'data': updatedVendor 
      }); 
    } catch (e) { 
      return Response.json({ 
        'success': false, 
        'message': 'Failed to update vendor', 
        'error': e.toString() 
      }); 
    } 
  } 
 
  Future<Response> hapusVendor(String id) async { 
    try { 
      var vendor = await Vendors().query().where('vend_id', '=', id).first(); 
      if (vendor == null) { 
        return Response.json({ 
          'success': false, 
          'message': 'Vendor not found', 
        }); 
      } 
      await Vendors().query().where('vend_id', '=', id).delete(); 
      return Response.json({ 
        'success': true, 
        'message': 'Vendor deleted successfully', 
      }); 
    } catch (e) { 
      return Response.json({ 
        'success': false, 
        'message': 'Failed to delete vendor', 
        'error': e.toString() 
      }); 
    } 
  } 
} 

final VendorsController vendorsController = VendorsController();

