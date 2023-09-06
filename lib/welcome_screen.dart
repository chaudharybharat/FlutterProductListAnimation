import 'package:flutter/material.dart';
import 'package:untitled1/product_list_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: GestureDetector(
      onVerticalDragUpdate: (details) {
        Navigator.of(context).push(PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 650),
            pageBuilder: (context, animation, _) {
              return FadeTransition(
                opacity: animation,
                child: const ProductListScreen(),
              );
            }));
      },
      child: Stack(
        children: [
          const SizedBox.expand(
            child: DecoratedBox(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0XFFA89276), Colors.white])),
            ),
          ),
          Positioned(
              height: size.height * 0.4,
              left: 0,
              right: 0,
              top: size.height * 0.15,
              child: Hero(
                tag: "7",
                child: Image.asset("assets/images/2.png"),
              )),
          Positioned(
              height: size.height * 0.7,
              left: 0,
              right: 0,
              bottom: 0,
              child: Hero(
                tag: "3",
                child: Image.asset("assets/images/3.png"),
              )),
          Positioned(
              height: size.height,
              left: 0,
              right: 0,
              bottom: -size.height * 0.8,
              child: Hero(
                tag: "8",
                child: Image.asset(
                  "assets/images/8.png",
                  fit: BoxFit.cover,
                ),
              ))
        ],
      ),
    ));
  }
}
