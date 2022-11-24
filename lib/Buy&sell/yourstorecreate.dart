import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../screens/splash_screen.dart';
import '../utils/dummy.dart';

class YourStoreCreatePage extends StatefulWidget {
  const YourStoreCreatePage({Key? key}) : super(key: key);

  @override
  State<YourStoreCreatePage> createState() => _YourStoreCreatePageState();
}

class _YourStoreCreatePageState extends State<YourStoreCreatePage> {
  List<NearStore> nearstore=[
    NearStore(image:"https://cdn.pixabay.com/photo/2016/03/02/20/13/grocery-1232944__340.jpg",
        storename: "Bavya Store", category: "Grocery Stores"),
    NearStore(image:"https://cdn.pixabay.com/photo/2016/03/02/20/13/grocery-1232944__340.jpg",
        storename: "Bavya Store", category: "Grocery Stores"),
    NearStore(image:"https://cdn.pixabay.com/photo/2016/03/02/20/13/grocery-1232944__340.jpg",
        storename: "Bavya Store", category: "Grocery Stores"),
    NearStore(image:"https://cdn.pixabay.com/photo/2016/03/02/20/13/grocery-1232944__340.jpg",
        storename: "Bavya Store", category: "Grocery Stores"),
    NearStore(image:"https://cdn.pixabay.com/photo/2016/03/02/20/13/grocery-1232944__340.jpg",
        storename: "Bavya Store", category: "Grocery Stores"),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: scrHeight * 0.08,
                        left: scrWidth * 0.07,
                        ),
                    child: Container(
                      height: scrHeight*0.02,
                      width: scrWidth*0.045,
                      child: SvgPicture.asset(
                        "assets/icons/arrow.svg",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: scrWidth*0.03,top:scrHeight * 0.08 ),
                  child: Text(
                    "View All Nearest Stores",
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
              padding:  EdgeInsets.only(right: scrWidth*0.46,top: scrHeight*0.001 ),
              child: Text(
                "56 Stores available",
                style: TextStyle(
                    fontSize: scrWidth*0.025,
                    color: Color(0xff818181),
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: scrHeight*0.015),
              child: Container(
                height: scrHeight*0.042,
                width: scrWidth*0.9,
                decoration: BoxDecoration(
                    color: Color(0xffE9EEF3),

                    borderRadius: BorderRadius.circular(scrWidth*0.03)
                ),
                child: Padding(
                  padding:  EdgeInsets.only(bottom: 5),
                  child: TextFormField(
                    decoration:  InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                              top: scrHeight*0.015,
                              left: scrWidth*0.04,
                              bottom: scrHeight*0.01,
                              right: scrWidth*0.05),
                          child:SvgPicture.asset("assets/icons/Vector (4).svg",),
                        ),
                        border: InputBorder.none,
                        hintText: "Search Stores",
                        hintStyle: TextStyle(
                          fontFamily: 'Urbanist',fontWeight: FontWeight.w500,
                          fontSize: scrWidth*0.03,
                          color: Color(0xff8391A1),
                        )
                    ),
                    cursorColor: Colors.black,
                    cursorHeight: 20,
                    cursorWidth: 0.5,

                  ),
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: scrWidth*0.03,right:scrWidth*0.03),
              child: Container(
                height: scrHeight*3,
                child: GridView.builder(
                   shrinkWrap: true,
                  // scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: nearstore.length,
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 3 / 3.1,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 20,
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          child: Padding(
                            padding:  EdgeInsets.only(
                                left: scrWidth*0.03),
                            child: Container(
                              height: scrHeight*0.1,
                              width: scrWidth*0.25,
                              decoration: BoxDecoration(
                                image: DecorationImage(image:
                                NetworkImage(nearstore[index].image),
                                    fit: BoxFit.fill),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(scrWidth*0.025),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.only(left: scrWidth*0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start,
                            children: [
                              SizedBox(height: scrHeight*0.001,),

                              Text(
                                nearstore[index].storename, textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontSize: scrWidth*0.033,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff0E0E0E)),),
                              SizedBox(height: scrHeight*0.001,),
                              Text(
                               nearstore[index].category, textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontSize: scrHeight*0.01,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff818181)),),

                            ],
                          ),
                        ),

                      ],
                    );


                  },
                ),
              ),
            )


          ],
        ),
      ),
    );
  }
}
