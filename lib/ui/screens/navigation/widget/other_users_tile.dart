import 'package:closet_app/constants.dart';
import 'package:closet_app/ui/constants/style_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
// actual backend ke waqt 2 bool variables ( youFollowThem aur theyFollowYou ) se handle karne hai 3 cases : follow, follow back and unfollow

class OtherUsersTile extends StatefulWidget {
  OtherUsersTile(
      {required this.username,
      required this.emailID,
      required this.alreadyFollowing});

  final String username;
  final String emailID;
  final bool alreadyFollowing;

  @override
  State<OtherUsersTile> createState() => _OtherUsersTileState();
}

class _OtherUsersTileState extends State<OtherUsersTile> {
  @override
  Widget build(BuildContext context) {
    var currTheme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage(
                  'https://img.freepik.com/premium-photo/curve-road-mountain-landscape_608451-1544.jpg'),
            ),
          ),
          SizedBox(width: 10.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.username,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              Text(
                widget.emailID,
                style: TextStyle(fontSize: 14.0, color: Colors.grey.shade600),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(
                          color: widget.alreadyFollowing
                              ? Colors.grey.shade600
                              : kSecondaryColor),
                    ),
                    height: 40,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        foregroundColor: MaterialStateProperty.all(
                            widget.alreadyFollowing
                                ? Colors.grey.shade600
                                : kSecondaryColor),
                        overlayColor: MaterialStateProperty.all(
                            widget.alreadyFollowing
                                ? Colors.grey.shade600
                                : kSecondaryColor),
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(
                            widget.alreadyFollowing
                                ? Iconsax.close_square
                                : Iconsax.add_square,
                            color: widget.alreadyFollowing
                                ? Colors.grey.shade600
                                : kSecondaryColor,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Text(
                            widget.alreadyFollowing
                                ? 'Unfollow'
                                : 'Follow Back',
                            style: TextStyle(
                                color: widget.alreadyFollowing
                                    ? Colors.grey.shade600
                                    : kSecondaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(
                            Iconsax.send_1,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Message',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
            ],
          ),
        ],
      ),
    );
  }
}
