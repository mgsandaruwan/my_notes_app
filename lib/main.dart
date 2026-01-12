import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Screens/NotesListScreen.dart';

const supabaseUrl = 'https://knnervorruznzsnytqjq.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtubmVydm9ycnV6bnpzbnl0cWpxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjgxMjAxNTgsImV4cCI6MjA4MzY5NjE1OH0.INDJ9iByPoO7sgna-tX8edIeCrEQpyFgf-LmUfd6ixI';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
