import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyxel/view_models/photos_view_model.dart';
import './views/home.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await DotEnv().load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme
        )
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => PhotosViewModel()) 
        ],
        builder: (context, child) => HomeView(),
      ),
    );
  }
}