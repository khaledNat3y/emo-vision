import 'package:supabase_flutter/supabase_flutter.dart';

class CrudService {
  final SupabaseClient _client;

  CrudService({required SupabaseClient client}) : _client = client;

  Future<Map<String, dynamic>> create({
    required String table,
    required Map<String, dynamic> data,
  }) async {
    try {
      return await _client.from(table).insert(data);
    } catch (e) {
      throw Exception('Failed to create data: $e');
    }
  }

  Future<List<Map<String, dynamic>>> read({
    required String table,
    String? columns,
    String? filterColumn,
    dynamic filterValue,
  }) async {
    try {
      var query = _client.from(table).select(columns ?? "*");
      if (filterColumn != null && filterValue != null) {
        query = query.eq(filterColumn, filterValue);
      }
      return await query;
    } catch (e) {
      throw Exception('Failed to read data: $e');
    }
  }

  Future<Map<String, dynamic>> update({
    required String table,
    required String idColumn,
    required dynamic id,
    required Map<String, dynamic> data,
  }) async {
    try {
      return await _client
          .from(table)
          .update(data)
          .eq(idColumn, id)
          .select()
          .single();
    } catch (e) {
      throw Exception('Failed to update data: $e');
    }
  }

  Future<void> delete({
    required String table,
    required String idColumn,
    required dynamic id,
  }) async {
    await _client.from(table).delete().eq(idColumn, id);
  }
}
