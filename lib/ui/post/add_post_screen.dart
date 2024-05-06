import 'dart:io';

import 'package:closet_app/constants.dart';
import 'package:closet_app/models/post_model.dart';
import 'package:closet_app/providers/user_provider.dart';
import 'package:closet_app/ui/constants/style_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  File? _image;
  bool postingEnabled = false;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLoading = false;
  final TextEditingController captionController = TextEditingController();

  Future pickImage() async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      pickedFile == null ? _image = null : _image = File(pickedFile.path);
      postingEnabled = _image != null;
    });
  }

  Future<void> sendPost() async {
    setState(() {
      isLoading = true;
    });
    if (_image != null) {
      final ref = storage.ref().child("posts").child(DateTime.now().toString());
      await ref.putFile(_image!);
      final url = await ref.getDownloadURL();
      final user = context.read<UserProvider>().appUser;
      final DocumentReference documentReference =
          await firestore.collection("posts").add(Post(
                postId: 'temp',
                caption: captionController.text,
                imageUrl: url,
                postedAt: Timestamp.now(),
                postedById: user!.id,
                postedByName: user.fullName ?? 'User',
                category: 'Generic',
                profilePfp: user.pfpUrl ?? 'https://via.placeholder.com/150',
              ).toMap());

      firestore.collection("posts").doc(documentReference.id).update({
        "postId": documentReference.id,
      }).whenComplete(() => Navigator.pop(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 64,
          title: Text("Add Post"),
          actions: [
            IgnorePointer(
              ignoring: !postingEnabled,
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: TextButton(
                  onPressed: () async {
                    await sendPost().whenComplete(() => Navigator.pop(context));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(postingEnabled
                        ? Colors.transparent
                        : Colors.grey.shade100),
                  ),
                  child: Text(
                    "Post",
                    style: TextStyle(
                        color: postingEnabled
                            ? Colors.black
                            : Colors.grey.shade500),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: _image == null
                      ? Container(
                          color: Colors.grey[200],
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.grey.shade600,
                                ),
                                onPressed: pickImage,
                              ),
                              Text("Add photo",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                  )),
                            ],
                          )),
                        )
                      : Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(right: 8, top: 4),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                                context.read<UserProvider>().appUser!.pfpUrl ??
                                    'https://via.placeholder.com/150'),
                          )),
                      Expanded(
                        child: TextField(
                          controller: captionController,
                          decoration: InputDecoration(
                              hintText: "Enter caption here",
                              border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            IgnorePointer(
              ignoring: !isLoading,
              child: AnimatedOpacity(
                duration: kDurationMedium,
                opacity: isLoading ? 1 : 0,
                child: Container(
                  color: Colors.white.withOpacity(0.9),
                  child: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
