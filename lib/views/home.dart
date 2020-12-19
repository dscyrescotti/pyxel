import 'package:flutter/material.dart';
import 'package:pyxel/views/collections_view.dart';
import 'package:pyxel/views/photos_view.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  int _selected = 0;
  final List<Widget> _children = [
    PhotosView(),
    CollectionsView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_selected],  
      bottomNavigationBar: BottomNavigationBar( 
        onTap: (value) {
          setState(() {
            _selected = value;
          });
        }, 
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: 'Photos'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.collections),
            label: 'Collections'
          )
        ],
      ),
    );
  }
}