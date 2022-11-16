import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threems/ByeandSell/storepage.dart';

import '../screens/splash_screen.dart';
import '../utils/dummy.dart';

class CategoryStores extends StatefulWidget {
  const CategoryStores({Key? key}) : super(key: key);

  @override
  State<CategoryStores> createState() => _CategoryStoresState();
}

class _CategoryStoresState extends State<CategoryStores> {
  List<SubCategory> subcategory=[
    SubCategory(noofproduct: "120 products", storename: "Bavya Store",
        storeimage: "https://cdn.pixabay.com/photo/2016/03/02/20/13/grocery-1232944__340.jpg"),
    SubCategory(noofproduct: "120 products", storename: "Bavya Store",
        storeimage: "https://cdn.pixabay.com/photo/2016/03/02/20/13/grocery-1232944__340.jpg"),
    SubCategory(noofproduct: "120 products", storename: "Bavya Store",
        storeimage: "https://cdn.pixabay.com/photo/2016/03/02/20/13/grocery-1232944__340.jpg"),
    SubCategory(noofproduct: "120 products", storename: "Bavya Store",
        storeimage: "https://cdn.pixabay.com/photo/2016/03/02/20/13/grocery-1232944__340.jpg"),
    SubCategory(noofproduct: "120 products", storename: "Bavya Store",
        storeimage: "https://cdn.pixabay.com/photo/2016/03/02/20/13/grocery-1232944__340.jpg"),


    
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                Padding(
                  padding:  EdgeInsets.only(top: 55,left: 10),
                  child: SvgPicture.asset("assets/icons/grocery.svg",height: 20,width: 20,),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 11,top:scrHeight * 0.08 ),
                  child: Text(
                    "Grocery Stores",
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
              padding:  EdgeInsets.only(right: 170,top: 2 ),
              child: Text(
                "5 Stores available",
                style: TextStyle(
                    fontSize: 10,
                    color: Color(0xff818181),
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(top: 10),
              child: Container(
                height: scrHeight*0.042,
                width: scrWidth*0.9,
                decoration: BoxDecoration(
                    color: Color(0xffE9EEF3),

                    borderRadius: BorderRadius.circular(9)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
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
              padding:  EdgeInsets.only(left: 11,right: 11),
              child: Container(
                height: scrHeight*3,
                child: GridView.builder(
                  shrinkWrap: true,
                  // scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: subcategory.length,
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
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>StorePage()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10),
                            child: Container(
                              height: 80,
                              width: 88,
                              decoration: BoxDecoration(
                                image: DecorationImage(image:
                                NetworkImage(subcategory[index].storeimage),
                                    fit: BoxFit.fill),
                                color: Colors.white,

                                borderRadius: BorderRadius.circular(
                                    15),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 13),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start,
                            children: [
                              SizedBox(height: 5,),
                              Text(
                                subcategory[index].storename, textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff0E0E0E)),),
                              SizedBox(height: 2,),

                              Text(
                                subcategory[index].noofproduct, textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontSize: 10,
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
