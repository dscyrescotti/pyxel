import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyxel/components/pop_button.dart';
import 'package:pyxel/view_models/search_view_model.dart';
import '../components/circular_progress.dart';
import '../components/image_card.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SearchPhotosViewModel()),
      ],
      builder: (context, child) => _SearchView(),
    );
  }
}

class _SearchView extends StatefulWidget {
  _SearchView({Key key}) : super(key: key);

  @override
  __SearchViewState createState() => __SearchViewState();
}

class __SearchViewState extends State<_SearchView> {
  TextEditingController _editingController;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: PopButton(color: Colors.white,),
          title: TextField(
              autofocus: _editingController.text.isEmpty,
              textAlign: TextAlign.start,
              controller: _editingController,
              decoration: InputDecoration.collapsed(
                hintText: 'Search',
              ),
              onSubmitted: (value) {
                search(value);
              },
            ),
          actions: [
              IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(   
                Icons.close,
                size: 25,
              ),
              onPressed: () {
                _editingController.text = '';
              },
            )
          ],
          textTheme: Theme.of(context).textTheme,
          bottom: TabBar(
            labelColor: Colors.black,
            labelStyle: Theme.of(context).textTheme.button,
            tabs: [
              Tab(  
                text: 'Photos',
              ),
              Tab(  
                text: 'Collections',
              ),
              Tab(  
                text: 'Users',
              ),
            ],
          ),
          iconTheme: Theme.of(context).iconTheme,
        ),
        body: TabBarView(  
          children: [
            SearchPhotosView(),
            Text('Collections'),
            Text('Users')
          ],
        )
      ),
    );
  }

  void search(String query) {
    Provider.of<SearchPhotosViewModel>(context, listen: false).initLoad(query);
  }
}

class SearchPhotosView extends StatefulWidget {
  SearchPhotosView({Key key}) : super(key: key);

  @override
  _SearchPhotosViewState createState() => _SearchPhotosViewState();
}

class _SearchPhotosViewState extends State<SearchPhotosView> {
  ScrollController _controller;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SearchPhotosViewModel>(context);
    print(viewModel.photos.length);
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: CustomScrollView(  
        controller: _controller,
        slivers: [
          SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: SliverWaterfallFlow(
              gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ImageCard(photo: viewModel.photos[index]);
                },
                childCount: viewModel.photos.length
              ),
            ),
          ),
          viewModel.photos.isNotEmpty ? SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: EdgeInsets.only(top: 5, bottom: 10),
                child: CircularProgress(),
              )
            ]),
          ) : viewModel.isInit ? SliverFillRemaining(
            hasScrollBody: false,
            child: CircularProgress()
          ) : SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text('Type something to search'),
            )
          )
        ],
      ),
    );
  }
  _scrollListener() {
    if (_controller.offset == _controller.position.maxScrollExtent && !_controller.position.outOfRange) {
      print("[Debug]: reach the bottom");
      Provider.of<SearchPhotosViewModel>(context, listen: false).searchPhotos();
    }
  }
  Future<void> _onRefresh() async {
    await Provider.of<SearchPhotosViewModel>(context, listen: false).searchPhotos(isRefresh: true);
  }
}