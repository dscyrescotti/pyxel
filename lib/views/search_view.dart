import 'package:flutter/material.dart';
import 'package:pyxel/components/pop_button.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SearchView();
  }
}

class _SearchView extends StatefulWidget {
  _SearchView({Key key}) : super(key: key);

  @override
  __SearchViewState createState() => __SearchViewState();
}

class __SearchViewState extends State<_SearchView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(  
        slivers: [
          SliverAppBar(
            floating: true,
            elevation: 0,
            snap: true,
            backgroundColor: Colors.white,
            leading: PopButton(color: Colors.white,),
            // bottom: PreferredSize(  
            //   child: ,
            // ),
            title: TextField(
                autofocus: true,
                textAlign: TextAlign.start,
                decoration: InputDecoration.collapsed(
                  hintText: 'Search',
                ),
                onChanged: (value) {

                },
              ),
            actions: [
              IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(   
                  Icons.close,
                  size: 25,
                ),
                onPressed: () {},
              )
            ],
            textTheme: Theme.of(context).textTheme,
            bottom: PreferredSize(  
              child: Container(
                color: Colors.black.withOpacity(0.5),
                height: 0.4,
              ),
              preferredSize: Size.fromHeight(0.4),
            ),
            iconTheme: Theme.of(context).iconTheme,
            
          ),
        ],
      ),
    );
  }
}