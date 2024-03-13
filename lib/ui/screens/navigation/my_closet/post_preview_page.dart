import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:iconsax/iconsax.dart';

final _firestore = FirebaseFirestore.instance;

class PostPreviewPage extends StatefulWidget {
  PostPreviewPage({required this.currentCategory,required this.currentCategoryID});

  final String currentCategory;
  final String currentCategoryID;

  @override
  State<PostPreviewPage> createState() => _PostPreviewPageState();
}

class _PostPreviewPageState extends State<PostPreviewPage> {

  final _captionController = TextEditingController();
  String caption = "";
  XFile? selectedImageFile;
  String? imageURL;
  bool shouldSpin = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    var currTheme = Theme.of(context);
    return Scaffold(
      backgroundColor: currTheme.scaffoldBackgroundColor,
      appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: currTheme.appBarTheme.backgroundColor,
          title: Text('New Post Preview',style: TextStyle(fontSize: 34.0,color: currTheme.textTheme.titleLarge!.color),)
      ),
      body: LoadingOverlay(
        isLoading: shouldSpin,
        color: currTheme.textTheme.bodyMedium!.color,
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.0,right: 8.0,top: 16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage('https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg?cs=srgb&dl=pexels-james-wheeler-414612.jpg&fm=jpg'),
                    radius: 18.0,
                  ),
                  SizedBox(width: 12.0,),
                  Text('eashanTheBest@02',style: TextStyle(fontSize: 20.0,color: currTheme.textTheme.bodyMedium!.color),),
                  Spacer(),
                  Icon(Iconsax.more,color: currTheme.iconTheme.color,)
                ],
              ),
            ),
            SizedBox(height: 16.0,),
            AspectRatio(
              aspectRatio: 0.72,
              child: GestureDetector(
                onTap: () async{
                  selectedImageFile = (await ImagePicker.platform.getImageFromSource(source: ImageSource.gallery));
                  setState(() {

                  });
                  // if (selectedImageFile == null) return;
                },
                child: Container(
                  width: double.infinity,
                  color: Colors.grey.shade400,
                  child: (selectedImageFile == null) ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_rounded,color: currTheme.iconTheme.color,),
                      Text('Choose a Photo',style: TextStyle(color: currTheme.textTheme.bodyMedium!.color),)
                    ],
                  ) : Image(
                    width: double.infinity,
                    image: FileImage(File(selectedImageFile!.path)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: _captionController,
                      decoration: InputDecoration(
                          hintText: 'Enter a Caption',
                          hintStyle: TextStyle(
                              fontSize: 18.0,
                              color: currTheme.textTheme.bodyMedium!.color
                          )
                      ),
                      onChanged: (newValue){
                        setState(() {
                          caption = newValue;
                        });
                      },
                    ),
                  ),
                  GestureDetector(
                      onTap: () async{
                        setState(() {
                          shouldSpin = true;
                        });
                        _captionController.clear();
                        String fileName = DateTime.now().microsecondsSinceEpoch.toString();

                        Reference referenceRoot = FirebaseStorage.instance.ref();
                        Reference referencePostImages = referenceRoot.child('posts');

                        Reference referenceCurrentPost = referencePostImages.child(fileName);

                        try{
                          // await referenceCurrentPost.putFile(File(selectedImageFile!.path));
                          await referenceCurrentPost.putData(await selectedImageFile!.readAsBytes());
                          imageURL = await referenceCurrentPost.getDownloadURL();
                          // print('debug statement here : $imageURL');

                          _firestore.collection('userPosts').add({
                            'id' : DateTime.now().microsecondsSinceEpoch.toString(),
                            'user' : 'eashanTheBest@02',
                            'userProfileURL' : 'https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg?cs=srgb&dl=pexels-james-wheeler-414612.jpg&fm=jpg',
                            'postPicURL' : imageURL!,
                            'likes' : 0,
                            'comments' : 0,
                            'category' : widget.currentCategory,
                            'caption' : caption,
                            'timestamp' : DateTime.now().microsecondsSinceEpoch
                          });

                          _firestore.collection('Categories').doc(widget.currentCategoryID).update(
                              {
                                'numItems' : FieldValue.increment(1.0)
                              });
                          Navigator.pop(context);

                          setState(() {
                            shouldSpin = false;
                          });

                        } catch (e) {
                          print('Error occured : $e');
                        }
                      },
                      child: Icon(Icons.send,color: currTheme.iconTheme.color,)
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}