import 'package:devfestapp/ui/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevFest Abuja 2022',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ).copyWith(
          headline3: GoogleFonts.luckiestGuy(
            textStyle: Theme.of(context).textTheme.headline3!,
          ),
          headline5: GoogleFonts.pacifico(
            textStyle: Theme.of(context).textTheme.headline5!,
          ),
        ),
      ),
      home: const HomeView(),
    );
  }
}
