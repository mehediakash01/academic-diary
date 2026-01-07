import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/academic_record.dart';

class RecordService {
  final supabase = Supabase.instance.client;

  Future<List<AcademicRecord>> fetchRecords() async {
    final user = supabase.auth.currentUser;
    if (user == null) return [];

    final response = await supabase
        .from('academic_records')
        .select()
        .eq('user_id', user.id)
        .order('created_at', ascending: false);

    return (response as List)
        .map((e) => AcademicRecord.fromMap(e))
        .toList();
  }

  Future<void> addRecord({
    required String title,
    required String description,
    required String type,
  }) async {
    final user = supabase.auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    await supabase.from('academic_records').insert({
      'title': title,
      'description': description,
      'type': type,
      'user_id': user.id,
    });
  }

  Future<void> updateRecord({
    required String id,
    required String title,
    required String description,
    required String type,
  }) async {
    await supabase.from('academic_records').update({
      'title': title,
      'description': description,
      'type': type,
    }).eq('id', id);
  }

  Future<void> deleteRecord(String id) async {
    await supabase
        .from('academic_records')
        .delete()
        .eq('id', id);
  }
}