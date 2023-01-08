import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threems/Authentication/root.dart';
import 'package:threems/Buy&sell/storepage.dart';


import '../model/Buy&sell.dart';
import '../model/usermodel.dart';
import '../screens/splash_screen.dart';
import '../utils/dummy.dart';
List<StoreDetailsModel> filteredShops=[];
List<StoreDetailsModel> shops=[];
class CategoryStores extends StatefulWidget {
  String categoryname;
  String categoryImage;
   CategoryStores({Key? key,required this.categoryname,required this.categoryImage}) : super(key: key);

  @override
  State<CategoryStores> createState() => _CategoryStoresState();
}

class _CategoryStoresState extends State<CategoryStores> {
  String name="";
  List <Map<String,dynamic>> data=[];
  TextEditingController search=TextEditingController();
  getStores(){
    FirebaseFirestore
        .instance
        .collection('stores')
        .where('storeCategory',arrayContains:widget.categoryname )
        .where("userId",isNotEqualTo: currentuserid)
        .snapshots()
        .listen((event) {
      filteredShops=[];
      shops=[];
      for(DocumentSnapshot <Map<String,dynamic>> doc in event.docs){
        filteredShops.add(StoreDetailsModel.fromJson(doc.data()!));
        shops.add(StoreDetailsModel.fromJson(doc.data()!));
      }
      if(mounted){
        setState(() {
          print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
          print(filteredShops.length);
          print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');

        });
      }
    });
  }
  getProducts(){
    FirebaseFirestore
        .instance
        .collection('stores')
        .doc(shops[0].storeId)
        .collection('products')
        .where('storedCategorys',isEqualTo: widget.categoryname)
        .snapshots().listen((event) {
      productsList=[];
      for(DocumentSnapshot <Map<String,dynamic>> doc in event.docs){
        productsList.add(ProductModel.fromJson(doc.data()!));
      }
      if(mounted){
        setState(() {
        });
      }
    });
  }




  getSearchedData(String str){
    filteredShops=[];
    for(var shop in shops){
      if(shop.storeName!.contains(str)){
        filteredShops.add(shop);
      }
    }
    setState(() {

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
                       top: scrHeight * 0.076,
                       left: scrWidth * 0.05,
                       bottom: scrHeight * 0.01,
                        right: scrWidth * 0.04),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 25,
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: scrHeight*0.07,left:scrWidth*0.03),
                  child: SvgPicture.network(widget.categoryImage,height: 25,width: 25,),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: scrWidth*0.02,top:scrHeight * 0.07 ),
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
                "${filteredShops.length} Stores available",
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
                    onChanged: (val){
                      setState((){
                        filteredShops.clear();
                        if(search.text==''){
                          filteredShops.addAll(shops);
                        }else{
                          getSearchedData(search.text);
                        }
                      });
                    },
                    controller: search,
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
            Container(
              child: GridView.builder(
                shrinkWrap: true,
                // scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filteredShops.length,
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 3 / 3.1,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 20,
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  final shoplist=filteredShops[index];
                  return  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>
                              StorePage(storeDetailsModel: shoplist, category: widget.categoryname,)));
                        },
                        child: Padding(
                          padding:  EdgeInsets.only(
                              left: scrWidth*0.03),
                          child: Container(
                            height: scrHeight*0.1,
                            width:scrWidth*0.25,
                            decoration: BoxDecoration(
                              image: DecorationImage(image:
                              CachedNetworkImageProvider(shoplist.storeImage??''),
                                  fit: BoxFit.fill,colorFilter:shoplist.online!?
                                  ColorFilter.mode(Colors.transparent, BlendMode.saturation):
                                  ColorFilter.mode(Colors.grey, BlendMode.saturation)),

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
                            Container(
                              width: 80,
                              child: Text(
                                shoplist.storeName!, textAlign: TextAlign.center,
                                style: TextStyle(overflow: TextOverflow.ellipsis,
                                    fontFamily: 'Urbanist',
                                    fontSize: scrWidth*0.036,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff0E0E0E)),),
                            ),
                            SizedBox(height: scrHeight*0.002,),

                            // Text(
                            //   "${productsList.length} products"
                            //   , textAlign: TextAlign.center,
                            //   style: TextStyle(
                            //       fontFamily: 'Urbanist',
                            //       fontSize: scrWidth*0.025,
                            //       fontWeight: FontWeight.w600,
                            //       color: Color(0xff818181)),),

                          ],
                        ),
                      ),

                    ],
                  );
                },
              ),

              // StreamBuilder<QuerySnapshot>(
              //   stream: FirebaseFirestore
              //       .instance
              //       .collection('stores')
              //       .where('storeCategory',arrayContains:widget.categoryname)
              //       .where('userId',isNotEqualTo: currentuserid)
              //       .snapshots(),
              //   builder: (context,snapshot){
              //     return (snapshot.connectionState==ConnectionState.waiting)?Center(
              //       child: CircularProgressIndicator(),
              //     ):
              //     GridView.builder(
              //         itemCount:shops.length,
              //         scrollDirection: Axis.vertical,
              //         physics: BouncingScrollPhysics(),
              //         shrinkWrap: true,
              //         itemBuilder: (context,index){
              //           var data=shops[index];
              //           if(search.text.isEmpty){
              //             return Padding(
              //               padding:  EdgeInsets.only(left: scrWidth*0.03,right: scrWidth*0.03),
              //               child: Container(
              //                 height: scrHeight*3,
              //                 child: ,
              //               ),
              //             );
              //           }
              //           if(data.storeName.toString().startsWith(name.toLowerCase() )){
              //             return Column(
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 InkWell(
              //                   onTap: (){
              //                     Navigator.push(context,MaterialPageRoute(builder: (context)=>StorePage(storeDetailsModel: data, category: widget.categoryname,)));
              //                   },
              //                   child: Padding(
              //                     padding:  EdgeInsets.only(
              //                         left: scrWidth*0.03),
              //                     child: Container(
              //                       height: scrHeight*0.1,
              //                       width:scrWidth*0.25,
              //                       decoration: BoxDecoration(
              //                         image: DecorationImage(image:
              //                         NetworkImage(data.storeImage??''),
              //                             fit: BoxFit.fill),
              //                         color: Colors.white,
              //
              //                         borderRadius: BorderRadius.circular(
              //                             scrWidth*0.03),
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //                 Padding(
              //                   padding: EdgeInsets.only(left: scrWidth*0.04),
              //                   child: Column(
              //                     crossAxisAlignment: CrossAxisAlignment
              //                         .start,
              //                     children: [
              //                       SizedBox(height: scrHeight*0.003,),
              //                       Text(
              //                         data.storeName!, textAlign: TextAlign.center,
              //                         style: TextStyle(
              //                             fontFamily: 'Urbanist',
              //                             fontSize: scrWidth*0.036,
              //                             fontWeight: FontWeight.w600,
              //                             color: Color(0xff0E0E0E)),),
              //                       SizedBox(height: scrHeight*0.002,),
              //
              //                       Text(
              //                         "${productsList.length} products"
              //                         , textAlign: TextAlign.center,
              //                         style: TextStyle(
              //                             fontFamily: 'Urbanist',
              //                             fontSize: scrWidth*0.025,
              //                             fontWeight: FontWeight.w600,
              //                             color: Color(0xff818181)),),
              //
              //                     ],
              //                   ),
              //                 ),
              //
              //               ],
              //             );
              //           }
              //           return Container();
              //         }, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),);
              //
              //   },
              // ),
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




          ],
        ),
      ),

    );
  }
}
