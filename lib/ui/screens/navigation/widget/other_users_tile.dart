import 'package:flutter/material.dart';
// actual backend ke waqt 2 bool variables ( youFollowThem aur theyFollowYou ) se handle karne hai 3 cases : follow, follow back and unfollow

class OtherUsersTile extends StatefulWidget {
  OtherUsersTile({required this.username,required this.emailID,required this.alreadyFollowing});

  final String username;
  final String emailID;
  final bool alreadyFollowing;

  @override
  State<OtherUsersTile> createState() => _OtherUsersTileState();
}

class _OtherUsersTileState extends State<OtherUsersTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0),
      margin: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
      height: 140.0,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: Colors.grey.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5.0,
                blurRadius: 17.0,
                offset: Offset(0, 2)
            )
          ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('https://img.freepik.com/premium-photo/curve-road-mountain-landscape_608451-1544.jpg'),
            radius: 38.0,
          ),
          SizedBox(
              width: 10.0
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.username,style: TextStyle(fontSize: 23.0),),
              Text(widget.emailID,style: TextStyle(fontSize: 18.0),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(widget.alreadyFollowing ? 'Unfollow' : 'Follow Back',style: TextStyle(color: widget.alreadyFollowing ? Colors.redAccent : Colors.lightBlue,fontSize: 17.0,fontWeight: FontWeight.w600),),
                  SizedBox(width: 60.0),
                  Text('Chat',style: TextStyle(color: Colors.lightGreen,fontSize: 17.0,fontWeight: FontWeight.w600),),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}