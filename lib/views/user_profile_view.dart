import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pyxel/components/circular_progress.dart';
import 'package:pyxel/components/pop_button.dart';
import 'package:pyxel/view_models/user_profile_view_model.dart';
import '../models/user.dart';
import '../components/statistic_box.dart';
import '../utils/numeral.dart';
import 'package:waterfall_flow/waterfall_flow.dart';
import 'package:pyxel/components/image_card.dart';

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
  ScrollController controller;
  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    Provider.of<UserProfileViewModel>(context, listen: false).fetchUser();
    Provider.of<UserProfileViewModel>(context, listen: false).fetchPhotos();
    Provider.of<UserProfileViewModel>(context, listen: false).fetchLikes();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
        title: Text(viewModel.username),
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
          controller: controller,
          physics: BouncingScrollPhysics(),
          headerSliverBuilder: (context, _) {
            final user = viewModel.user;
            return [
              ProfileHeader(user: user)
            ];
          },
          body: Builder(
            builder: (context) {
              final user = viewModel.user;
              return Column(  
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
                        user.totalPhotos != 0 ? UserPhotoGridView(controller: controller,) : Center(child: Text('No photos'),),
                        user.totalLikes != 0 ? UserLikeGridView(controller: controller,) : Center(child: Text('No likes'),),
                        Text('Collections')
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      )
    );
  }
}



class UserPhotoGridView extends StatefulWidget {
  UserPhotoGridView({Key key, this.controller}) : super(key: key);

  final ScrollController controller;

  @override
  _UserPhotoGridViewState createState() => _UserPhotoGridViewState();
}

class _UserPhotoGridViewState extends State<UserPhotoGridView> with AutomaticKeepAliveClientMixin {

  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() {
      final innerPosition = _controller.position.pixels;
      final maxInnerPosition = _controller.position.maxScrollExtent;
      final maxOutterPosition = widget.controller.position.maxScrollExtent;
      final currentOutterPosition = widget.controller.position.pixels;
      if (innerPosition == maxInnerPosition) {
        print('[Photo]: reach the bottom');
        Provider.of<UserProfileViewModel>(context, listen: false).fetchPhotos();
      }
      if (innerPosition >= 0 && currentOutterPosition < maxOutterPosition) {
        widget.controller.position.jumpTo(innerPosition + currentOutterPosition);
      } else {
        var currenParentPos = innerPosition + currentOutterPosition;
        widget.controller.position.jumpTo(currenParentPos);
      }
    });
    widget.controller.addListener(() {
      final currentOutterPosition = widget.controller.position.pixels;
      if (currentOutterPosition <= 0) {
        _controller.position.jumpTo(0);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final viewModel = Provider.of<UserProfileViewModel>(context);
    return viewModel.photos.length == 0 ? Center(child: CircularProgress()) : WaterfallFlow.builder(
      physics: BouncingScrollPhysics(),
      controller: _controller,
      padding: EdgeInsets.all(10),
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: viewModel.photos.length,
      itemBuilder: (context, index) => ImageCard(photo: viewModel.photos[index]),
      cacheExtent: 1000,
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class UserLikeGridView extends StatefulWidget {
  UserLikeGridView({Key key, this.controller}) : super(key: key);

  final ScrollController controller;

  @override
  _UserLikeGridViewState createState() => _UserLikeGridViewState();
}

class _UserLikeGridViewState extends State<UserLikeGridView> with AutomaticKeepAliveClientMixin {

  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() {
      final innerPosition = _controller.position.pixels;
      final maxInnerPosition = _controller.position.maxScrollExtent;
      final maxOutterPosition = widget.controller.position.maxScrollExtent;
      final currentOutterPosition = widget.controller.position.pixels;
      if (innerPosition == maxInnerPosition) {
        print('[Like]: reach the bottom');
        Provider.of<UserProfileViewModel>(context, listen: false).fetchLikes();
      }
      if (innerPosition >= 0 && currentOutterPosition < maxOutterPosition) {
        widget.controller.position.jumpTo(innerPosition + currentOutterPosition);
      } else {
        var currenParentPos = innerPosition + currentOutterPosition;
        widget.controller.position.jumpTo(currenParentPos);
      }
    });
    widget.controller.addListener(() {
      final currentOutterPosition = widget.controller.position.pixels;
      if (currentOutterPosition <= 0) {
        _controller.position.jumpTo(0);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final viewModel = Provider.of<UserProfileViewModel>(context);
    return viewModel.likes.length == 0 ? Center(child: CircularProgress()) : WaterfallFlow.builder(
      physics: BouncingScrollPhysics(),
      controller: _controller,
      padding: EdgeInsets.all(10),
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: viewModel.likes.length,
      itemBuilder: (context, index) => ImageCard(photo: viewModel.likes[index]),
      cacheExtent: 1000,
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}

class StatisticRow extends StatelessWidget {
  const StatisticRow({
    Key key,
    @required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Row(  
        children: [
          StatisticBox(title: 'Photos', value: Numeral(user.totalPhotos).value(),),
          StatisticBox(title: 'Followers', value: Numeral(user.followersCount).value(),),
          StatisticBox(title: 'Following', value: Numeral(user.followingCount).value(),),
        ],
      ),
    );
  }
}


class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key key,
    @required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Container(
          padding: EdgeInsets.all(5),
          child: Column(  
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,  
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.grey,
                      child: CircleAvatar( 
                        radius: 35,
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(
                          user.profileImage.large
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(  
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text( 
                              user.name,
                              style: TextStyle(  
                                fontSize: Theme.of(context).textTheme.headline6.fontSize,
                                fontWeight: FontWeight.w600
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            Text( 
                              '@${user.username}',
                              style: TextStyle(  
                                fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
                                fontWeight: FontWeight.w500
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              StatisticRow(user: user),
              user.bio == null ? Container() : Container(
                width: double.infinity,  
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Column( 
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bio',
                      style: TextStyle(  
                        fontSize: Theme.of(context).textTheme.subtitle2.fontSize,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      user.bio,
                      style: Theme.of(context).textTheme.bodyText2
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}