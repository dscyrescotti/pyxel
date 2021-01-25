import 'package:flutter/material.dart';
import 'package:pyxel/views/collections_view.dart';
import 'package:pyxel/views/photos_view.dart';
import 'package:pyxel/views/search_view.dart';
import '../components/route_transition.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  int _selected = 0;
  final List<Widget> _children = [
    PhotosView(),
    CollectionsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('pyxel'),
        centerTitle: true,
        textTheme: Theme.of(context).textTheme,
        bottom: PreferredSize(  
          child: Container(
            color: Colors.black.withOpacity(0.5),
            height: 0.4,
          ),
          preferredSize: Size.fromHeight(0.4),
        ),
        actions: [
          Tooltip(
            message: 'Search',
            child: IconButton( 
              splashRadius: 28,
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.search,
                size: 25,
              ),
              onPressed: () {
                Navigator.push(context, SlideRoute(page: SearchView()));
              },
            ),
          )
        ],
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: IndexedStack(
        index: _selected,
        children: _children,
      ),  
      bottomNavigationBar: BottomNavigationBar( 
        currentIndex: _selected,
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