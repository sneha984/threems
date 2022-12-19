import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../screens/splash_screen.dart';

class ImageZoomPage extends StatefulWidget {
   final String image;
   final String productname;
   final String productprice;
   final String producunit;
   final String productquantity;
   final String productDetails;
  const ImageZoomPage({Key? key, required this.image, required this.productname, required this.productprice, required this.producunit, required this.productquantity, required this.productDetails}) : super(key: key);

  @override
  State<ImageZoomPage> createState() => _ImageZoomPageState();
}

class _ImageZoomPageState extends State<ImageZoomPage> with SingleTickerProviderStateMixin {
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
  Widget build(BuildContext context) {
    return Scaffold(
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
                top: scrHeight * 0.04,
                left: scrWidth * 0.07,
                bottom: scrHeight * 0.02,
                right: scrWidth * 0.05),
            child: SvgPicture.asset(
              "assets/icons/arrow.svg",
            ),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: scrHeight * 0.02),
          child: Text(widget.productname,
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
          Center(
            child:
            InteractiveViewer(
              panEnabled: false, // Set it to false
              // boundaryMargin: EdgeInsets.all(100),
              minScale: 0.5,
              maxScale: 2,
              child: Image.network(
                widget?.image??'',
                width: 400,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),

            // InteractiveViewer(
            //   clipBehavior: Clip.none,
            //   transformationController: controller,
            //   maxScale: maxScale,
            //   minScale: minScale,
            //   onInteractionEnd: (details){
            //     resetAnimation();
            //   },
            //   panEnabled: false,
            //   child: AspectRatio(aspectRatio: 1,child: ClipRRect(
            //   borderRadius: BorderRadius.circular(20),
            //   child: Image.network(widget.image,fit: BoxFit.cover,),
            //
            // ),
            //   ),
            // ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('₹${widget.productprice} Rs',style: TextStyle(
                        fontSize: 18,color: Colors.red,fontWeight: FontWeight.w600,fontFamily: 'Urbanist'
                    ),),
                    Text('${widget.productquantity} ${widget.producunit}',style: TextStyle(
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

                Text(widget?.productDetails??'no Details',style: TextStyle(
                    fontSize: 14,fontWeight: FontWeight.w600,fontFamily: 'Urbanist',color: Colors.grey
                ),)
              ],
            ),
          )


        ],
      ) ,
    );
  }
  // void resetAnimation(){
  //   animation=Matrix4Tween(
  //     begin: controller.value,
  //     end: Matrix4.identity(),
  //   ).animate(CurvedAnimation(parent: animationController, curve: ));
  //   animationController.forward(from: 0);
  // }
}
