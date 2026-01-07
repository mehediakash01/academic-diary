import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://muqkribrdvqtuuaxtohz.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im11cWtyaWJyZHZxdHV1YXh0b2h6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njc3ODE2NzEsImV4cCI6MjA4MzM1NzY3MX0.TySdje1GrXe26H_eClYZvDS0BCy-aG-8tu4-OgyOpmY',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text('Supabase Connected'),
        ),
      ),
    );
  }
}
