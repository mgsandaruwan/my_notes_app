import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

// Initialize Supabase (Replace with your credentials)
const supabaseUrl = "https://wrwhcnatqlyttpkoivgk.supabase.co";
const supabaseKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Indyd2hjbmF0cWx5dHRwa29pdmdrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Njc5NTIzODYsImV4cCI6MjA4MzUyODM4Nn0._Em5fINj9EaPgaqa3flBYGLVPNX27X_46uoLudqPrRc";


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );

  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note App',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      ),
      home: const NotesListScreen(),
    );
  }
}