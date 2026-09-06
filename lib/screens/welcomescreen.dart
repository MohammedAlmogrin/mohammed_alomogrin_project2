import 'package:flutter/material.dart';
import 'package:mohammed_almogrin_project2/screens/listscreen.dart'; 

class Welcomescreen extends StatelessWidget {
  const Welcomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://static.sayidaty.net/2025-04/421152.jpg?VersionId=HACb49awV3rF4qADcyTl4Bghvs3XNGY6',
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.85),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                   Text(
                    'Discover\n Saudi Heritage',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.w500,
                      height: 1.1,
                    ),
                  ),
                   SizedBox(height: 10),
                   Text(
                    'Uncover thousands of years of rich history\n and archaeological wonders',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                   SizedBox(height: 25),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.2),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Listscreen(),)
                        );
                      },
                      child:  Text('Get Started'),
                    ),
                  ),
                   SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}