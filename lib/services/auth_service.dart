import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    await supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'name': name, // Store name in user metadata
      },
    );
  }

  Future<void> signIn(String email, String password) async {
    await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  // Get current user's name
  String? getCurrentUserName() {
    final user = supabase.auth.currentUser;
    return user?.userMetadata?['name'] as String?;
  }
}