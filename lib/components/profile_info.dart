import 'package:flutter/material.dart';
import 'package:pyxel/models/user.dart';
import 'package:pyxel/views/user_profile_view.dart';
import 'package:pyxel/components/route_transition.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    Key key,
    @required this.color,
    @required this.user,
  }) : super(key: key);

  final Color color;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Row( 
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration( 
            shape: BoxShape.circle,
            color: color,
          ),
          child: ClipOval(
            child: InkWell(
              customBorder: RoundedRectangleBorder(  
                borderRadius: BorderRadius.circular(30)
              ),
              onTap: () {
                Navigator.of(context).push(SlideRoute(page: UserProfileView(username: user.username,)));
              },
              child: Image.network(
                user.profileImage.large
              ),
            ),
          ),
          margin: EdgeInsets.only(right: 10),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(SlideRoute(page: UserProfileView(username: user.username,)));
                },
                child: Text(
                  user.name,
                  style: TextStyle(  
                    fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
                    fontWeight: FontWeight.bold
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              InkWell( 
                onTap: () {
                  Navigator.of(context).push(SlideRoute(page: UserProfileView(username: user.username,)));
                }, 
                child: Text(
                  '@${user.username}',
                  style: TextStyle(  
                    fontSize: Theme.of(context).textTheme.subtitle2.fontSize,
                    fontWeight: FontWeight.normal
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}