import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageData {
  String imageName;
  String imageUrl;

  ImageData({required this.imageName, required this.imageUrl});
}

class SeeDocumentsPage extends StatefulWidget {
  @override
  _SeeDocumentsPageState createState() => _SeeDocumentsPageState();
}

class _SeeDocumentsPageState extends State<SeeDocumentsPage> {
  final Reference storageRef =
      FirebaseStorage.instance.ref().child('User Documents');

  Future<List<ImageData>> getImageData() async {
    List<ImageData> imageDataList = [];

    ListResult result = await storageRef.listAll();

    for (Reference ref in result.items) {
      String imageName = ref.name;
      String imageUrl = await ref.getDownloadURL();
      ImageData imageData = ImageData(imageName: imageName, imageUrl: imageUrl);
      imageDataList.add(imageData);
    }

    return imageDataList;
  }

  void deleteImage(String imageName) async {
    try {
      await storageRef.child(imageName).delete();
      setState(() {});
      print('Image deleted successfully');
    } catch (e) {
      print('Error deleting image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Documents'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<ImageData>>(
        future: getImageData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          List<ImageData>? imageDataList = snapshot.data;

          if (imageDataList == null || imageDataList.isEmpty) {
            return Center(
              child: Text(
                "No Documents Available 🥲",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: imageDataList.length,
              itemBuilder: (context, index) {
                ImageData imageData = imageDataList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullScreenImagePage(
                          imageName: imageData.imageName,
                          imageUrl: imageData.imageUrl,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue,
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(0),
                            child: Image.network(
                              imageData.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => deleteImage(imageData.imageName),
                          child: Container(
                            padding: EdgeInsets.only(left: 25),
                            height: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8)),
                              color: Colors.red,
                            ),
                            child: const Row(children: [
                              SizedBox(width: 20),
                              Text(
                                "Remove",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.remove_circle_outline_sharp,
                                size: 20,
                              )
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class FullScreenImagePage extends StatefulWidget {
  final String imageName;
  final String imageUrl;

  FullScreenImagePage({required this.imageName, required this.imageUrl});

  @override
  State<FullScreenImagePage> createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.imageName),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: widget.imageUrl,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7),
                child: Image.network(
                  widget.imageUrl,
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
