import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ExpandedStoryScreen extends StatefulWidget {
  ExpandedStoryScreen({required this.username,required this.userImageURL,required this.storyImageURL,this.likes,this.comments});

  final String username;
  final String storyImageURL;
  final String userImageURL;
  final int? likes;
  final int? comments;

  @override
  State<ExpandedStoryScreen> createState() => _ExpandedStoryScreenState();
}

class _ExpandedStoryScreenState extends State<ExpandedStoryScreen> {

  String value = "";
  final _commentController = TextEditingController();
  final _scrollController = ScrollController();
  List<Text> comments = [
    for (int i = 1;i<6;++i)
      Text('Comment No. $i made by User no. $i',style: TextStyle(fontSize: 16.0),)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 50.0,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        leading: Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(widget.userImageURL),
          ),
        ),
        title: Text(widget.username,style: TextStyle(fontSize: 36.0,fontFamily: 'Philosopher'),),
        centerTitle: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.close,size: 30.0,)
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: ListView(
          children: [
            AspectRatio(
              aspectRatio: (widget.likes == null ) ? MediaQuery.of(context).size.width/(MediaQuery.of(context).size.height-120.0) : 0.7,
              child: Container(
                  width: double.infinity,
                  // height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.storyImageURL),
                          fit: BoxFit.fill
                      )
                  ),
                  child: SizedBox.shrink()
              ),
            ),
            if (widget.comments != null && widget.likes != null)
            Column(
              children: [
                SizedBox(height: 16.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(Iconsax.heart),
                        SizedBox(width: 8.0,),
                        Text('${widget.likes}'),
                      ],
                    ),
                    SizedBox(width: 16.0,),
                    Row(
                      children: [
                        Icon(Iconsax.message),
                        SizedBox(width: 8.0,),
                        Text('${widget.comments}')
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 6.0,),
                Divider(color: Colors.black,),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: ListView(
                        shrinkWrap: true,
                        children: comments,
                        reverse: true,
                      ),
                    ),
                    Divider(color: Colors.black,height: 8.0,),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: TextField(
                              controller: _commentController,
                              decoration: InputDecoration(
                                  hintText: 'Enter your comment',
                                  labelStyle: TextStyle(color: Colors.black)
                              ),
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              onChanged: (newValue){
                                setState(() {
                                  value = newValue;
                                  // print(value);
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                              onTap: (){
                                _commentController.clear();
                                setState(() {
                                  comments.add(Text(value,style: TextStyle(fontSize: 16.0),));
                                });
                              },
                              child: Icon(Icons.send)
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ]
        ),
      ),
    );
  }
}