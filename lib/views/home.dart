import 'package:flutter/material.dart';
import 'package:pyxel/view_models/photos_view_model.dart';
import 'package:pyxel/views/photos_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    print('[Home]: ${MediaQuery.of(context).size.width}');
    return ChangeNotifierProvider( 
      create: (context) => PhotosViewModel(),
      child: PhotosView(),
    );
  }
}