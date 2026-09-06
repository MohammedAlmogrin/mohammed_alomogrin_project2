import 'package:flutter/material.dart';
import 'package:mohammed_almogrin_project2/models/place_iteme.dart';
import 'package:mohammed_almogrin_project2/screens/detailscreen.dart';
import 'package:mohammed_almogrin_project2/screens/favoritesmanager.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    List<PlaceIteme> favorites = FavoritesManager.favoritePlaces;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:  Text("Your Travel Wishlist"),
      ),
      body: favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:  EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF10B981).withOpacity(0.1),
                    ),
                    child:  Icon(
                      Icons.bookmark_added_rounded,
                      size: 64,
                      color: Color(0xFF10B981),
                    ),
                  ),
                   SizedBox(height: 20),
                   Text(
                    'Your Travel Wishlist',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                   SizedBox(height: 8),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Places you bookmark will appear here for quick access during your trips.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[400], fontSize: 14),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                PlaceIteme item = favorites[index];
                return Card(
                  color: Colors.grey[900],
                  margin:  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: item.thumbnail != null
                        ? Image.network(
                            item.thumbnail!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        :  Icon(Icons.image, color: Colors.white),
                    title: Text(
                      item.title ?? " ",
                      style:  TextStyle(color: Colors.white),
                    ),
                    trailing: IconButton(
                      icon:  Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          FavoritesManager.toggleFavorite(item);
                        });
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            pageId: item.pageId!,
                            title: item.title ?? " ",
                            previewImage: item.thumbnail,
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