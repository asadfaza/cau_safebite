import 'dart:typed_data';
import 'package:cau_safebite/auth/widgets_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class FavoritePage extends StatefulWidget {
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  String? email;
  List<dynamic> favoriteItems = [];
  bool isLoading = true;
  List<Map<String, dynamic>> imageList = [];

  @override
  void initState() {
    super.initState();
    email = FirebaseAuth.instance.currentUser!.email;
    fetchFavorites();
  }

  Future<void> fetchFavorites() async {
    try {
      CollectionReference favorites =
          FirebaseFirestore.instance.collection('favorites');
      DocumentSnapshot doc = await favorites.doc(email).get();

      // Extract the 'favorites' field if it exists
      setState(() {
        favoriteItems = (doc.get('favorites') as List<dynamic>?) ?? [];
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        favoriteItems = [];
      });
      print("Error fetching favorites: $e");
    }
  }

  Future<void> removeFromFavorites(
      String email, Map<String, dynamic> item) async {
    try {
      CollectionReference favorites =
          FirebaseFirestore.instance.collection('favorites');
      await favorites.doc(email).update({
        'favorites': FieldValue.arrayRemove([item])
      });

      // Update the UI by removing the item locally
      setState(() {
        favoriteItems.remove(item);
      });
    } catch (e) {
      print("Error removing favorite: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Favorite list',
          style: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
        backgroundColor: bColor,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            height: screenSize.height * 0.4,
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: firstColor,
                    ),
                  )
                : favoriteItems.isEmpty
                    ? Center(
                        child: Text(
                          'No favorites added.',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: favoriteItems.length,
                        itemBuilder: (context, index) {
                          var item = favoriteItems[index];
                          return ListTile(
                            leading: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10)),
                            ),

                            // ClipRRect(
                            //     borderRadius: BorderRadius.circular(8),
                            //     child: Image.network(item['imageUrl'])),
                            title: Text(item['title']),
                            subtitle: Text(item['category']),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () =>
                                  removeFromFavorites(email!, item),
                            ),
                          );
                        },
                      ),
          ),
          Row(
              children: [
                SizedBox(width: 15),
                Text(
                  'Computer vision model',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(width: 15),
                Text(
                  'Try it by yourself',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,),
                ),
              ],
            ),
          Container(
            height: screenSize.height *0.2,
            child: imageList.isEmpty
                ? Center(
                    child: Text(
                      "No images added yet.\nClick the camera icon to add an image.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: imageList.length,
                    itemBuilder: (context, index) {
                      var image = imageList[index];
          
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.memory(
                            image['imageData'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(image['title']),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              imageList.removeAt(index); // Remove from list
                            });
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'Camera') {
              pickImage(ImageSource.camera); // Open camera
            } else if (value == 'Gallery') {
              pickImage(ImageSource.gallery); // Open file picker
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'Camera',
              child: Text('Capture with Camera'),
            ),
            PopupMenuItem(
              value: 'Gallery',
              child: Text('Select from Files'),
            ),
          ],
          icon: Icon(Icons.add_a_photo),
        ),
        backgroundColor: secondColor,
      ),
    );
  }

  /// Picks an image from the file picker or captures via the camera
  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      Uint8List imageData = await pickedFile.readAsBytes();

      setState(() {
        // Add the image data and a placeholder title
        imageList.add({
          "imageData": imageData,
          "title": "Untitled Image ${imageList.length + 1}",
        });
      });
    }
  }
}
