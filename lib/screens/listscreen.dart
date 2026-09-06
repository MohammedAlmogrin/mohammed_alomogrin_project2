import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mohammed_almogrin_project2/screens/detailscreen.dart';
import 'package:mohammed_almogrin_project2/screens/favoritesscreen.dart';
import 'package:mohammed_almogrin_project2/services/api.dart';
import 'package:mohammed_almogrin_project2/models/place_iteme.dart';

class Listscreen extends StatefulWidget {
  const Listscreen({super.key});

  @override
  State<Listscreen> createState() => _ListscreenState();
}

class _ListscreenState extends State<Listscreen> {
  late Future<List<PlaceIteme>> _futurePlaces;
  final Api _apiService = Api();

  @override
  void initState() {
    super.initState();
    _futurePlaces = _apiService.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFF121212),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:  Text(
          'Saudi Wonders',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon:  Icon(Icons.bookmark_border_rounded, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoritesScreen()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color:  Color(0xFFC87D55).withOpacity(0.18),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color:  Color(0xFFA66038).withOpacity(0.12),
                shape: BoxShape.circle,
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
            child: Container(color: Colors.transparent),
          ),
          FutureBuilder<List<PlaceIteme>>(
            future: _futurePlaces,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return  Center(
                  child: CircularProgressIndicator(color: Color(0xFFC87D55)),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Icon(Icons.wifi_off_rounded,
                          size: 64, color: Colors.redAccent),
                       SizedBox(height: 12),
                      Text(
                        'Failed to load data: ${snapshot.error}',
                        style:  TextStyle(color: Colors.white),
                      ),
                       SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => setState(
                            () => _futurePlaces = _apiService.getData()),
                        child:  Text('Retry'),
                      )
                    ],
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return  Center(
                  child: Text(
                    'No places found.',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              final places = snapshot.data!;
              return ListView.builder(
                padding:  EdgeInsets.only(
                    top: 110, bottom: 24, left: 16, right: 16),
                itemCount: places.length,
                itemBuilder: (context, index) {
                  final place = places[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            pageId: place.pageId,
                            title: place.title,
                            previewImage: place.thumbnail,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 220,
                      margin:  EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 10,
                            offset:  Offset(0, 5),
                          )
                        ],
                        image: DecorationImage(
                          image: NetworkImage(
                            place.thumbnail ??
                                'https://images.unsplash.com/photo-1548013146-72479768bada?q=80&w=1000',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        padding:  EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.9),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              place.title,
                              style:  TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                             SizedBox(height: 6),
                            Row(
                              children:  [
                                Icon(Icons.location_on,
                                    size: 16, color: Color(0xFFC87D55)),
                                SizedBox(width: 4),
                                Text(
                                  'Saudi Arabia',
                                  style: TextStyle(
                                    color: Color(0xFFC87D55),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Spacer(),
                                Icon(Icons.arrow_forward_rounded,
                                    color: Colors.white70),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}