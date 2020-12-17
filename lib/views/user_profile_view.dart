import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyxel/components/circular_progress.dart';
import 'package:pyxel/components/pop_button.dart';
import 'package:pyxel/view_models/user_profile_view_model.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({Key key, this.username}) : super(key: key);

  final String username;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(  
      create: (context) => UserProfileViewModel(username: username),
      child: _UserProfileView(),
    );
  }
}

class _UserProfileView extends StatefulWidget {
  _UserProfileView({Key key}) : super(key: key);

  @override
  __UserProfileViewState createState() => __UserProfileViewState();
}

class __UserProfileViewState extends State<_UserProfileView> {

  @override
  void initState() {
    super.initState();
    Provider.of<UserProfileViewModel>(context, listen: false).fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<UserProfileViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: PopButton(
          color: Colors.white,
        ),
        title: Text('Profile'),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
        elevation: 0,
        bottom: PreferredSize(  
          child: Container(
            color: Colors.black.withOpacity(0.5),
            height: 0.4,
          ),
          preferredSize: Size.fromHeight(0.4),
        ),
      ),
      body: viewModel.user == null ? CircularProgress() : DefaultTabController( 
        length: 3,
        child: NestedScrollView(
          physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    height: 100
                  )
                ]),
              )
            ];
          },
          body: Column(  
            children: [
              TabBar(
                labelColor: Colors.black,
                labelStyle: Theme.of(context).textTheme.button,
                tabs: [
                  Tab(  
                    text: 'Photos',
                  ),
                  Tab(  
                    text: 'Likes',
                  ),
                  Tab(  
                    text: 'Collections',
                  ),
                ],
              ),
              Expanded(  
                child: TabBarView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Text('Photos'),
                    Text('Likes'),
                    Text('Collections')
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}