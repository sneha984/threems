import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../screens/splash_screen.dart';

class StorePage extends StatefulWidget {
  const StorePage({Key? key}) : super(key: key);

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    top: scrHeight * 0.08,
                    left: scrWidth * 0.07,
                  ),
                  child: SvgPicture.asset(
                    "assets/icons/arrow.svg",
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: 15,top:scrHeight * 0.08 ),
                    child: Text(
                      "Bavya Store",
                      style: TextStyle(
                          fontSize: scrWidth * 0.046,
                          color: Colors.black,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 70,top: 40),
                child: Container(
                  height: 89,
                  width: 94,
                  decoration: BoxDecoration(
                    image: DecorationImage(image:
                    NetworkImage("https://cdn.pixabay.com/photo/2016/03/02/20/13/grocery-1232944__340.jpg"),
                        fit: BoxFit.fill),
                    color: Colors.white,

                    borderRadius: BorderRadius.circular(
                        15),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
