import 'dart:typed_data';

import 'package:closet_app/ui/screens/authentication/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({
    super.key,
  });

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  List<AssetEntity> assets = [];

  void getPhotos() async {
    PhotoManager.requestPermissionExtend();

    final albums = await PhotoManager.getAssetPathList(onlyAll: true);
    final recentAlbum = albums.first;
    final recentAlbumAssets =
        await recentAlbum.getAssetListPaged(page: 1, size: 1000);
    setState(() {
      assets = recentAlbumAssets;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios_new),
        title: Text("Upload your product"),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CustomButton(
              onPressed: () {},
              icon: Row(
                children: [
                  SizedBox(width: 16),
                  Text("Next"),
                  SizedBox(width: 4),
                  Icon(
                    Icons.send,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                ],
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          LinearProgressIndicator(
            value: 0.5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('Step 1: Upload Images'),
          ),
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(color: Colors.grey.shade300),
            ),
          ),
          //photos from device

          ElevatedButton(
            onPressed: getPhotos,
            child: Text("Select Photos"),
          ),

          //selected photos
          GridView.builder(
            shrinkWrap: true,
            itemCount: assets.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemBuilder: (context, index) {
              return AssetThumbnail(
                asset: assets[index],
              );
            },
          ),
        ],
      ),
    );
  }
}

class AssetThumbnail extends StatelessWidget {
  final AssetEntity asset;
  const AssetThumbnail({
    super.key,
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: asset.thumbnailData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.memory(
            snapshot.data!,
            fit: BoxFit.cover,
          );
        }
        return Container();
      },
    );
  }
}
