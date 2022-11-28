import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threems/Authentication/root.dart';
import 'package:threems/Buy&sell/storepage.dart';


import '../model/Buy&sell.dart';
import '../model/usermodel.dart';
import '../screens/splash_screen.dart';
import '../utils/dummy.dart';
List<StoreDetailsModel> shops=[];
class CategoryStores extends StatefulWidget {
  String categoryname;
   CategoryStores({Key? key,required this.categoryname}) : super(key: key);

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
  getStores(){
    FirebaseFirestore
        .instance
        .collection('stores')
        .where('storeCategory',arrayContains:widget.categoryname )
        .snapshots()
        .listen((event) {
      shops=[];
      for(DocumentSnapshot <Map<String,dynamic>> doc in event.docs){
        shops.add(StoreDetailsModel.fromJson(doc.data()!));
      }
      if(mounted){
        setState(() {
          print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
        print(shops.length);
          print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');

        });
      }
    });
  }
  @override
  void initState() {
    getStores();
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose(){
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                      height: scrHeight*0.04,
                      width: scrWidth*0.04,
                      child: SvgPicture.asset(
                        "assets/icons/arrow.svg",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: scrHeight*0.078,left:scrWidth*0.03),
                  child: SvgPicture.asset("assets/icons/grocery.svg",height: 25,width: 25,),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: scrWidth*0.02,top:scrHeight * 0.08 ),
                  child: Text(
                    widget.categoryname,
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
              padding:  EdgeInsets.only(right: scrWidth*0.5,top: scrHeight*0.001 ),
              child: Text(
                "${shops.length} Stores available",
                style: TextStyle(
                    fontSize: scrWidth*0.026,
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
            // StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
            //   stream: FirebaseFirestore
            //       .instance
            //       .collection('stores')
            //       .where('userId',isEqualTo: currentuserid)
            //       .where('categoryName',isEqualTo:),
            //     builder:(context,snapshot){
            //     return GridView.builder(gridDelegate: gridDelegate, itemBuilder: itemBuilder)
            //
            //     }
            // ),
            Padding(
              padding:  EdgeInsets.only(left: scrWidth*0.03,right: scrWidth*0.03),
              child: Container(
                height: scrHeight*3,
                child: GridView.builder(
                  shrinkWrap: true,
                  // scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: shops.length,
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 3 / 3.1,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 20,
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    final shoplist=shops[index];
                    return  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>StorePage(storeDetailsModel: shoplist, category: widget.categoryname,)));
                          },
                          child: Padding(
                            padding:  EdgeInsets.only(
                                left: scrWidth*0.03),
                            child: Container(
                              height: scrHeight*0.1,
                              width:scrWidth*0.25,
                              decoration: BoxDecoration(
                                image: DecorationImage(image:
                                NetworkImage(shoplist.storeImage??''),
                                    fit: BoxFit.fill),
                                color: Colors.white,

                                borderRadius: BorderRadius.circular(
                                    scrWidth*0.03),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: scrWidth*0.04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start,
                            children: [
                              SizedBox(height: scrHeight*0.003,),
                              Text(
                                shoplist.storeName!, textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontSize: scrWidth*0.036,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff0E0E0E)),),
                              SizedBox(height: scrHeight*0.002,),

                              Text(
                                "${productsList.length} products"
                                    , textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontSize: scrWidth*0.025,
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
            ),
          


          ],
        ),
      ),

    );
  }
}
