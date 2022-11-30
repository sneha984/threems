import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threems/Authentication/root.dart';
import 'package:threems/Buy&sell/buy_and_sell.dart';
import 'package:threems/Buy&sell/productaddingpage.dart';
import 'package:threems/Buy&sell/storedetailsfill2.dart';

import '../screens/splash_screen.dart';
import '../utils/themes.dart';

class ProductsPage extends StatefulWidget {
  final String storeId;
  const ProductsPage({Key? key, required this.storeId,}) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        toolbarHeight: 84,
        shadowColor: Colors.grey,
        centerTitle: false,
        elevation: 0.1,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(
                top: scrHeight * 0.03,
                left: scrWidth * 0.05,
                bottom: scrHeight * 0.01,
                right: scrWidth * 0.05),
            child: SvgPicture.asset(
              "assets/icons/arrow.svg",
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: scrHeight * 0.02),
          child: Text(
            "Products",
            style: TextStyle(
                fontSize: scrWidth * 0.047,
                color: Colors.black,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w700),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
                right: scrWidth * 0.04,
                top: scrHeight * 0.045,
                bottom: scrHeight * 0.025),
            child: InkWell(
              onTap: () {
                 Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProductAddingPage(storeId: widget.storeId)));
              },
              child: Container(
                height: scrHeight * 0.07,
                width: scrWidth * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(scrWidth * 0.04),
                  color: primarycolor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add,
                      size: 12,
                      color: Colors.white,
                    ),
                    Text(
                      "Product",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: CreateChitFont,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 600,
            child: ListView.builder(
              itemCount:products.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding:  EdgeInsets.only(left: 20,right: 20,top: 18),
                    child:   Container(

                      height: scrHeight*0.12,
                      width: scrWidth*0.88,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(width: scrWidth*0.008,),
                          Container(
                            width: scrWidth*0.3,
                            height: scrHeight*0.1,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(products[index]['images'][0]),fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey,

                            ),
                          ),


                          SizedBox(width:scrWidth*0.06),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: scrHeight*0.015,),
                              Container(
                                width:  scrWidth*0.4,
                                child: Text(products[index]['productName'],style: TextStyle(
                                    fontSize: scrWidth*0.033,
                                    color: Colors.black,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.w600),),
                              ),
                              SizedBox(height: scrHeight*0.015,),
                              Text(products[index]['price'].toString(),style: TextStyle(
                                  fontSize: scrWidth*0.033,
                                  color: Colors.black,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600),),
                              SizedBox(height: scrHeight*0.015,),

                              Text("${products[index]['quantity']} ${products[index]['unit']}",style: TextStyle(
                                  fontSize: scrWidth*0.033,
                                  color: Colors.black,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600),),

                            ],
                          ),
                          // IconButton(onPressed: (){}, icon:Icon(Icons.delete))
                        ],
                      ),
                    ),
                  );
                }),
          )

        ],
      ),

    );
  }
}
