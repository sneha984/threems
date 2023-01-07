import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threems/Buy&sell/storepage.dart';
import 'package:threems/Buy&sell/zoom.dart';
import 'package:threems/kuri/createkuri.dart';
import 'package:threems/utils/themes.dart';

import '../model/Buy&sell.dart';
import '../screens/splash_screen.dart';
import 'checkout.dart';

class ImageZoomPage extends StatefulWidget {
  final ProductModel pro;
  final String storeId;
  final double deliveryCharge;
   final String image;
   final bool on;
   // final String productname;
   // final String productprice;
   // final String producunit;
   // final String productquantity;
   // final String productDetails;
   // final String productId;
  const ImageZoomPage({Key? key, required this.image, required this.storeId, required this.pro, required this.deliveryCharge, required this.on}) : super(key: key);

  @override
  State<ImageZoomPage> createState() => _ImageZoomPageState();
}

class _ImageZoomPageState extends State<ImageZoomPage> with SingleTickerProviderStateMixin {



  bool isCarted = false;
  int qty = 1;

  bool shop=false;
  bool prd=false;

  getProduct() {
    FirebaseFirestore
    .instance
    .collection('stores')
    .doc(widget.storeId)
    .snapshots()
    .listen((event) {
      shop=event['online'];
      if(mounted){
        setState(() {

        });
      }
    });

    FirebaseFirestore
        .instance
        .collection('stores')
        .doc(widget.storeId)
        .collection('products')
        .doc(widget.pro.productId)
        .snapshots()
        .listen((event) {
      prd=event['available'];
      if(mounted){
        setState(() {

        });
      }
    });

    for (int i = 0; i < cartlist.length; i++) {
      if (cartlist[i]['productId'] == widget.pro.productId &&
          cartlist[i]['storeId'] == widget.storeId) {
        isCarted = true;
      }
    }
    setState(() {});
  }

 
  // getEachProduct(){
  //   FirebaseFirestore
  //       .instance
  //       .collection('stores')
  //       .doc(widget.storeId)
  //       .collection('products')
  //       .doc(widget.pro.productId).snapshots().listen((event) {
  //         for(DocumentSnapshot <Map<String,dynamic>>)
  //
  //   });
  // }
  // final double minScale=1;
  // final double maxScale=4;
  // late TransformationController controller;
  // late AnimationController animationController;
  // late Animation<Matrix4> animation;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   controller=TransformationController();
  //   animationController=AnimationController(vsync: this,duration: Duration(milliseconds: 200))..addListener(() =>controller.value=animation!.value);
  //
  // }
  // @override
  // void dispose(){
  //   controller.dispose();
  //   animationController.dispose();
  //   super.dispose();
  // }
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    getProduct();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 84,
        shadowColor: Colors.grey,
        centerTitle: false,
        elevation: 0.1,
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.only(
               top: scrHeight * 0.02,
               left: scrWidth * 0.04,
              // bottom: scrHeight * 0.02,
                right: scrWidth * 0.04),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 25,
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: scrHeight * 0.02),
          child: Text(widget.pro.productName??'',
            style: TextStyle(
                fontSize: scrWidth * 0.045,
                color: Colors.black,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.w700),
          ),
        ),

      ),

      body:Column(
        children: [

          SizedBox(height: 67,),
          InkWell(
            onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>ZoomPage(img: widget.image,)));
            },
            child: Center(
              child:Container(
                   width: scrWidth*1,
                height: scrHeight*0.38,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:widget.image,
                ),
              ),
              // Image.network(
              //   widget?.image??'',
              //   width: scrWidth*1,
              //   height: scrHeight*0.38,
              //   fit: BoxFit.cover,
              // ) ,
            ),
          ),
          // Center(
          //   child:InteractiveViewer(
          //     panEnabled: false, // Set it to false to prevent panning.
          //     boundaryMargin: EdgeInsets.all(80),
          //     minScale: 0.5,
          //     maxScale: 4,
          //     child:Image.network(
          //           widget?.image??'',
          //           width: 400,
          //           height: 300,
          //           fit: BoxFit.cover,
          //         ),
          //   ),
          //   // InteractiveViewer(
          //   //   panEnabled: false, // Set it to false
          //   //   // boundaryMargin: EdgeInsets.all(100),
          //   //   minScale: 0.5,
          //   //   maxScale: 2,
          //   //   child: Image.network(
          //   //     widget?.image??'',
          //   //     width: 400,
          //   //     height: 300,
          //   //     fit: BoxFit.cover,
          //   //   ),
          //   // ),
          //
          //   // InteractiveViewer(
          //   //   clipBehavior: Clip.none,
          //   //   transformationController: controller,
          //   //   maxScale: maxScale,
          //   //   minScale: minScale,
          //   //   onInteractionEnd: (details){
          //   //     resetAnimation();
          //   //   },
          //   //   panEnabled: false,
          //   //   child: AspectRatio(aspectRatio: 1,child: ClipRRect(
          //   //   borderRadius: BorderRadius.circular(20),
          //   //   child: Image.network(widget.image,fit: BoxFit.cover,),
          //   //
          //   // ),
          //   //   ),
          //   // ),
          // ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('₹${widget.pro.price} Rs',style: TextStyle(
                        fontSize: 18,color: Colors.red,fontWeight: FontWeight.w600,fontFamily: 'Urbanist'
                    ),),
                    Text('${widget.pro.quantity} ${widget.pro.unit}',style: TextStyle(
                        fontSize: 18,fontWeight: FontWeight.w600,fontFamily: 'Urbanist'
                    ),),
                  ],
                ),


                // Text("Product Details"),
                SizedBox(height: 10,),
                Text('Details:-',style: TextStyle(
                    fontSize: 19,fontWeight: FontWeight.w600,fontFamily: 'Urbanist',
                ),),
                SizedBox(height: 15,),

                Text(widget?.pro.details??'no Details',style: TextStyle(
                    fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'Urbanist',color: Colors.grey
                ),)
              ],
            ),
          ),SizedBox(
            height: 70,
          ),

          // Container(
          //   height: 70,
          //   width: 170,
          //   decoration: BoxDecoration(
          //       color: primarycolor,
          //
          //       borderRadius: BorderRadius.circular(15)
          //   ),
          //   child: Center(
          //     child: Text("Add To Cart",style: TextStyle(color: Colors.white),),
          //   ),
          // )
          shop==true&&prd==true?
          isCarted
              ? InkWell(
                onTap: () {


                  setState(() {});
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => CheckOutPage()));

                },
                child: Container(
                  width: scrWidth * 0.55,
                  height: scrHeight * 0.06,
                  decoration: BoxDecoration(
                    // color: Colors.red,
                      color: Color(0xff02B558),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),topLeft: Radius.circular(8),
                          bottomLeft: Radius.circular(8))),
                  child:Center(
                    child: Text(
                      "Go To Cart",
                      style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                ),
              )
              :
          InkWell(
            onTap: () async {
              if (cartlist.isEmpty) {
                addToCart(widget.pro, widget.storeId);
                isCarted = true;
              } else if (cartlist[0]['storeId'] ==
                  widget.pro.storeId ) {

                addToCart(widget.pro, widget.storeId);

                isCarted = true;
              }
              else {
                bool? pressed = await cartAlert();

                if (pressed == true) {
                  cartlist = [];
                  addToCart(widget.pro, widget.storeId);
                  isCarted = true;
                }
              }

              setState(() {});
            },
            child: Container(
              width: scrWidth * 0.55,
              height: scrHeight * 0.06,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xff02B558)
                // color: Colors.red
              ),
              child: Center(
                child: Text(
                  "Add",
                  style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white),
                ),
              ),
            ),
          ):Container(
            width: scrWidth * 0.55,
            height: scrHeight * 0.06,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey
              // color: Colors.red
            ),
            child: Center(
              child: Text(
                "Out Of Stock",
                style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white),
              ),
            ),
          ),


        ],
      ) ,
    );
  }
  addToCart(ProductModel products, String storeId) {
    cartlist.add({
      'img': products.images![0],
      'name': products.productName,
      'price': products.price,
      'unit': products.unit,
      'deliveryCharge': widget.deliveryCharge,
      'storeId': storeId,
      'productId': products.productId,
      'quantity': products.quantity,
      'count': 1,
      'storeAvailable':widget.on,
      'productAvailable':products.available
    });

    final snackBar = SnackBar(
      backgroundColor: Colors.white,
      content: const Text(
        ' item added to cart',
        style: TextStyle(color: Colors.black),
      ),
      action: SnackBarAction(
        textColor: Colors.blue,
        label: 'Go To Cart',
        onPressed: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => CheckOutPage()));
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }


  Future<bool?> cartAlert() => showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (BuildContext context, setstate) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),
          title: Text('Confirm'),
          titleTextStyle: TextStyle(
              fontSize: FontSize10 * 3,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.w600,
              color: Color(0xff827C7C)),
          content: Container(
            width: scrWidth * 0.99,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    'Your cart contains products in another store , \n Do you wish to remove and add this product.'),
                SizedBox(
                  height: scrWidth * 0.06,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context, false),
                      child: Container(
                        width: scrWidth * 0.2,
                        height: textFormFieldHeight45,
                        decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: GestureDetector(
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  fontSize: FontSize16,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context, true),
                      child: Container(
                        width: scrWidth * 0.3,
                        height: textFormFieldHeight45,
                        decoration: BoxDecoration(
                            color: primarycolor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                          child: GestureDetector(
                            child: Text(
                              "Add",
                              style: TextStyle(
                                  fontSize: FontSize16,
                                  fontFamily: 'Urbanist',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ),
  );


// void resetAnimation(){
  //   animation=Matrix4Tween(
  //     begin: controller.value,
  //     end: Matrix4.identity(),
  //   ).animate(CurvedAnimation(parent: animationController, curve: ));
  //   animationController.forward(from: 0);
  // }
}
